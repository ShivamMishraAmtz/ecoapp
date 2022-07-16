
class HallBookingListDataModal {
  final int id;
  final int location_id;
  final String location_name;
  final int room_id;
  final String room_name;
  final int requested_employee_id;
  final String requested_employee_name;
  final String request_date;
  final int approved_by_user_id;
  final String approved_by_user_name;
  final String from_date_one;
  final String to_date_one;
  final String approved_date;
  final String remarks;
  final String slot_choice;
  final String event;
  final String food_facilites_list;
  final String audio_video_support;
  final String status;



  HallBookingListDataModal({
    required this.id,
    required this.location_id,
    required this.location_name,
    required this.room_id,
    required this.room_name,
    required this.requested_employee_id,
    required this.requested_employee_name,
    required this.request_date,
    required this.approved_by_user_id,
    required this.approved_by_user_name,
    required this.from_date_one,
    required this.to_date_one,
    required this.approved_date,
    required this.remarks,
    required this.slot_choice,
    required this.event,
    required this.food_facilites_list,
    required this.audio_video_support,
    required this.status,
  });

  factory HallBookingListDataModal.fromJson(Map json) {



    return HallBookingListDataModal(
        id: json['id'],
        location_id: json['location_id'],
        location_name: json['location_name'],
        room_id: json['room_id'],
        room_name: json['room_name'],
        requested_employee_id: json['requested_employee_id'],
        requested_employee_name: json['requested_employee_name'],
        request_date: json['request_date'],
        approved_by_user_id: json['approved_by_user_id'],
        approved_by_user_name: json['approved_by_user_name'],
        from_date_one: json['from_date_one'],
        to_date_one: json['to_date_one'],
        approved_date: json['approved_date'],
        remarks: json['remarks'],
        slot_choice: json['slot_choice'],
        event: json['event'],
        food_facilites_list: json['food_facilites_list'],
        audio_video_support: json['audio_video_support'],
        status: json['status']);
  }

  Map toMap() {
    var map = new Map();
    map["id"] = id;
    map["location_id"] = location_id;
    map["location_name"] = location_name;
    map["room_id"] = room_id;
    map["room_name"] = room_name;
    map["requested_employee_id"] = requested_employee_id;
    map["requested_employee_name"] = requested_employee_name;
    map["request_date"] = request_date;
    map["approved_by_user_id"] = approved_by_user_id;
    map["approved_by_user_name"] = approved_by_user_name;
    map["from_date_one"] = from_date_one;
    map["to_date_one"] = to_date_one;
    map["approved_date"] = approved_date;
    map["remarks"] = remarks;
    map["slot_choice"] = slot_choice;
    map["event"] = event;
    map["food_facilites_list"] = food_facilites_list;
    map["audio_video_support"] = audio_video_support;
    map["status"] = status;
    return map;
  }
}
