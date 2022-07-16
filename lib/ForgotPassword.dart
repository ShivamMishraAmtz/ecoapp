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
import 'Login.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPassword> {
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
                              left: 20.0, right: 20.0, top: 50),
                          child: TextField(
                            controller: _text,
                            decoration: InputDecoration(
                              labelText: 'Email',                              hintText: 'Please Enter Your Email Address',

                              errorText:
                              _validate ? 'Value Can\'t Be Empty' : null,
                              border: new OutlineInputBorder(
                                  borderSide:
                                  new BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),


                        Container(
                          margin:
                          const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                          child: MaterialButton(
                            height: 50,
                            minWidth: 350,
                            child: Text("Submit"),
                            textColor: Colors.white,
                            color: const Color(0xff033F93),
                            onPressed: () {

                              setState(() {
                                _text.text.isEmpty
                                    ? _validate = true
                                    : _validate = false;

                                if (!_validate)
                                  forgotPasswordApi(_text.text);
                              });
                              //fetchPost();
                            },
                          ),
                        ),

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

  Future forgotPasswordApi(String userid) async {
    EasyLoading.show();
    final queryParameters = {
      'email_id': userid
    };
    print(userid);
    final response =
    await http.post(Uri.parse(forgot_password), body: queryParameters);
    print(response.body.toString());
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginScreen(
              )),
        );
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
      print(response.body);
      Fluttertoast.showToast(
          msg: "Server Error",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1);
    }
  }


}
