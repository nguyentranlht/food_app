import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:itc_food/features/location/location_bloc/location_event.dart';
import 'package:itc_food/features/location/location_bloc/location_state.dart';
import 'package:itc_food/data/repository/location_repo.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationService _locationService;

  LocationBloc({LocationService? locationService})
      : _locationService = locationService ?? LocationService(),
        super(const LocationState()) {
    on<LocationCheckPermission>(_onCheckPermission);
    on<LocationGetCurrent>(_onGetCurrentLocation);
    on<LocationSearch>(_onSearchLocation);
    on<LocationSelect>(_onSelectLocation);
    on<LocationGetAddress>(_onGetAddress);
  }

  Future<void> _onCheckPermission(
    LocationCheckPermission event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(status: LocationStatus.loading));
    try {
      // Kiểm tra dịch vụ vị trí có được bật không
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return emit(state.copyWith(
          status: LocationStatus.serviceDisabled,
          errorMessage: 'Dịch vụ vị trí đang tắt',
        ));
      }

      // Kiểm tra quyền vị trí
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return emit(state.copyWith(
            status: LocationStatus.permissionDenied,
            hasPermission: false,
            errorMessage: 'Quyền truy cập vị trí bị từ chối',
          ));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return emit(state.copyWith(
          status: LocationStatus.permissionDenied,
          hasPermission: false,
          errorMessage: 'Quyền truy cập vị trí bị từ chối vĩnh viễn',
        ));
      }

      emit(state.copyWith(
        status: LocationStatus.success,
        hasPermission: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LocationStatus.failure,
        errorMessage: 'Lỗi khi kiểm tra quyền: $e',
      ));
    }
  }

  Future<void> _onGetCurrentLocation(
    LocationGetCurrent event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(status: LocationStatus.loading));
    try {
      // Kiểm tra dịch vụ vị trí có được bật không
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return emit(state.copyWith(
          status: LocationStatus.serviceDisabled,
          errorMessage: 'Dịch vụ vị trí đang tắt',
        ));
      }

      // Kiểm tra quyền vị trí
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return emit(state.copyWith(
            status: LocationStatus.permissionDenied,
            errorMessage: 'Quyền truy cập vị trí bị từ chối',
          ));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return emit(state.copyWith(
          status: LocationStatus.permissionDenied,
          errorMessage: 'Quyền truy cập vị trí bị từ chối vĩnh viễn',
        ));
      }

      // Lấy vị trí hiện tại
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 15),
      );
      
      final latLng = LatLng(position.latitude, position.longitude);
      final address = await _locationService.getAddressFromCoordinates(
        position.latitude,
        position.longitude,
      );

      emit(state.copyWith(
        status: LocationStatus.success,
        currentLocation: latLng,
        currentAddress: address,
        hasPermission: true,
      ));
        } catch (e) {
      emit(state.copyWith(
        status: LocationStatus.failure,
        errorMessage: 'Lỗi khi lấy vị trí: $e',
      ));
    }
  }

  Future<void> _onSearchLocation(
    LocationSearch event,
    Emitter<LocationState> emit,
  ) async {
    if (event.query.isEmpty) {
      return emit(state.copyWith(searchResults: []));
    }

    emit(state.copyWith(status: LocationStatus.loading));
    try {
      final results = await _locationService.searchAddress(event.query);
      emit(state.copyWith(
        status: LocationStatus.success,
        searchResults: results,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LocationStatus.failure,
        errorMessage: 'Lỗi khi tìm kiếm địa chỉ: $e',
      ));
    }
  }

  void _onSelectLocation(
    LocationSelect event,
    Emitter<LocationState> emit,
  ) {
    emit(state.copyWith(
      status: LocationStatus.success,
      currentLocation: event.latLng,
      currentAddress: event.address,
    ));
  }

  Future<void> _onGetAddress(
    LocationGetAddress event,
    Emitter<LocationState> emit,
  ) async {
    emit(state.copyWith(status: LocationStatus.loading));
    try {
      final address = await _locationService.getAddressFromCoordinates(
        event.latitude,
        event.longitude,
      );
      
      emit(state.copyWith(
        status: LocationStatus.success,
        currentLocation: LatLng(event.latitude, event.longitude),
        currentAddress: address,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: LocationStatus.failure,
        errorMessage: 'Lỗi khi lấy địa chỉ: $e',
      ));
    }
  }
} 