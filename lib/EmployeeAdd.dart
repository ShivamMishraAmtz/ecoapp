import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:learning/CompanyDataModal.dart';
import 'package:learning/Dashboard.dart';
import 'package:learning/DepartmentDataModal.dart';
import 'package:learning/LoginDataModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AppConstant.dart';
import 'Dashboard.dart';
import 'EmployeeDashboard.dart';
import 'ForgotPassword.dart';
import 'Login.dart';

class EmployeeAdd extends StatefulWidget {
  @override
  _EmployeeAddState createState() => _EmployeeAddState();
}

class _EmployeeAddState extends State<EmployeeAdd> {
  String _myDepartmentSelection = "";

  late List<dynamic> departmentlist = [];

  bool rememberMe = false;
  bool _validate = false;
  final _text = TextEditingController();
  late List<dynamic> list = [];
  final _textPassword = TextEditingController();
  String _mySelection = "";

  final _ftext = TextEditingController();
  final _lText = TextEditingController();
  final _phoneText = TextEditingController();
  final _Email = TextEditingController();
  final _Password = TextEditingController();

  bool _validateComapany = false;
  bool _validateFname = false;
  bool _validateLname = false;
  bool _validateMobile = false;
  bool _validateEmail = false;
  bool _validatePassword = false;

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
          title: Text("Add New Employee"),
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
                        // Container(
                        //     width: 100.0,
                        //     height: 60,
                        //     margin: const EdgeInsets.only(
                        //         left: 20.0, right: 20.0, top: 10),
                        //     padding: const EdgeInsets.all(3.0),
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: Colors.blueAccent)),
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       //Center Column contents vertically,
                        //       children: <Widget>[
                        //         DropdownButtonFormField<String>(
                        //             decoration:
                        //                 InputDecoration.collapsed(hintText: ''),
                        //             isDense: true,
                        //             hint: new Text("Select Company"),
                        //             onChanged: (String? newValue) {
                        //               setState(() {
                        //                 _mySelection = newValue!;
                        //                 departmentList();
                        //               });
                        //             },
                        //             items: list.map((item) {
                        //               return new DropdownMenuItem<String>(
                        //                 child: Text(item.company_name),
                        //                 value: item.id.toString(),
                        //               );
                        //             }).toList()),
                        //       ],
                        //     )),
                        Container(
                            width: 100.0,
                            height: 60,
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 10),
                            padding: const EdgeInsets.all(3.0),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //Center Column contents vertically,
                              children: <Widget>[
                                DropdownButtonFormField<String>(
                                    decoration:
                                        InputDecoration.collapsed(hintText: ''),
                                    isDense: true,
                                    hint: new Text("Select Department"),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _myDepartmentSelection = newValue!;
                                      });
                                    },
                                    items: departmentlist.map((item) {
                                      return new DropdownMenuItem<String>(
                                        child: Text(item.department_name),
                                        value: item.id.toString(),
                                      );
                                    }).toList()),
                              ],
                            )),
                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20),
                          child: TextField(
                            controller: _ftext,
                            decoration: InputDecoration(
                              hintText: 'Enter Employee First Name',
                              errorText: _validateFname
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
                              hintText: 'Enter Employee Last Name',
                              errorText: _validateLname
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
                            controller: _phoneText,
                            decoration: InputDecoration(
                              hintText: 'Enter Employee Mobile No',
                              errorText: _validateMobile
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
                            controller: _Email,
                            decoration: InputDecoration(
                              hintText: 'Enter Email Address',
                              errorText: _validateEmail
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
                            controller: _textPassword,
                            decoration: InputDecoration(
                              hintText: 'Enter Password',
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
                                _ftext.text.isEmpty
                                    ? _validateFname = true
                                    : _validateFname = false;

                                _lText.text.isEmpty
                                    ? _validateLname = true
                                    : _validateLname = false;

                                _Email.text.isEmpty
                                    ? _validateEmail = true
                                    : _validateEmail = false;

                                _textPassword.text.isEmpty
                                    ? _validatePassword = true
                                    : _validatePassword = false;

                                _phoneText.text.isEmpty
                                    ? _validateMobile = true
                                    : _validateMobile = false;

                                if (!_validateFname &&
                                    !_validateLname &&
                                    !_validateEmail &&
                                    !_validatePassword &&
                                    !_validateMobile)
                                  updateApi(
                                      _mySelection,
                                      _ftext.text,
                                      _lText.text,
                                      _Email.text,
                                      _textPassword.text,
                                      _phoneText.text);
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

  Future companyList() async {
    final response = await http.get(Uri.parse(company_list));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var rest = jsonResponse["result"] as List;
      //print(jsonResponse["result"] as List);

      setState(() {
        list = rest
            .map<CompanyDataModal>((json) => CompanyDataModal.fromJson(json))
            .toList();
      });

      print(list);
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }

  Future departmentList() async {
    final queryParameters = {
      'company_id': _mySelection,
    };
    final response =
        await http.post(Uri.parse(department_list), body: queryParameters);
    print("Department List" + response.body);
    if (response.statusCode == 200) {
      print("Hello Department");
      final jsonResponse = json.decode(response.body);
      try {
        var rest = jsonResponse["result"] as List;
        //print(jsonResponse["result"] as List);
        setState(() {
          departmentlist = rest
              .map<DepartmentDataModal>(
                  (json) => DepartmentDataModal.fromJson(json))
              .toList();
        });
        print(departmentlist);
      } catch (err) {
        setState(() {
          departmentlist.clear();
        });
        print(err.toString());
      }
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }

  @override
  void initState() {
    super.initState();
    companyList();
  }

  Future updateApi(String company_id, String first_name, String last_name,
      String email_id, String password, String phone_number) async {
    EasyLoading.show();

    final prefs = await SharedPreferences.getInstance();
    final queryParameters = {
      'company_id': company_id,
      'first_name': first_name,
      'last_name': last_name,
      'email_id': email_id,
      'password': password,
      'phone_number': phone_number,
      'department_id': _myDepartmentSelection,
      'profile_image': base64String
    };

    print(queryParameters);
    final response =
        await http.post(Uri.parse(employee_creation), body: queryParameters);

    print(response.statusCode);

    if (response.statusCode == 200) {
      EasyLoading.dismiss();

      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePages(
                    title: 'Eco App',
                  )),
        );
      } else {
        Fluttertoast.showToast(
            msg: jsonResponse['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        //print(response.statusCode);
      }
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
}
