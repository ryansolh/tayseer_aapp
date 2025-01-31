class EventsModel {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final String address;
  String? videoUrl;
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