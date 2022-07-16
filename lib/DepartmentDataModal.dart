class DepartmentDataModal {
  final int id;
  final String company_name;
  final String department_name;
  final int added_by_user;
  final String status;


  DepartmentDataModal({
    required this.id,
    required this.company_name,
    required this.department_name,
    required this.added_by_user,
    required this.status,
  });

  factory DepartmentDataModal.fromJson(Map json) {
    return DepartmentDataModal(
      id: json['id'],
      company_name: json['company_name'],
      department_name: json['department_name'],
      added_by_user: json['added_by_user'],
      status: json['status'],

    );
  }

  Map toMap() {
    var map = new Map();
    map["company_name"] = company_name;
    map["department_name"] = department_name;
    map["added_by_user"] = added_by_user;
    map["status"] = status;
    return map;
  }
}
