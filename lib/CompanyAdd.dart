import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning/AppConstant.dart';
import 'package:learning/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CompanyAdd extends StatefulWidget {
  @override
  _CompanyAddState createState() => _CompanyAddState();
}

class _CompanyAddState extends State<CompanyAdd> {
  bool rememberMe = false;
  bool _validate = false;
  final _text = TextEditingController();

  final _textPassword = TextEditingController();

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });

  late var pickedImage = null;

  final _textCompanyName = TextEditingController();
  final _textContactNo = TextEditingController();
  final _textEmail = TextEditingController();
  final _textRegistrationNo = TextEditingController();
  final _textCompanyType = TextEditingController();
  final _textHeadofficeLocation = TextEditingController();
  final _textDescription = TextEditingController();
  final _textOtherContactNo = TextEditingController();
  final _textUrl = TextEditingController();

  bool _validatePassword = false;
  bool _validateEmail = false;
  bool _validateCompanyName = false;
  bool _validateContactNo = false;
  bool _validateOtherContactNo = false;
  bool _validateRegistrationNo = false;
  bool _validateCompanyType = false;
  bool _validateHeadofficeLocation = false;
  bool _validateDescription = false;
  bool _validateUrl = false;

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
          title: Text("Add New Company"),
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
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 20),
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 00),
                              child: pickedImage != null
                                  ? Image.file(
                                pickedImage,
                                width: 100,
                                height: 100,
                                fit: BoxFit.fitHeight,
                              )
                                  : Image.asset(
                                'assets/logo.png',
                                height: 100,
                                width: 100,
                              ),
                            ),
                          ),
                        ),


                        Container(
                          margin: const EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20),
                          child: TextField(
                            controller: _textCompanyName,
                            decoration: InputDecoration(
                              hintText: 'Enter Company Name',
                              errorText: _validateCompanyName
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
                            controller: _textContactNo,
                            decoration: InputDecoration(
                              hintText: 'Enter Company Contact No',
                              errorText: _validateContactNo
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
                            controller: _textOtherContactNo,
                            decoration: InputDecoration(
                              hintText: 'Enter Company Other Contact No',
                              errorText: _validateOtherContactNo
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
                            controller: _textEmail,
                            decoration: InputDecoration(
                              hintText: 'Enter Company Email Address',
                              errorText: _validateContactNo
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
                            controller: _textCompanyType,
                            decoration: InputDecoration(
                              hintText: 'Enter Company Type',
                              errorText: _validateCompanyType
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
                            controller: _textHeadofficeLocation,
                            decoration: InputDecoration(
                              hintText: 'Enter Company Head Office Location',
                              errorText: _validateHeadofficeLocation
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
                            controller: _textDescription,
                            decoration: InputDecoration(
                              errorText: _validateDescription
                                  ? 'Value Can\'t Be Empty'
                                  : null,
                              hintText: 'Generate Company Description',
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
                            controller: _textUrl,
                            decoration: InputDecoration(
                              errorText: _validateUrl
                                  ? 'Value Can\'t Be Empty'
                                  : null,
                              hintText: 'Enter Company URL',
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
                            child: Text("Submit"),
                            textColor: Colors.white,
                            color: const Color(0xff033F93),
                            onPressed: () {
                              setState(() {
                                _textCompanyName.text.isEmpty
                                    ? _validateCompanyName = true
                                    : _validateCompanyName = false;

                                _textContactNo.text.isEmpty
                                    ? _validateContactNo = true
                                    : _validateContactNo = false;

                                _textCompanyType.text.isEmpty
                                    ? _validateCompanyType = true
                                    : _validateCompanyType = false;

                                _textDescription.text.isEmpty
                                    ? _validateDescription = true
                                    : _validateDescription = false;

                                _textHeadofficeLocation.text.isEmpty
                                    ? _validateHeadofficeLocation = true
                                    : _validateHeadofficeLocation = false;

                                _textEmail.text.isEmpty
                                    ? _validateEmail = true
                                    : _validateEmail = false;

                                updateApi();
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

  Future updateApi() async {
    EasyLoading.show();
    final queryParameters = {
      'company_name': _textCompanyName.text,
      'mobile_number_first': _textContactNo.text,
      'mobile_number_second': _textOtherContactNo.text,
      'email_id': _textEmail.text,
      'company_address': _textHeadofficeLocation.text,
      'description': _textDescription.text,
      'type': _textCompanyType.text,
      'url': _textUrl.text,
      'company_logo': base64Encode(pickedImage.readAsBytesSync()),
    };

    final response =
        await http.post(Uri.parse(company_register), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        Fluttertoast.showToast(
            msg: "Company Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePages(
                    title: 'Eco App',
                  )),
        );
      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(
            msg: "Some Error Occured",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePages(
                    title: 'Eco App',
                  )),
        );
      }
    }
  }

  //open picker after selectiong option
  OpenPicker(ImageSource source) async {
    pickedImage = (await ImagePicker.pickImage(source: source)) as File;
    String base64String = base64Encode(pickedImage.readAsBytesSync());
    print(base64String);
    Navigator.of(context, rootNavigator: true).pop();
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
