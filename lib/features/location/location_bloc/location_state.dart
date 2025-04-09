import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum LocationStatus {
  initial,
  loading,
  success,
  failure,
  permissionDenied,
  serviceDisabled
}

class LocationState extends Equatable {
  final LocationStatus status;
  final LatLng? currentLocation;
  final String? currentAddress;
  final String? errorMessage;
  final bool hasPermission;
  final List<Map<String, dynamic>> searchResults;

  const LocationState({
    this.status = LocationStatus.initial,
    this.currentLocation,
    this.currentAddress,
    this.errorMessage,
    this.hasPermission = false,
    this.searchResults = const [],
  });

  LocationState copyWith({
    LocationStatus? status,
    LatLng? currentLocation,
    String? currentAddress,
    String? errorMessage,
    bool? hasPermission,
    List<Map<String, dynamic>>? searchResults,
  }) {
    return LocationState(
      status: status ?? this.status,
      currentLocation: currentLocation ?? this.currentLocation,
      currentAddress: currentAddress ?? this.currentAddress,
      errorMessage: errorMessage ?? this.errorMessage,
      hasPermission: hasPermission ?? this.hasPermission,
      searchResults: searchResults ?? this.searchResults,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentLocation,
        currentAddress,
        errorMessage,
        hasPermission,
        searchResults,
      ];
} 