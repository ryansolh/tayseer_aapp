// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:latlong2/latlong.dart';
//
// void _showBottomSheet(BuildContext context,) {
//   Size size=MediaQuery.of(context).size;
//   Get.bottomSheet(
//     isDismissible: true,
//
//     // shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
//     Container(
//       padding: const EdgeInsets.only(top: 0),
//       width: size.width,
//       height:
//           ? MediaQuery.of(context).size.height * 0.25
//           : MediaQuery.of(context).size.height * 0.35,
//
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
//         color: Get.isDarkMode ? Color(0xff121212) : Colors.white,
//       ),
//
//       child: BlocProvider(
//         create: (context) => MapCubit()..getCurrentLocation(LatLng(15.371763, 44.177131)),
//         child: BlocBuilder<MapCubit, MapState>(
//           builder: (context, state) {
//             if (state.currentLocation == null) {
//               return Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: Theme.of(context).colorScheme.surface,
//                   ),
//
//                   child: const Center(
//                       child: CircularProgressIndicator(color: Colors.blue)
//                   )
//               );
//             }
//
//             return Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20)
//               ),
//               child: FlutterMap(
//
//                 mapController: MapController(),
//                 options: MapOptions(
//
//                     initialCenter: LatLng(state.currentLocation!.latitude!, state.currentLocation!.longitude!),
//                     initialZoom: 15.0,
//                     onTap: (tapPosition,point) {
//                       // print(point);
//                     }
//                 ),
//                 children: [
//                   TileLayer(
//                     urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//                     subdomains: const ['a', 'b', 'c'],
//                   ),
//                   MarkerLayer(
//                     markers: state.markers,
//                   ),
//                   PolylineLayer(
//                     polylines: [
//                       Polyline(
//                         points: state.routePoints,
//                         strokeWidth: 4.0,
//                         color: Colors.blueAccent,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     ),
//   );
// }