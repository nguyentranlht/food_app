import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:itc_food/data/repository/location_repo.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationPickerScreen extends StatefulWidget {
  final Position? initialPosition;

  const LocationPickerScreen({super.key, this.initialPosition});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late GoogleMapController _mapController;
  final TextEditingController _searchController = TextEditingController();
  final Set<Marker> _markers = {};
  final LocationService _locationService = LocationService();

  LatLng? _selectedLocation;
  String _address = '';
  bool _isLoading = true;
  bool _isSearching = false;
  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  Future<void> _initializeLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (widget.initialPosition != null) {
        final LatLng location = LatLng(
          widget.initialPosition!.latitude,
          widget.initialPosition!.longitude,
        );

        final String address = await _locationService.getAddressFromCoordinates(
          location.latitude,
          location.longitude,
        );

        setState(() {
          _selectedLocation = location;
          _address = address;
          _isLoading = false;
        });

        _updateMarker(location);
      } else {
        // Nếu không có vị trí ban đầu, thử lấy vị trí hiện tại
        await _getCurrentLocation();
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        final location = LatLng(position.latitude, position.longitude);
        final address = await _locationService.getAddressFromCoordinates(
          location.latitude,
          location.longitude,
        );

        setState(() {
          _selectedLocation = location;
          _address = address;
          _isLoading = false;
        });

        _updateMarker(location);
        _moveToLocation(location);
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _updateLocation(LatLng location) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final address = await _locationService.getAddressFromCoordinates(
        location.latitude,
        location.longitude,
      );

      setState(() {
        _selectedLocation = location;
        _address = address;
        _isLoading = false;
      });

      _updateMarker(location);
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _searchLocation(String query) async {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    try {
      final results = await _locationService.searchAddress(query);

      setState(() {
        _searchResults = results;
        _isSearching = false;
      });
    } catch (e) {
      setState(() {
        _isSearching = false;
      });
    }
  }

  void _selectSearchResult(Map<String, dynamic> result) {
    final latLng = result['latLng'] as LatLng;
    final address = result['address'] as String;

    setState(() {
      _selectedLocation = latLng;
      _address = address;
      _searchResults = [];
      _isSearching = false;
    });

    _updateMarker(latLng);
    _moveToLocation(latLng);

    // In ra log để kiểm tra
    print('Đã chọn vị trí: ${latLng.latitude}, ${latLng.longitude}');
    print('Địa chỉ: $address');
  }

  void _clearSearch() {
    setState(() {
      _searchResults = [];
      _isSearching = false;
    });
  }

  void _updateMarker(LatLng location) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: const MarkerId('selected_location'),
          position: location,
          draggable: true,
          onDragEnd: (newPosition) {
            _updateLocation(newPosition);
          },
        ),
      );
    });
  }

  void _moveToLocation(LatLng location) {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: location, zoom: 15),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn vị trí của bạn'),
        backgroundColor: Colors.amber,
        foregroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _getCurrentLocation,
            tooltip: 'Lấy vị trí hiện tại',
          ),
        ],
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target:
                          _selectedLocation ??
                          const LatLng(10.769444, 106.681944),
                      zoom: 15,
                    ),
                    markers: _markers,
                    onMapCreated: (controller) {
                      _mapController = controller;
                      if (_selectedLocation != null) {
                        _updateMarker(_selectedLocation!);
                        _moveToLocation(_selectedLocation!);
                      }
                    },
                    onTap: (position) {
                      _updateLocation(position);
                    },
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    zoomControlsEnabled: false,
                  ),
                  Positioned(
                    top: 16.r,
                    left: 16.r,
                    right: 16.r,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Nhập địa chỉ cần tìm...',
                              prefixIcon: const Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.r),
                                borderSide: BorderSide.none,
                              ),
                              suffixIcon:
                                  _searchController.text.isNotEmpty
                                      ? IconButton(
                                        icon: const Icon(Icons.clear),
                                        onPressed: () {
                                          _searchController.clear();
                                          _clearSearch();
                                        },
                                      )
                                      : null,
                            ),
                            onChanged: _searchLocation,
                          ),
                          if (_isSearching)
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                            ),
                          if (_searchResults.isNotEmpty)
                            Container(
                              constraints: BoxConstraints(maxHeight: 150.h),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _searchResults.length,
                                itemBuilder: (context, index) {
                                  final result = _searchResults[index];
                                  return ListTile(
                                    leading: const Icon(
                                      Icons.location_on,
                                      color: Colors.amber,
                                    ),
                                    title: Text(
                                      result['address'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    onTap: () {
                                      _selectSearchResult(result);
                                    },
                                  );
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.all(16.r),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Địa chỉ',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          SizedBox(
                            height: 60.h,
                            child: SingleChildScrollView(child: Text(_address)),
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                context.pop({
                                  'latLng': _selectedLocation,
                                  'address': _address,
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.amber,
                                foregroundColor: Colors.black,
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.r),
                                ),
                              ),
                              child: const Text('Xác nhận vị trí này'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
    );
  }
}
