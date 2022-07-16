import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/CompanyDataModal.dart';
import 'package:learning/Dashboard.dart';
import 'package:learning/EmployeeDashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'AppConstant.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:learning/CameraPreview.dart';

import 'DepartmentDataModal.dart';

class UpdateDepartmentStatus extends StatefulWidget {
  final int id;

  UpdateDepartmentStatus({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _UpdateDepartmentStatusState createState() => _UpdateDepartmentStatusState(
        id: id,
      );
}

class _UpdateDepartmentStatusState extends State<UpdateDepartmentStatus> {
  final int id;

  bool rememberMe = false;
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
  final _textTitle = TextEditingController();
  final _textDescription = TextEditingController();
  bool _validateTitle = false;
  bool _validateDesc = false;
  String _mySelection = "Hello";
  late List<dynamic> list = [];
  late List<dynamic> departmentlist = [];
  String _myDepartmentSelection = "";
  late var pickedImage = null;
  late var pickedImageTwo = null;
  late var pickedImageThree = null;
  late var pickedImageFour = null;
  late var pickedImageFive = null;

  _UpdateDepartmentStatusState({
    Key? key,
    required this.id,
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
          title: Text("Update Ticket Status"),
          backgroundColor: Colors.blue,
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Center(
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    Align(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 350.0,
                            height: 60,
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 10),
                            padding: const EdgeInsets.all(3.0),
                            child: DropdownButtonFormField(
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _mySelection = newValue!;
                                  });
                                },
                                hint: Text("Select Status"),
                                items: dropdownItems),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              maxLength: 1000,
                              controller: _textDescription,
                              decoration: InputDecoration(
                                errorText: _validateDesc
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                labelText: 'Remarks',
                                hintText: 'Please Enter Remarks',
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  openDialog(context, "1");
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 0.0, right: 0.0, top: 00),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 0.0, right: 0.0, top: 00),
                                    child: pickedImage != null
                                        ? Image.file(
                                            pickedImage,
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.fitHeight,
                                          )
                                        : Image.asset(
                                            'assets/frame.png',
                                            height: 200,
                                            width: 200,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20),
                            child: MaterialButton(
                              height: 50,
                              minWidth: 350,
                              child: Text("Submit"),
                              textColor: Colors.white,
                              color: const Color(0xff033F93),
                              onPressed: () {
                                setState(() {
                                  _textTitle.text.isEmpty
                                      ? _validateTitle = true
                                      : _validateTitle = false;

                                  _textDescription.text.isEmpty
                                      ? _validateDesc = true
                                      : _validateDesc = false;
                                });

                                updateApi(
                                    _textTitle.text, _textDescription.text);

                                //fetchPost();
                              },
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
      ),
    );
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("In-Progress"), value: "2"),
      DropdownMenuItem(child: Text("Completed"), value: "3"),
      DropdownMenuItem(child: Text("Cancelled"), value: "4"),
    ];
    return menuItems;
  }

  Future updateApi(String title, String description) async {
    EasyLoading.show();
    final prefs = await SharedPreferences.getInstance();
    final queryParameters = {
      'ticket_id': id.toString(),
      'status': _mySelection,
      'remarks': _textDescription.text.toString(),
      'resolved_image': base64Encode(pickedImage.readAsBytesSync()),
      'resolved_by_user_id': _textTitle.text.toString(),
    };
    print(queryParameters);
    final response =
        await http.post(Uri.parse(status_tickets), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        EasyLoading.dismiss();

        Fluttertoast.showToast(
            msg: "Status Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        if (prefs.getString('user_role') == "1") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyDashboardHomePages(
                      title: 'Eco App',
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
        EasyLoading.dismiss();

        Fluttertoast.showToast(
            msg: "Some Error Occured",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        if (prefs.getString('user_role') == "1") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyDashboardHomePages(
                      title: 'Eco App',
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
      }
    } else {
      EasyLoading.dismiss();
    }
  }

  //open picker after selectiong option
  OpenPicker(ImageSource source, String nos) async {
    String base64String = "";

    if (nos == "1") {
      pickedImage = (await ImagePicker.pickImage(source: source)) as File;
      base64String = base64Encode(pickedImage.readAsBytesSync());
    } else if (nos == "2") {
      pickedImageTwo = (await ImagePicker.pickImage(source: source)) as File;
      base64String = base64Encode(pickedImageTwo.readAsBytesSync());
    } else if (nos == "3") {
      pickedImageThree = (await ImagePicker.pickImage(source: source)) as File;
      base64String = base64Encode(pickedImageThree.readAsBytesSync());
    } else if (nos == "4") {
      pickedImageFour = (await ImagePicker.pickImage(source: source)) as File;
      base64String = base64Encode(pickedImageFour.readAsBytesSync());
    } else if (nos == "5") {
      pickedImageFive = (await ImagePicker.pickImage(source: source)) as File;
      base64String = base64Encode(pickedImageFive.readAsBytesSync());
    }

    print(base64String);
    Navigator.of(context, rootNavigator: true).pop();
    setState(() {});
  }

  void openDialog(BuildContext context, String nos) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              scrollable: true,
              content: Column(
                children: [
                  ListTile(
                    title: Text("Open Camera"),
                    onTap: () {
                      OpenPicker(ImageSource.camera, nos);
                    },
                  ),
                  ListTile(
                    title: Text("Take From Gallery"),
                    onTap: () {
                      OpenPicker(ImageSource.gallery, nos);
                    },
                  ),
                ],
              ),
            ));
  }

  @override
  void initState() {
    super.initState();
  }
}
