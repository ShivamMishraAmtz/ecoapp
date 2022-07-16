class HallModal {
  final int id;
  final int location_name;
  final String room_name;
  final int room_capacity;
  final String status;


  HallModal({
    required this.id,
    required this.location_name,
    required this.room_name,
    required this.room_capacity,
    required this.status,
  });

  factory HallModal.fromJson(Map json) {
    return HallModal(
      id: json['id'],
      location_name: json['location_name'],
      room_name: json['room_name'],
      room_capacity: json['room_capacity'],
      status: json['status'],

    );
  }

  Map toMap() {
    var map = new Map();
    map["location_name"] = location_name;
    map["room_name"] = room_name;
    map["room_capacity"] = room_capacity;
    map["status"] = status;
    return map;
  }
}
