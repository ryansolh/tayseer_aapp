import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapState {
  final LocationData? currentLocation;
  final List<LatLng> routePoints;
  final List<Marker> markers;

  MapState({
    this.currentLocation,
    this.routePoints = const [],
    this.markers = const [],
  });

  MapState copyWith({
    LocationData? currentLocation,
    List<LatLng>? routePoints,
    List<Marker>? markers,
  }) {
    return MapState(
      currentLocation: currentLocation ?? this.currentLocation,
      routePoints: routePoints ?? this.routePoints,
      markers: markers ?? this.markers,
    );
  }
}
