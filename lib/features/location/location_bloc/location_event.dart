import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object?> get props => [];
}

class LocationCheckPermission extends LocationEvent {}

class LocationGetCurrent extends LocationEvent {}

class LocationSearch extends LocationEvent {
  final String query;

  const LocationSearch(this.query);

  @override
  List<Object?> get props => [query];
}

class LocationSelect extends LocationEvent {
  final LatLng latLng;
  final String address;

  const LocationSelect(this.latLng, this.address);

  @override
  List<Object?> get props => [latLng, address];
}

class LocationGetAddress extends LocationEvent {
  final double latitude;
  final double longitude;

  const LocationGetAddress(this.latitude, this.longitude);

  @override
  List<Object?> get props => [latitude, longitude];
} 