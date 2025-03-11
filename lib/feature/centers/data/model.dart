class CenterModel {
  final String name;
  final String description;
  final String image;
  final String address;
  final String contactNumber;
  final String whatsappNumber;
  final double latitude;
  final double longitude;
  final List<Service> services;
  double distance;

  CenterModel({
    required this.name,
    required this.description,
    required this.image,
    required this.address,
    required this.contactNumber,
    required this.whatsappNumber,
    required this.latitude,
    required this.longitude,
    required this.services,
    this.distance = 0.0,
  });

  factory CenterModel.fromJson(Map<String, dynamic> json) {
    return CenterModel(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      address: json['address'],
      contactNumber: json['contact_number'],
      whatsappNumber: json['whatsapp_number'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      services: (json['services'] as List)
          .map((service) => Service.fromJson(service))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
      'address': address,
      'contact_number': contactNumber,
      'whatsapp_number': whatsappNumber,
      'latitude': latitude,
      'longitude': longitude,
      'services': services.map((service) => service.toJson()).toList(),
    };
  }
}

class Service {
  final int id;
  final String name;
  final List<SubService> subServices;

  Service({
    required this.id,
    required this.name,
    required this.subServices,
  });

  factory Service.fromJson(Map<String, dynamic> json) {
    List<SubService> subServices = [];

    // التحقق مما إذا كانت sub_services قائمة أو كائناً وتحويله إلى قائمة
    if (json['sub_services'] is List) {
      subServices = (json['sub_services'] as List)
          .map((subService) => SubService.fromJson(subService))
          .toList();
    } else if (json['sub_services'] is Map) {
      subServices = (json['sub_services'] as Map)
          .values // استخراج القيم فقط من الخريطة
          .map((subService) => SubService.fromJson(subService))
          .toList();
    }

    return Service(
      id: json['id'],
      name: json['name'],
      subServices: subServices,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sub_services': subServices.map((subService) => subService.toJson()).toList(),
    };
  }
}

class SubService {
  final int id;
  final String name;

  SubService({
    required this.id,
    required this.name,
  });

  factory SubService.fromJson(Map<String, dynamic> json) {
    return SubService(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
