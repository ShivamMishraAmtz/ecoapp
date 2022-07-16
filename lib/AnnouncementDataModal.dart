class AnnouncementDataModal {
  final int id;
  final String title;
  final String description;
  final String image;
  final String status;
  final String create_date;

  AnnouncementDataModal({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.status,
    required this.create_date,
  });

  factory AnnouncementDataModal.fromJson(Map json) {
    return AnnouncementDataModal(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
        status: json['status'],
        create_date: json['create_date']);
  }

  Map toMap() {
    var map = new Map();
    map["title"] = title;
    map["description"] = description;
    map["image"] = image;
    map["status"] = status;
    map["create_date"] = create_date;
    return map;
  }
}
