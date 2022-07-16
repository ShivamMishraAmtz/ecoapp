class MenuModal {
  final int id;
  final String menu_name;
  final List<dynamic> get_sub_menu;

  MenuModal({
    required this.id,
    required this.menu_name,
    required this.get_sub_menu,
  });

  factory MenuModal.fromJson(Map json) {
    return MenuModal(
      id: json['id'],
      menu_name: json['menu_name'],
      get_sub_menu: json['get_sub_menu'],
    );
  }

  Map toMap() {
    var map = new Map();
    map["id"] = id;
    map["menu_name"] = menu_name;
    map["get_sub_menu"] = get_sub_menu;
    return map;
  }
}
