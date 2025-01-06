/*
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

//calculate the distance between two location

String distance='';
 Future calculateDistance(var centerLocation)async{


  var location=Location();
  var userLocation;

   userLocation= await location.getLocation();
  List<String> _centerLocation=centerLocation.split(',');
  distance=await Geolocator.distanceBetween(userLocation!.latitude!, userLocation!.longitude!, double.parse(_centerLocation[0]),double.parse(_centerLocation[1])).toString();


}*/
