import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:itc_food/features/location/location_bloc/location_bloc.dart';
import 'package:itc_food/features/location/location_bloc/location_event.dart';
import 'package:itc_food/features/location/location_bloc/location_state.dart';
import 'package:itc_food/features/location/screens/location_selector_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late final LocationBloc _locationBloc;

  @override
  void initState() {
    super.initState();
    _locationBloc = context.read<LocationBloc>();
    _locationBloc.add(LocationCheckPermission());
  }

  void _showLocationDialog(
    String title,
    String message,
    Function() onOpenSettings,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: onOpenSettings,
            child: const Text('Mở cài đặt'),
          ),
        ],
      ),
    );
  }

  void _showLocationError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'Thử lại',
            textColor: Colors.white,
            onPressed: () {
              _locationBloc.add(LocationGetCurrent());
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pop();
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Chọn vị trí'),
          backgroundColor: Colors.amber,
          foregroundColor: Colors.black,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.pop(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.my_location),
              onPressed: () {
                _locationBloc.add(LocationGetCurrent());
              },
              tooltip: 'Lấy vị trí hiện tại',
            ),
          ],
        ),
        body: BlocConsumer<LocationBloc, LocationState>(
          bloc: _locationBloc,
          listener: (context, state) {
            if (state.status == LocationStatus.serviceDisabled) {
              _showLocationDialog(
                'Dịch vụ vị trí bị tắt',
                'Vui lòng bật dịch vụ vị trí để sử dụng tính năng này.',
                () async {
                  context.pop();
                  await Geolocator.openLocationSettings();
                },
              );
            } else if (state.status == LocationStatus.permissionDenied) {
              _showLocationDialog(
                'Quyền vị trí bị từ chối',
                'Bạn cần cấp quyền truy cập vị trí để sử dụng tính năng này',
                () async {
                  context.pop();
                  await Geolocator.openAppSettings();
                },
              );
            } else if (state.status == LocationStatus.failure &&
                state.errorMessage != null) {
              _showLocationError(state.errorMessage!);
            }
          },
          builder: (context, state) {
            final bool isLoading = state.status == LocationStatus.loading;

            if (isLoading) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: Colors.amber),
                    SizedBox(height: 16),
                    Text('Đang lấy vị trí của bạn...'),
                  ],
                ),
              );
            }

            return Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Vị trí hiện tại của bạn',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  LocationSelectorWidget(
                    showMap: true,
                    initialLocation: state.currentLocation,
                    initialAddress: state.currentAddress,
                    onLocationSelected: (latLng, address) {
                      _locationBloc.add(LocationSelect(latLng, address));
                    },
                  ),
                  SizedBox(height: 20.h),
                  if (state.currentLocation != null) ...[
                    Text(
                      'Thông tin vị trí:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Vĩ độ: ${state.currentLocation!.latitude.toStringAsFixed(6)}',
                    ),
                    Text(
                      'Kinh độ: ${state.currentLocation!.longitude.toStringAsFixed(6)}',
                    ),
                    Text('Địa chỉ: ${state.currentAddress ?? ""}'),
                    SizedBox(height: 20.h),
                  ],
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (state.currentLocation != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Đã xác nhận vị trí: ${state.currentAddress}',
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Vui lòng chọn vị trí trước'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      child: const Text('Xác nhận'),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
