import 'LoginDataModal.dart';

class LoginMainModal {
  LoginDataModal loginDataModal;

  LoginMainModal({required this.loginDataModal});

  factory LoginMainModal.fromJson(Map<String, dynamic> parsedJson){
    return LoginMainModal(
        loginDataModal: LoginDataModal.fromJson(parsedJson['result'])
    );
  }

  Map toMap() {
    var map = new Map();
    map["result"] = loginDataModal;
    return map;
  }
}
