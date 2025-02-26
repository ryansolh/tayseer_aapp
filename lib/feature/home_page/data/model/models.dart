class EventsModel {
  final int id;//الid الخاص بالحدث
  final String name;//اسم الحدث
  final String imageUrl;//صورة تعبر عن الحدث
  final String description;// وصف مع تفاصيل الحدث
  final String address;// المكان الذي سيقام فيه الحدث مثلا شارع الرباط - كذا كذا - كذا كذا
  String? videoUrl;// فيديو خاص باعلان الحدث ان وجد (ليس اجباري)
  EventsModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.address,
    this.videoUrl
  });

  // تحويل JSON إلى كائن من نوع Center
  factory EventsModel.fromJson(Map<String, dynamic> json) {
    return EventsModel(
      id: json['id'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      description: json['description'],
      address: json['address'],
      videoUrl: json['videoUrl']

    );
  }

  // تحويل كائن Center إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'address': address,
      'videoUrl':videoUrl
    };
  }
}