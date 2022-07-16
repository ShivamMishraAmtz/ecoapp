class BookingDetailModal {
  final String menu_name;
  final int menu_id;
  final String item_name;
  final int item_id;
  final String per_item_price;
  final String quantity;
  final String total_item_price;

  BookingDetailModal({
    required this.menu_name,
    required this.menu_id,
    required this.item_name,
    required this.item_id,
    required this.per_item_price,
    required this.quantity,
    required this.total_item_price,

  });

  factory BookingDetailModal.fromJson(Map json) {
    return BookingDetailModal(
      menu_name: json['menu_name'].toString(),
      menu_id: json['menu_id'],
      item_name: json['item_name'].toString(),
      item_id: json['item_id'],
      per_item_price: json['per_item_price'].toString(),
      quantity: json['quantity'].toString(),
      total_item_price: json['total_item_price'].toString(),
    );
  }

  Map toMap() {
    var map = new Map();
    map["menu_name"] = menu_name;
    map["menu_id"] = menu_id;
    map["item_name"] = item_name;
    map["item_id"] = item_id;
    map["per_item_price"] = per_item_price;
    map["quantity"] = quantity;
    map["total_item_price"] = total_item_price;
    return map;
  }
}
