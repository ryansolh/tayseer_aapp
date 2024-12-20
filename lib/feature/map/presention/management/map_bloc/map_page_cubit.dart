import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter/material.dart';

import '../../../../../core/component/my_custom_shadermask.dart';
import 'map_page_states.dart';

class MapCubit extends Cubit<MapState> {
  final String orsApiKey =
      '5b3ce3597851110001cf62487117c8344b334cdba2407f9897444a33';

  MapCubit() : super(MapState());

  Future<void> getCurrentLocation(LatLng destinationPoint) async {
    var location = Location();
    try {
      var userLocation = await location.getLocation();
      final marker = Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(userLocation.latitude!, userLocation.longitude!),
        child: MyShaderMask(
            toolWidget: Icon(
              Icons.my_location,
              size: 40,
            ),
            radius: 0.3),
      );

      emit(state.copyWith(
        currentLocation: userLocation,
        markers: List.from(state.markers)..add(marker),
      ));
      location.onLocationChanged.listen((LocationData newLocation) {
        emit(state.copyWith(currentLocation: newLocation));
      });
      addDestinationMarker(destinationPoint);
    } on Exception {
      emit(state.copyWith(currentLocation: null));
    }
  }

  Future<void> getRoute(LatLng destination) async {
    if (state.currentLocation == null) return;

    final start = LatLng(
        state.currentLocation!.latitude!, state.currentLocation!.longitude!);
    final response = await http.get(
      Uri.parse(
          'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}'),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> coords =
          data['features'][0]['geometry']['coordinates'];
      final routePoints =
          coords.map((coord) => LatLng(coord[1], coord[0])).toList();

      final marker = Marker(
        width: 80.0,
        height: 80.0,
        point: destination,
        child: MyShaderMask(
            toolWidget: Icon(
              Icons.location_on,
              size: 40,
            ),
            radius: 0.3),
      );

      emit(state.copyWith(
        routePoints: routePoints,
        markers: List.from(state.markers)..add(marker),
      ));
    } else {
      // Handle errors
    }
  }

  void addDestinationMarker(LatLng point) {
    final marker = Marker(
      width: 80.0,
      height: 80.0,
      point: point,
      child: MyShaderMask(
          toolWidget: Icon(
            Icons.location_on,
            size: 40,
          ),
          radius: 0.3),
    );

    emit(state.copyWith(
      markers: List.from(state.markers)..add(marker),
    ));

    getRoute(point);
  }
}
