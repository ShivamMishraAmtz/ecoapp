class DepartmentalComplainModal {

  final int id;
  final int complaints_user;
  final int company_id;
  final int department_id;
  final String subject;
  final String description;
  final String image_one;
  final String image_two;
  final String image_three;
  final String image_four;
  final String image_five;
  final String resolved_by_user;
  final String remarks;
  final String resolved_date;
  final String create_date;
  final String status;

  DepartmentalComplainModal({
    required this.id,
    required this.complaints_user,
    required this.company_id,
    required this.department_id,
    required this.subject,
    required this.description,
    required this.image_one,
    required this.image_two,
    required this.image_three,
    required this.image_four,
    required this.image_five,
    required this.resolved_by_user,
    required this.remarks,
    required this.resolved_date,
    required this.create_date,
    required this.status,
  });

  factory DepartmentalComplainModal.fromJson(Map json) {
    return DepartmentalComplainModal(
      id: json['id'],
      complaints_user: json['complaints_user'],
      company_id: json['company_id'],
      department_id: json['department_id'],
      subject: json['subject'],
      description: json['description'],
      image_one: json['image_one'],
      image_two: json['image_two'],
      image_three: json['image_three'],
      image_four: json['image_four'],
      image_five: json['image_five'],
      resolved_by_user: json['resolved_by_user'],
      remarks: json['remarks'],
      resolved_date: json['resolved_date'],
      create_date: json['create_date'],
      status: json['status'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["id"] = id;
    map["complaints_user"] = complaints_user;
    map["company_id"] = company_id;
    map["department_id"] = department_id;
    map["subject"] = subject;
    map["description"] = description;
    map["image_one"] = image_one;
    map["image_two"] = image_two;
    map["image_three"] = image_three;
    map["image_four"] = image_four;
    map["image_five"] = image_five;
    map["resolved_by_user"] = resolved_by_user;
    map["remarks"] = remarks;
    map["resolved_date"] = resolved_date;
    map["create_date"] = create_date;
    map["status"] = status;
    return map;
  }
}
