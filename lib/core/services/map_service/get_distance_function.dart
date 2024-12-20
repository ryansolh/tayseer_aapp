import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

//calculate the distance between two location

 Future<void> _calculateDistance(LatLng? currentLocation,LatLng? destinationPoint)async{
  double distance= Geolocator.distanceBetween(currentLocation!.latitude!, currentLocation!.longitude!, destinationPoint!.latitude!, destinationPoint!.longitude!);
}