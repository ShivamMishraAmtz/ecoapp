import 'package:learning/EmployeeUser.dart';

class EmployeeModal {
  final int id;
  final String other_mobile_number;
  final String employee_number;
  final String dob;
  final String city;
  final int pincode;
  final String profile_image;
  final String company;
  final String department;
  final String address;
  final String other_email;
  final String status;
  final String phone_number;
  final EmployeeUser user_id;

  EmployeeModal({
    required this.id,
    required this.other_mobile_number,
    required this.employee_number,
    required this.dob,
    required this.city,
    required this.pincode,
    required this.profile_image,
    required this.company,
    required this.department,
    required this.address,
    required this.other_email,
    required this.status,
    required this.phone_number,
    required this.user_id,
  });

  factory EmployeeModal.fromJson(Map json) {

    String img="";

    if(json['profile_image']==null)
      img="/media/uploads/profile/logo.png";
    else
      img=json['profile_image'];

    return EmployeeModal(
      id: json['id'],
      company: json['company'],
      department: json['department'],
      other_mobile_number: json['other_mobile_number'],
      employee_number: json['employee_number'],
      dob: json['dob'],
      city: json['city'],
      pincode: json['pincode'],
      profile_image: img,
      address: json['address'],
      other_email: json['other_email'],
      status: json['status'],
      phone_number: json['phone_number'],
      user_id: EmployeeUser.fromJson(json['user_id'])
    );

  }

  Map toMap() {
    var map = new Map();
    map["id"] = id;
    map["company"] = company;
    map["department"] = department;
    map["other_mobile_number"] = other_mobile_number;
    map["employee_number"] = employee_number;
    map["dob"] = dob;
    map["city"] = city;
    map["pincode"] = pincode;
    map["profile_image"] = profile_image;
    map["address"] = address;
    map["other_email"] = other_email;
    map["status"] = status;
    map["phone_number"] = phone_number;
    map["user_id"] = user_id;
    return map;
  }
}
