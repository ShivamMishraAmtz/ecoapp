class TicketCategoryModal {
  final int id;
  final String categories_name;
  final String status;
  final String create_date;

  TicketCategoryModal({
    required this.id,
    required this.categories_name,
    required this.status,
    required this.create_date,
  });

  factory TicketCategoryModal.fromJson(Map json) {
    return TicketCategoryModal(
      id: json['id'],
      categories_name: json['categories_name'],
      status: json['status'],
      create_date: json['create_date'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["id"] = id;
    map["categories_name"] = categories_name;
    map["status"] = status;
    map["create_date"] = create_date;
    return map;
  }
}
