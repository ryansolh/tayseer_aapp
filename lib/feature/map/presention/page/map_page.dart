import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../management/map_bloc/map_page_cubit.dart';
import '../management/map_bloc/map_page_states.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MapCubit()..getCurrentLocation(LatLng(15.371763, 44.177131)),
      child: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(title: const Text('المسار الاقرب بين موقعي الحالي والموقع المحدد')),
        body: BlocBuilder<MapCubit, MapState>(
          builder: (context, state) {
            if (state.currentLocation == null) {
              return Container(
                color: Theme.of(context).colorScheme.surface,
                  child: const Center(
                      child: CircularProgressIndicator(color: Colors.blue)
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
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<MapCubit>().getCurrentLocation(LatLng(15.371763, 44.177131));
          },
          child: const Icon(Icons.my_location, color: Colors.white),
        ),
      ),
    );
  }
}
