class Task {
  int? id;
  late String title;
  late String note;
  int? isCompleted;
  String? date;
  String? reminderType;
  String? medicineType;
  int? numberOfStripPills;
  int? numberOfPills;
  String? startTime;
  String? startTime2;
  String? startTime3;
  String? endTime;
  int? color;
  int? remind;
  String? repeat;
  String? completedAt;
  String? createdAt;
  String? updatedAt;

  Task({
    this.id,
    required this.title,
    required this.note,
    this.isCompleted,
    this.date,
    this.reminderType,
    this.medicineType,
    this.numberOfStripPills,
    this.numberOfPills,
    this.startTime,
    this.startTime2,
    this.startTime3,
    this.endTime,
    this.color,
    this.remind,
    this.repeat,
    this.completedAt,
    this.createdAt,
    this.updatedAt,
  });

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    reminderType =json['reminderType'];
    medicineType =json['medicineType'];
    numberOfStripPills =json['numberOfStripPills'];
    numberOfPills =json['numberOfPills'];
    startTime = json['startTime'];
    startTime2 = json['secondStartTime'];
    startTime3 = json['thirdStartTime'];
    endTime = json['endTime'];
    color = json['color'];
    remind = json['remind'];
    repeat = json['repeat'];
    completedAt = json['completedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['note'] = note;
    data['isCompleted'] = isCompleted;
    data['date'] = date;
    data['reminderType']=reminderType;
    data['medicineType']=medicineType;
    data['numberOfStripPills']=numberOfStripPills;
    data['numberOfPills']=numberOfPills;
    data['startTime'] = startTime;
    data['secondStartTime'] = startTime2;
    data['thirdStartTime'] = startTime3;
    data['endTime'] = endTime;
    data['color'] = color;
    data['remind'] = remind;
    data['repeat'] = repeat;
    data['completedAt'] = completedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
