class CentersModel {
  final int id; // الid الخاص بالمركز
  final String name;// اسم المركز
  final String imageUrl;//صورة المركز او شعارة
  final String description;// وصف عن المركز
  final List<Service> services;// الخدمات هذه معاها موديل لحالها موضح تحت
  final CenterLocation location;// الموقع حق الاحداثيات وهذه برضو معاها موديل لحالها موضحة تحت
  final String address;//العنوان بالنص مثلا الستين - السنينه - امام مستشفى الشيباني
  final String contactNumber;//رقم المركز الخاص بالاتصال
  final String whatsappNumber;//رقم المركز الخاص بالواتساب
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
  final String serviceTypeName;
  /*
  اذا كان سمعية اي خدمة للمعاقين السمعيين او للمكفوفين او معاقين الحركه
  بحيث المركز الواحد يمكن ان يقدم اكثر من خدمه مثلا سمعية وبصرية او الكل
  */


   List<String>? subServices;
   /*
   الخدمات التي تندرج تحت الخدمه الاصل
   مثلا اذا تم اختيار serviceTypeName خدمات للمكفوفين
   ايش الخدمات التي ممكن تقدمها للمكفوفين
   هل خدمات تعليمية وتاهيلية اوخدمات اجتماعية
    او غيرها ويمكن اختيار اكثر من خيار
   */

  Service({required this.serviceTypeName,  this.subServices});

  // تحويل JSON إلى كائن من نوع Service
  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
      serviceTypeName: json['name'],
      subServices: List<String>.from(json['subServices']),
    );
  }

  // تحويل كائن Service إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'name': serviceTypeName,
      'subServices': subServices,
    };
  }
}

class CenterLocation {
  //هولا حق تحديد موقع المركز
  final double latitude;//احداثيات العرض
  final double longitude;//احداثيات الطول

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
