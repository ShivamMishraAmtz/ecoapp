class BuildingModal {
  final int id;
  final int user_id;
  final String location_name;
  final String status;


  BuildingModal({
    required this.id,
    required this.user_id,
    required this.location_name,
    required this.status,
  });

  factory BuildingModal.fromJson(Map json) {
    return BuildingModal(
      id: json['id'],
      user_id: json['user_id'],
      location_name: json['location_name'],
      status: json['status'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["id"] = id;
    map["user_id"] = user_id;
    map["location_name"] = location_name;
    map["status"] = status;
    return map;
  }
}
