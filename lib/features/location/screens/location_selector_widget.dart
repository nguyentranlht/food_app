import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:itc_food/features/location/location_bloc/location_bloc.dart';
import 'package:itc_food/features/location/location_bloc/location_event.dart';
import 'package:itc_food/features/location/location_bloc/location_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itc_food/router/routers.dart';
import 'package:go_router/go_router.dart';

class LocationSelectorWidget extends StatefulWidget {
  final Function(LatLng latLng, String address)? onLocationSelected;
  final bool showMap;
  final String? initialAddress;
  final LatLng? initialLocation;

  const LocationSelectorWidget({
    super.key,
    this.onLocationSelected,
    this.showMap = false,
    this.initialAddress,
    this.initialLocation,
  });

  @override
  State<LocationSelectorWidget> createState() => _LocationSelectorWidgetState();
}

class _LocationSelectorWidgetState extends State<LocationSelectorWidget> {
  late final LocationBloc _locationBloc;
  String _currentAddress = 'Vị trí của bạn chưa được xác định';
  LatLng? _currentLocation;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _locationBloc = context.read<LocationBloc>();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    setState(() {
      _loading = true;
    });

    // Nếu có vị trí ban đầu, sử dụng nó
    if (widget.initialLocation != null && widget.initialAddress != null) {
      _locationBloc.add(LocationSelect(
        widget.initialLocation!,
        widget.initialAddress!,
      ));
      setState(() {
        _currentLocation = widget.initialLocation;
        _currentAddress = widget.initialAddress!;
        _loading = false;
      });
    } else {
      // Nếu không có vị trí ban đầu, chỉ cập nhật trạng thái loading
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _openLocationPicker() async {
    Position? initialPosition;
    if (_currentLocation != null) {
      initialPosition = Position(
        latitude: _currentLocation!.latitude,
        longitude: _currentLocation!.longitude,
        timestamp: DateTime.now(),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
      );
    }

    final result = await context.push(
      RoutesPages.locationPicker,
      extra: initialPosition,
    );

    if (result != null && result is Map<String, dynamic> && 
        result.containsKey('latLng') && result.containsKey('address')) {
      final latLng = result['latLng'] as LatLng;
      final address = result['address'] as String;
      
      _locationBloc.add(LocationSelect(latLng, address));
      
      setState(() {
        _currentLocation = latLng;
        _currentAddress = address;
      });

      // Thông báo cho parent widget nếu có callback
      if (widget.onLocationSelected != null) {
        widget.onLocationSelected!(_currentLocation!, _currentAddress);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      bloc: _locationBloc,
      listener: (context, state) {
        if (state.status == LocationStatus.success && 
            state.currentLocation != null && 
            state.currentAddress != null) {
          setState(() {
            _currentLocation = state.currentLocation;
            _currentAddress = state.currentAddress!;
            _loading = false;
          });
          
          // Thông báo cho parent widget nếu có callback
          if (widget.onLocationSelected != null) {
            widget.onLocationSelected!(
              state.currentLocation!,
              state.currentAddress!,
            );
          }
        } else if (state.status == LocationStatus.loading) {
          setState(() {
            _loading = true;
          });
        } else if (state.status == LocationStatus.failure) {
          setState(() {
            _loading = false;
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(12.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.amber, size: 24.r),
                SizedBox(width: 8.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Địa chỉ giao hàng',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _loading ? 'Đang tải vị trí...' : _currentAddress,
                        style: TextStyle(fontSize: 12.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: _openLocationPicker,
                  child: Text(
                    'Thay đổi',
                    style: TextStyle(
                      color: Colors.amber[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            if (widget.showMap && _currentLocation != null) ...[
              SizedBox(height: 8.h),
              SizedBox(
                height: 120.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: _currentLocation!,
                      zoom: 15,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('current_location'),
                        position: _currentLocation!,
                      ),
                    },
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                    scrollGesturesEnabled: false,
                    zoomGesturesEnabled: false,
                    tiltGesturesEnabled: false,
                    rotateGesturesEnabled: false,
                    liteModeEnabled: true,
                    onTap: (_) => _openLocationPicker(),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
} 