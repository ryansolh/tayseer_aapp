import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:todo_apps/core/component/my_custom_loading.dart';
import 'package:todo_apps/feature/centers/data/model.dart';
import '../management/map_bloc/map_page_cubit.dart';
import '../management/map_bloc/map_page_states.dart';

class MapScreen extends StatelessWidget {
   MapScreen({Key? key,  this.centerLocation, }) : super(key: key);
 final CenterLocation? centerLocation;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit()..getCurrentLocation(LatLng(centerLocation!.latitude, centerLocation!.longitude)),
      child:BlocBuilder<MapCubit, MapState>(
        builder: (context, state) {
          if (state.currentLocation == null) {
            return Container(
                color: Theme.of(context).colorScheme.surface,
                child: const Center(
                    child: MyCustomLoading()
                )
            );
          }

          return FlutterMap(
            mapController: MapController(),
            options: MapOptions(
                initialCenter: LatLng(state.currentLocation!.latitude!, state.currentLocation!.longitude!),
                initialZoom: 15.0,
                onTap: (tapPosition,point) {
                  // print(point);
                }
            ),
            children: [
              TileLayer(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: const ['a', 'b', 'c'],
              ),
              MarkerLayer(
                markers: state.markers,
              ),
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: state.routePoints,
                    strokeWidth: 4.0,
                    color: Colors.blueAccent,
                  ),
                ],
              ),
            ],
          );
        },
      )
    );
  }
}
