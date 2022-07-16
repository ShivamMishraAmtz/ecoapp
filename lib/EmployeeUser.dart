class EmployeeUser {
  final int id;
  final String first_name;
  final String last_name;
  final bool is_active;

  EmployeeUser({
    required this.id,
    required this.first_name,
    required this.last_name,
    required this.is_active,
  });

  factory EmployeeUser.fromJson(Map json) {


    return EmployeeUser(
      id: json['id'],
      first_name: json['first_name'],
      last_name: json['last_name'],
      is_active: json['is_active'],

    );
  }

  Map toMap() {
    var map = new Map();
    map["id"] = id;
    map["first_name"] = first_name;
    map["last_name"] = last_name;
    map["is_active"] = is_active;
    return map;
  }
}
