class EventDataModal {
  final int id;
  final String title;
  final String description;
  final String image;
  final String status;
  final String from_date;
  final String to_date;

  EventDataModal({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.from_date,
    required this.to_date,
  });

  factory EventDataModal.fromJson(Map json) {
    return EventDataModal(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
        status: json['status'],
        from_date: json['from_date'],
        to_date: json['to_date']);
  }

  Map toMap() {
    var map = new Map();
    map["title"] = title;
    map["description"] = description;
    map["image"] = image;
    map["status"] = status;
    map["from_date"] = from_date;
    map["to_date"] = to_date;
    return map;
  }
}
