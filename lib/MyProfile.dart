import 'dart:convert';
import 'dart:io';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/CameraPreview.dart';
import 'package:learning/Dashboard.dart';
import 'package:learning/EmployeeDashboard.dart';
import 'package:learning/LoginDataModal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

import 'AppConstant.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  bool rememberMe = false;
  bool _validateFname = false;
  bool _validateLname = false;
  bool _validateMno = false;
  bool _validateOno = false;
  bool _validateOEmail = false;
  bool _validateAddress = false;
  var imageurl = "";

  final _text = TextEditingController();
  final _lText = TextEditingController();
  final _phoneText = TextEditingController();
  final _otherPhoneText = TextEditingController();
  final _otherEmail = TextEditingController();
  final _Address = TextEditingController();

  late CameraDescription camera;
  late CameraController controller;
  bool _isInited = false;
  late String _url;
  bool _validatePassword = false;
  final _textPassword = TextEditingController();
  late var pickedImage = null;
  late var base64String = null;

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
        title: Text("My Profile"),
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
                  child: ListView(
                    // set the mainAxisAlignment property here
                    children: <Widget>[

                      GestureDetector(
                        onTap: () {
                          openDialog(context);
                        },
                        child: new Container(
                          alignment: Alignment.topCenter,
                          margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                          child: base64String != null
                              ? CircleAvatar(
                                  radius: 60,
                                  child: new Image.memory(
                                    base64.decode(base64String),
                                    height: 80,
                                    width: 80,
                                  ))
                              : Image.asset(
                                  'assets/frame.png',
                                  height: 80,
                                  width: 80,
                                ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20),
                        child: TextField(
                          controller: _text,
                          decoration: InputDecoration(
                            hintText: 'First Name',
                            errorText: _validateAddress
                                ? 'Value Can\'t Be Empty'
                                : null,
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
                          controller: _lText,
                          decoration: InputDecoration(
                            hintText: 'Last Name',
                            errorText:
                                _validateLname ? 'Value Can\'t Be Empty' : null,
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
                          controller: _phoneText,
                          decoration: InputDecoration(
                            hintText: 'Please Enter Mobile No',
                            errorText:
                                _validateMno ? 'Value Can\'t Be Empty' : null,
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
                          controller: _otherPhoneText,
                          decoration: InputDecoration(
                            hintText: 'Please Enter Other Mobile No',
                            errorText:
                                _validateOno ? 'Value Can\'t Be Empty' : null,
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
                          controller: _otherEmail,
                          decoration: InputDecoration(
                            hintText: 'Please Enter Other Email Address',
                            errorText: _validateOEmail
                                ? 'Value Can\'t Be Empty'
                                : null,
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
                          controller: _Address,
                          decoration: InputDecoration(
                            hintText: 'Please Enter  Address',
                            errorText: _validateAddress
                                ? 'Value Can\'t Be Empty'
                                : null,
                            border: new OutlineInputBorder(
                                borderSide:
                                    new BorderSide(color: Colors.white)),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                            left: 20.0, right: 20.0, top: 20, bottom: 50),
                        child: MaterialButton(
                          height: 50,
                          minWidth: 350,
                          child: Text("Update"),
                          textColor: Colors.white,
                          color: const Color(0xff033F93),
                          onPressed: () {
                            setState(() {
                              updateApi(
                                  _text.text,
                                  _lText.text,
                                  _phoneText.text,
                                  _otherPhoneText.text,
                                  _otherEmail.text,
                                  _Address.text);
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
    ));
  }

  @override
  void initState() {
    super.initState();
    updateData();
  }

  Future updateApi(String first_name, String last_name, String phone_number,
      String other_mobile_number, String other_email, String address) async {
    EasyLoading.show();

    final prefs = await SharedPreferences.getInstance();
    final queryParameters = {
      'uuid': prefs.getInt("uuid").toString(),
      'first_name': first_name,
      'last_name': last_name,
      'phone_number': phone_number,
      'other_mobile_number': other_mobile_number,
      'other_email': other_email,
      'address': address,
      'profile_image': base64String,
    };
    print(queryParameters);
    final response =
        await http.post(Uri.parse(update_profile), body: queryParameters);
    print(response.body);
    print(queryParameters);
    print(base64String);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();

      final jsonResponse = json.decode(response.body);
      if (jsonResponse['res_code'] == 200) {
        final jsonResponse = json.decode(response.body);
        if (jsonResponse['res_code'] == 200) {
          Map<String, dynamic> map = json.decode(response.body);

          print(map["result"]["id"]);
          prefs.setString('other_number', map["result"]["other_mobile_number"]);
          prefs.setString('phone_number', map["result"]["phone_number"]);
          prefs.setString('address', map["result"]["address"]);
          prefs.setString('first_name', map["result"]["first_name"]);
          prefs.setString('last_name', map["result"]["last_name"]);
          prefs.setString('email', map["result"]["email"]);
          prefs.setString('profile_image', map["result"]["profile_image"]);
          prefs.setString('other_email', map["result"]["other_email"]);

          Fluttertoast.showToast(
              msg: "Profile Updated Successfully!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1);

          if (prefs.getString('user_role') == "1") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyDashboardHomePages(
                    title: "Eco App",
                  )),
            );
          } else {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MyHomePages(
                    title: 'Eco App',
                  )),
            );
          }
        } else {
          Fluttertoast.showToast(
              msg: "Invalid Credential",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1);
        }
      } else {}
    } else {
      EasyLoading.dismiss();
    }
  }

  //open picker after selectiong option
  OpenPicker(ImageSource source) async {
    pickedImage = (await ImagePicker.pickImage(source: source)) as File;
    base64String = base64Encode(pickedImage.readAsBytesSync());
    Navigator.pop(context);
    setState(() {});
  }

  void openDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              scrollable: true,
              content: Column(
                children: [
                  ListTile(
                    title: Text("Open Camera"),
                    onTap: () {
                      OpenPicker(ImageSource.camera);
                    },
                  ),
                  ListTile(
                    title: Text("Take From Gallery"),
                    onTap: () {
                      OpenPicker(ImageSource.gallery);
                    },
                  ),
                ],
              ),
            ));
  }

  void updateData() async {
    final prefs = await SharedPreferences.getInstance();
    _text.text = prefs.getString("first_name")!;
    _lText.text = prefs.getString("last_name")!;
    _phoneText.text = prefs.getString("phone_number")!;
    _otherPhoneText.text = prefs.getString("other_number")!;
    _otherEmail.text = prefs.getString("other_email")!;
    _Address.text = prefs.getString("address")!;
    imageurl = prefs.getString("profile_image")!;
    http.Response response = await http.get(
      API_Base_urlWithout + imageurl,
    );
    base64String = base64Encode(response.bodyBytes);
    setState(() {});
  }
}
