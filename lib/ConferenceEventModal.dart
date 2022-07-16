class ConferenceEventModal {
  final int id;
  final String event_name;
  final String status;
  final String create_date;


  ConferenceEventModal({
    required this.id,
    required this.event_name,
    required this.status,
    required this.create_date,
  });

  factory ConferenceEventModal.fromJson(Map json) {
    return ConferenceEventModal(
      id: json['id'],
      event_name: json['event_name'],
      status: json['status'],
      create_date: json['create_date'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["id"] = id;
    map["event_name"] = event_name;
    map["status"] = status;
    map["create_date"] = create_date;
    return map;
  }
}
