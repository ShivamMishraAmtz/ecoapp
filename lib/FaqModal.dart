import 'package:learning/EmployeeUser.dart';

class FaqModal {
  final int id;
  final int added_by;
  final String question;
  final String answer;
  final String status;
  final String create_date;


  FaqModal({
    required this.id,
    required this.added_by,
    required this.question,
    required this.answer,
    required this.status,
    required this.create_date,
  });

  factory FaqModal.fromJson(Map json) {

    String img="";

    if(json['profile_image']==null)
      img="/media/uploads/profile/logo.png";
    else
      img=json['profile_image'];

    return FaqModal(
        id: json['id'],
        added_by: json['added_by'],
        question: json['question'],
        answer: json['answer'],
        status: json['status'],
        create_date: json['create_date']);


  }

  Map toMap() {
    var map = new Map();
    map["id"] = id;
    map["added_by"] = added_by;
    map["question"] = question;
    map["answer"] = answer;
    map["status"] = status;
    map["create_date"] = create_date;
    return map;
  }
}
