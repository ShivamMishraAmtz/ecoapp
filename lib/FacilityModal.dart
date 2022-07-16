class FacilityModal {
  final int employee_id;
  final int id;
  final String title;
  final String description;
  final String image;
  final String location;
  final String availibilty;
  final String cost;
  final String status;
  final String create_date;

  FacilityModal({
    required this.employee_id,
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.location,
    required this.availibilty,
    required this.cost,
    required this.status,
    required this.create_date
  });

  factory FacilityModal.fromJson(Map json) {

    String img="";

    if(json['image']==null)
      img="/media/uploads/profile/logo.png";
    else
      img=json['image'];

    return FacilityModal(
        employee_id: json['employee_id'],
        id: json['id'],
        title: json['title'],
        description: json['description'],
        location: json['location'],
        availibilty: json['availibilty'],
        cost: json['cost'],
        status: json['status'],
        image: img,
        create_date: json['create_date']);
  }

  Map toMap() {
    var map = new Map();
    map["employee_id"] = employee_id;
    map["id"] = id;
    map["title"] = title;
    map["description"] = description;
    map["location"] = location;
    map["availibilty"] = availibilty;
    map["cost"] = cost;
    map["status"] = status;
    map["image"] = image;
    map["create_date"] = create_date;
    return map;
  }
}
