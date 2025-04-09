import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService {
  // Kiểm tra và yêu cầu quyền vị trí
  Future<bool> checkLocationPermission() async {
    try {
      // Kiểm tra dịch vụ vị trí có được bật không
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }

      // Kiểm tra quyền vị trí
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return false;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return false;
      }

      return true;
    } catch (e) {
      print('Lỗi khi kiểm tra quyền vị trí: $e');
      return false;
    }
  }

  // Lấy vị trí hiện tại
  Future<Position?> getCurrentLocation() async {
    try {
      // Kiểm tra quyền trước khi lấy vị trí
      bool hasPermission = await checkLocationPermission();
      if (!hasPermission) return null;

      // Lấy vị trí hiện tại
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );
    } catch (e) {
      print('Lỗi khi lấy vị trí: $e');
      return null;
    }
  }

  // Chuyển đổi tọa độ thành địa chỉ
  Future<String> getAddressFromCoordinates(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        String address = '';
        
        if (place.street != null && place.street!.isNotEmpty) {
          address += place.street!;
        }
        
        if (place.subLocality != null && place.subLocality!.isNotEmpty) {
          address += address.isNotEmpty ? ', ${place.subLocality}' : place.subLocality!;
        }
        
        if (place.locality != null && place.locality!.isNotEmpty) {
          address += address.isNotEmpty ? ', ${place.locality}' : place.locality!;
        }
        
        if (place.administrativeArea != null && place.administrativeArea!.isNotEmpty) {
          address += address.isNotEmpty ? ', ${place.administrativeArea}' : place.administrativeArea!;
        }
        
        return address.isNotEmpty ? address : 'Không tìm thấy địa chỉ';
      }
      return 'Không tìm thấy địa chỉ';
    } catch (e) {
      print('Lỗi khi lấy địa chỉ: $e');
      return 'Không tìm thấy địa chỉ';
    }
  }

  // Tìm kiếm địa chỉ
  Future<List<Map<String, dynamic>>> searchAddress(String query) async {
    try {
      final response = await locationFromAddress(query);
      if (response.isNotEmpty) {
        final location = response.first;
        final address = await getAddressFromCoordinates(location.latitude, location.longitude);
        return [
          {
            'latLng': LatLng(location.latitude, location.longitude),
            'address': address,
          }
        ];
      }
      return [];
    } catch (e) {
      print('Lỗi khi tìm kiếm địa chỉ: $e');
      return [];
    }
  }
} 