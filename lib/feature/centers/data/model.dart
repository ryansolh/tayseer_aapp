class CentersModel {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final List<Service> services;
  final CenterLocation location;
  final String address;
  final String contactNumber;
  final String whatsappNumber;
   double distance;

  CentersModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.services,
    required this.location,
    required this.address,
    required this.contactNumber,
    required this.whatsappNumber,
    this.distance=0
  });

  // تحويل JSON إلى كائن من نوع Center
  factory CentersModel.fromJson(Map<String, dynamic> json) {
    return CentersModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      services: (json['services'] as List)
          .map((service) => Service.fromJson(service))
          .toList(),
      location: CenterLocation.fromJson(json['location']),
      address: json['address'],
      contactNumber: json['contactNumber'],
      whatsappNumber: json['whatsappNumber'],
    );
  }

  // تحويل كائن Center إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'services': services.map((service) => service.toJson()).toList(),
      'location': location.toJson(),
      'address': address,
      'contactNumber': contactNumber,
      'whatsappNumber': whatsappNumber,
    };
  }
}

class Service {
  final String name;
  final List<String> subServices;

  Service({required this.name, required this.subServices});

  // تحويل JSON إلى كائن من نوع Service
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      name: json['name'],
      subServices: List<String>.from(json['subServices']),
    );
  }

  // تحويل كائن Service إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'subServices': subServices,
    };
  }
}

class CenterLocation {
  final double latitude;
  final double longitude;

  CenterLocation({required this.latitude, required this.longitude});

  // تحويل JSON إلى كائن من نوع Location
  factory CenterLocation.fromJson(Map<String, dynamic> json) {
    return CenterLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  // تحويل كائن Location إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
