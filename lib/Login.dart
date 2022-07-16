import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:learning/CompanyDataModal.dart';
import 'package:learning/LoginDataModal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppConstant.dart';
import 'Dashboard.dart';
import 'EmployeeDashboard.dart';
import 'ForgotPassword.dart';
import 'Registration.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  bool rememberMe = false;
  final _text = TextEditingController();
  final _textPassword = TextEditingController();
  bool _validate = false;
  bool _validatePassword = false;

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;
        if (rememberMe) {
        } else {}
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Align(
                    child: ListView(
                      // set the mainAxisAlignment property here
                      children: <Widget>[
                        Container(
                          alignment: Alignment.topCenter,
                          margin: const EdgeInsets.only(top: 100.0),
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                            width: 150,
                            height: 150,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 10),
                          child: TextField(
                            controller: _text,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Please Enter Your Email Address',
                              errorText:
                                  _validate ? 'Value Can\'t Be Empty' : null,
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20),
                          child: TextField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _textPassword,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              hintText: 'Please Enter Your Password',
                              errorText: _validatePassword
                                  ? 'Value Can\'t Be Empty'
                                  : null,
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        Container(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: <Widget>[
                                    SizedBox(width: 5),
                                    Checkbox(
                                      value: rememberMe,
                                      onChanged: (bool? value) {
                                        _onRememberMeChanged(value!);
                                      },
                                    ),
                                    Text("Remember Me"),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ForgotPassword()),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 20.0),
                                    child: Text("Forgot Password?"),
                                  ),
                                )
                              ]),
                        ),
                        Container(
                          margin:
                              const EdgeInsets.only(left: 20.0, right: 20.0),
                          child: MaterialButton(
                            height: 50,
                            minWidth: 350,
                            child: Text("Login"),
                            textColor: Colors.white,
                            color: const Color(0xff033F93),
                            onPressed: () {
                              setState(() {
                                _text.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;

                                _textPassword.text.isEmpty
                                    ? _validatePassword = true
                                    : _validatePassword = false;

                                if (!_validate && !_validatePassword)
                                  loginApi(_text.text, _textPassword.text);
                              });
                              //fetchPost();
                            },
                          ),
                        ),
                        GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Registration()),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Don't have an acount sign up?"),
                              ),
                            ))
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future loginApi(String userid, String password) async {
    EasyLoading.show();
    final prefs = await SharedPreferences.getInstance();
    print(prefs.getInt("uuid"));
    final queryParameters = {
      'email': userid.replaceAll(' ', ''),
      'password': password.replaceAll(' ', ''),
      'device_id': 'asdf12345678',
    };
    print(queryParameters);
    final response =
        await http.post(Uri.parse(user_login), body: queryParameters);
    print(response.body.toString());
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        try {
          var rest = jsonResponse["result"]["employee_details"] as List;
          List<dynamic> list = rest
              .map<LoginDataModal>((json) => LoginDataModal.fromJson(json))
              .toList();
          var uuid = jsonResponse["result"]["uuid"] as int;
          var first_name = jsonResponse["result"]["first_name"] as String;
          var last_name = jsonResponse["result"]["last_name"] as String;
          var email = jsonResponse["result"]["email"] as String;
          var user_role = jsonResponse["result"]["user_role"] as String;
          var login_id = jsonResponse["result"]["login_id"] as int;
          prefs.setString('user_role', user_role);
          prefs.setString('email', jsonResponse["result"]["email"]);
          if (user_role == "1") {
            prefs.setInt('uuid', uuid);
            prefs.setString('first_name', first_name);
            prefs.setString('last_name', last_name);
            prefs.setInt('login_id', login_id);
            prefs.setString('other_number', list[0].other_number.toString());
            prefs.setString('phone_number', list[0].phone_number.toString());
            prefs.setString('profile_image', list[0].profile_image.toString());
            prefs.setString('other_email', list[0].other_email.toString());
            prefs.setString('employee_id', list[0].employee_id.toString());
            prefs.setString('address', list[0].address.toString());
            // prefs.setInt('pincode', list[0].pincode);
            prefs.setString('city', list[0].city.toString());
            prefs.setString('dob', list[0].dob.toString());


            prefs.setString('company', list[0].company.toString());
            prefs.setString('department', list[0].department.toString());

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyDashboardHomePages(
                        title: 'Eco App',
                      )),
            );
          } else if (user_role == "2") {
            EasyLoading.dismiss();

            prefs.setInt('uuid', uuid);
            prefs.setString('first_name', first_name);
            prefs.setString('last_name', last_name);
            prefs.setInt('login_id', login_id);
            prefs.setString('other_number', list[0].other_number.toString());
            prefs.setString('phone_number', list[0].phone_number.toString());
            prefs.setString('profile_image', list[0].profile_image.toString());
            prefs.setString('other_email', list[0].other_email.toString());
            prefs.setString('employee_id', list[0].employee_id.toString());
            prefs.setString('address', list[0].address.toString());
            // prefs.setInt('pincode', list[0].pincode);
            prefs.setString('city', list[0].city.toString());
            prefs.setString('dob', list[0].dob.toString());

            prefs.setString('company', list[0].company.toString());
            prefs.setString('department', list[0].department.toString());


            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePages(
                        title: 'Eco App',
                      )),
            );
          }
        } on Exception catch (_) {



          Fluttertoast.showToast(
              msg: "Invalid Credential",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1);
        }
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: "Invalid Credential",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      }
    } else {
      EasyLoading.dismiss();
      print(response.statusCode);
      Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }
  }

  Future companyList() async {
    final response = await http.get(Uri.parse(company_list));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var rest = jsonResponse["result"] as List;
      //print(jsonResponse["result"] as List);
      List<dynamic> list = rest
          .map<CompanyDataModal>((json) => CompanyDataModal.fromJson(json))
          .toList();
      print(list[0].company_name);
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }
}
