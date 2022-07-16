import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppConstant.dart';
import 'Dashboard.dart';
import 'package:http/http.dart' as http;

import 'Login.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool rememberMe = false;
  bool _validate = false;
  final _text = TextEditingController();

  bool _validatePassword = false;
  final _textPassword = TextEditingController();

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          iconTheme: IconThemeData(color: Colors.white),
          title: Text("Change Password"),
          backgroundColor: Colors.blue,
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[

                  Align(
                    child: Column(
                      // set the mainAxisAlignment property here

                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 200),
                          child: TextField(
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            controller: _text,
                            decoration: InputDecoration(
                              errorText:
                                  _validate ? 'Value Can\'t Be Empty' : null,
                              labelText: 'Old Password',
                              hintText: 'Please Enter New Password',
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
                              errorText: _validatePassword
                                  ? 'Value Can\'t Be Empty'
                                  : null,
                              labelText: 'Confirm Password',
                              hintText: 'Please Confirm Your Password',
                              border: new OutlineInputBorder(
                                  borderSide:
                                      new BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20.0),
                          child: MaterialButton(
                            height: 50,
                            minWidth: 350,
                            child: Text("Update"),
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
                                  changePassword(
                                      _text.text, _textPassword.text);
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

  Future changePassword(String password, String new_password) async {

    EasyLoading.show();

    final prefs = await SharedPreferences.getInstance();

    final queryParameters = {
      'uuid': prefs.getInt("uuid").toString(),
      'old_password': password,
      'new_password': new_password,
    };

    print(queryParameters);

    final response =
        await http.post(Uri.parse(change_password), body: queryParameters);
    if (response.statusCode == 200) {

      EasyLoading.dismiss();

      final jsonResponse = json.decode(response.body);

      print(jsonResponse);

      if (jsonResponse['res_code'] == 200) {
        Fluttertoast.showToast(
            msg: jsonResponse['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Invalid Password",
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
}
