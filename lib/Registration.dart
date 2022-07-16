import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:learning/CompanyDataModal.dart';
import 'package:learning/DepartmentDataModal.dart';
import 'AppConstant.dart';
import 'Login.dart';

class Registration extends StatefulWidget {

  @override
  _RegistrationPageState createState() => _RegistrationPageState();

}

class _RegistrationPageState extends State<Registration> {
  bool rememberMe = false;
  final _text = TextEditingController();
  final _textPassword = TextEditingController();
  final _textConfirmPassword = TextEditingController();
  final _textEmail = TextEditingController();
  final _texfName = TextEditingController();
  final _texlName = TextEditingController();
  final _texlEmail = TextEditingController();
  final _texlMobile = TextEditingController();
  bool _validate = false;
  bool _validateLname = false;
  bool _validateFname = false;
  bool _validateMobile = false;
  bool _validatePassword = false;
  bool _validateConfirmPassword = false;
  bool _validateEmail = false;
  late List<dynamic> list = [];
  late List<dynamic> departmentlist = [];
  String _myDepartmentSelection = "";
  String _mySelection = "";

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
                          margin: const EdgeInsets.only(top: 10.0),
                          child: Image.asset(
                            'assets/logo.png',
                            fit: BoxFit.contain,
                            width: 100,
                            height: 100,
                          ),
                        ),

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
                                    hint: new Text("Select Company"),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _mySelection = newValue!;
                                        departmentList();

                                      });
                                    },
                                    items: list.map((item) {
                                      return new DropdownMenuItem<String>(
                                        child: Text(item.company_name),
                                        value: item.id.toString(),
                                      );
                                    }).toList()),
                              ],
                            )
                        ),

                        // Container(
                        //     width: 100.0,
                        //     height: 60,
                        //     margin: const EdgeInsets.only(
                        //         left: 20.0, right: 20.0, top: 10),
                        //     padding: const EdgeInsets.all(3.0),
                        //     decoration: BoxDecoration(
                        //         border: Border.all(color: Colors.blueAccent)),
                        //
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       //Center Column contents vertically,
                        //       children: <Widget>[
                        //         DropdownButtonFormField<String>(
                        //             decoration:
                        //             InputDecoration.collapsed(hintText: ''),
                        //             isDense: true,
                        //             hint: new Text("Select Department"),
                        //             onChanged: (String? newValue) {
                        //               setState(() {
                        //                 _myDepartmentSelection = newValue!;
                        //               });
                        //             },
                        //             items: departmentlist.map((item) {
                        //               return new DropdownMenuItem<String>(
                        //                 child: Text(item.department_name),
                        //                 value: item.id.toString(),
                        //               );
                        //             }).toList()),
                        //       ],
                        //     )
                        // ),

                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20),
                          child: TextField(
                            controller: _texfName,
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              hintText: 'Please Enter Your First Name',
                              errorText:
                              _validateFname ? 'Value Can\'t Be Empty' : null,
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
                            controller: _texlName,
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              hintText: 'Please Enter Your Last Name',
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
                            controller: _texlEmail,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              hintText: 'Please Enter Your Email Address',
                              errorText:
                                  _validateEmail ? 'Value Can\'t Be Empty' : null,
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
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20),
                          child: TextField(
                            controller: _textConfirmPassword,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              hintText: 'Please Enter Your Password Again',
                              errorText: _validateConfirmPassword
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
                            controller: _texlMobile,
                            decoration: InputDecoration(
                              labelText: 'Mobile No',
                              hintText: 'Please Enter Your Mobile No',
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
                              left: 20.0, right: 20.0, top: 20,bottom: 20),
                          child: MaterialButton(
                            height: 50,
                            minWidth: 350,
                            child: Text("Submit"),
                            textColor: Colors.white,
                            color: const Color(0xff033F93),

                            onPressed: () {

                              setState(() {

                                _texfName.text.isEmpty
                                    ? _validateFname = true
                                    : _validateFname = false;

                                _texlName.text.isEmpty
                                    ? _validateLname = true
                                    : _validateLname = false;

                                _texlEmail.text.isEmpty
                                    ? _validateEmail = true
                                    : _validateEmail = false;

                                _textPassword.text.isEmpty
                                    ? _validatePassword = true
                                    : _validatePassword = false;

                                _texlMobile.text.isEmpty
                                    ? _validateMobile = true
                                    : _validateMobile = false;

                                _textConfirmPassword.text.isEmpty
                                    ? _validateConfirmPassword = true
                                    : _validateConfirmPassword = false;

                                if (!_validate && !_validatePassword && !_validateLname && !_validateFname && !_validateMobile && !_validateEmail)
                                       registerApi("1",_texfName.text, _texlName.text,
                                                  _texlEmail.text, _textPassword.text, _texlMobile.text,);
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
    companyList();
  }

  Future registerApi(String cid, String fname, String lname, String email,
      String password, String mobileno) async {
    EasyLoading.show();
    final queryParameters = {
      'company_id': _mySelection,
      'department_id': "",
      'first_name': fname,
      'last_name': lname,
      'email': email,
      'password': password,
      'phone_number': mobileno,
    };
    print(queryParameters);
    final response =
        await http.post(Uri.parse(user_register), body: queryParameters);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        EasyLoading.dismiss();
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
        EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: "Email Id is Already Registered",
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
      print("Hello");
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
    print("Department List"+response.body);
    if (response.statusCode == 200) {
      print("Hello Department");
      final jsonResponse = json.decode(response.body);
      try {
        var rest = jsonResponse["result"] as List;
        //print(jsonResponse["result"] as List);
        setState(() {
          departmentlist = rest
              .map<DepartmentDataModal>((json) =>
              DepartmentDataModal.fromJson(json))
              .toList();
        });
        print(departmentlist);
      }
      catch(err){
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

}
