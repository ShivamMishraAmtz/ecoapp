class LoginDataModal {
  final String other_number;
  final String phone_number;
  final String profile_image;
  final String other_email;
  final String employee_id;
  final String address;
  final int pincode;
  final String city;
  final String dob;

  final int company;
  final int department;

  LoginDataModal({
    required this.other_number,
    required this.phone_number,
    required this.profile_image,
    required this.other_email,
    required this.employee_id,
    required this.address,
    required this.pincode,
    required this.city,
    required this.dob,
    required this.company,
    required this.department,
  });

  factory LoginDataModal.fromJson(Map json) {
    return LoginDataModal(
      other_number: json['other_number'],
      phone_number: json['phone_number'],
      profile_image: json['profile_image'],
      other_email: json['other_email'],
      employee_id: json['employee_id'],
      address: json['address'],
      pincode: json['pincode'],
      city: json['city'],
      dob: json['dob'],
      company: json['company'],
      department: json['department'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["other_number"] = other_number;
    map["phone_number"] = phone_number;
    map["profile_image"] = profile_image;
    map["other_email"] = other_email;
    map["employee_id"] = employee_id;
    map["address"] = address;
    map["pincode"] = pincode;
    map["city"] = city;
    map["dob"] = dob;
    map["company"] = company;
    map["department"] = department;
    return map;
  }
}
