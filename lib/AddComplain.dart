import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/CompanyDataModal.dart';
import 'package:learning/Complain.dart';
import 'package:learning/Dashboard.dart';
import 'package:learning/EmployeeDashboard.dart';
import 'package:learning/TicketCategoryModal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'AppConstant.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:learning/CameraPreview.dart';

import 'DepartmentDataModal.dart';

class AddComplain extends StatefulWidget {
  @override
  _AnnouncementAddState createState() => _AnnouncementAddState();
}

class _AnnouncementAddState extends State<AddComplain> {
  bool rememberMe = false;
  bool _validatePassword = false;
  final _textPassword = TextEditingController();

  void _onRememberMeChanged(bool newValue) =>
      setState(() {
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
  String _mySelection = "";
  late List<dynamic> list = [];
  late List<dynamic> departmentlist = [];
  late List<dynamic> ticketcategorylist = [];
  String _myDepartmentSelection = "";
  String _myTicketCategorySelection = "";

  late var pickedImage = null;
  late var pickedImageTwo = null;
  late var pickedImageThree = null;
  late var pickedImageFour = null;
  late var pickedImageFive = null;

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
          title: Text("Register New Ticket"),
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

                          // Container(
                          //     width: 350.0,
                          //     height: 60,
                          //     margin: const EdgeInsets.only(
                          //         left: 20.0, right: 15, top: 10),
                          //     padding: const EdgeInsets.all(3),
                          //     decoration: BoxDecoration(
                          //         border: Border.all(color: Colors.blueAccent)),
                          //     child: Column(
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       //Center Column contents vertically,
                          //       children: <Widget>[
                          //
                          //
                          //         DropdownButtonFormField<String>(
                          //
                          //             isExpanded: true,
                          //             decoration: InputDecoration.collapsed(
                          //                 hintText: ''),
                          //             isDense: true,
                          //             hint: new Text("Select Company",
                          //
                          //
                          //             ),
                          //             onChanged: (String? newValue) {
                          //               setState(() {
                          //                 _mySelection = newValue!;
                          //                 //departmentList();
                          //               });
                          //             },
                          //             items: list.map((item) {
                          //               return new DropdownMenuItem<String>(
                          //                 child: Text(
                          //                   item.company_name,
                          //                   overflow: TextOverflow.clip,
                          //                   style: new TextStyle(
                          //                     fontSize: 15.0,
                          //
                          //                     color: new Color(0xFF212121),
                          //                   ),
                          //                 ),
                          //                 value: item.id.toString(),
                          //               );
                          //             }).toList())
                          //
                          //       ],
                          //     )),

                          Container(
                              width: 350.0,
                              height: 60,
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 15.0, top: 10),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //Center Column contents vertically,
                                children: <Widget>[
                                  DropdownButtonFormField<String>(
                                       isExpanded: true,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ''),
                                      isDense: true,
                                      hint: new Text("Select Department"),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _myDepartmentSelection = newValue!;
                                        });
                                      },
                                      items: departmentlist.map((item) {
                                        return new DropdownMenuItem<String>(

                                          child: Text(item.department_name,

                                          ),
                                          value: item.id.toString(),
                                        );
                                      }).toList()),
                                ],
                              )),


                          Container(
                              width: 350.0,
                              height: 60,
                              margin: const EdgeInsets.only(
                                  left: 20.0, right: 15.0, top: 10),
                              padding: const EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //Center Column contents vertically,
                                children: <Widget>[
                                  DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ''),
                                      isDense: true,
                                      hint: new Text("Select Ticket Category",
                                        overflow: TextOverflow.clip,
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _myTicketCategorySelection =
                                          newValue!;
                                        });
                                      },
                                      items: ticketcategorylist.map((item) {
                                        return new DropdownMenuItem<String>(
                                          child: Text(item.categories_name),
                                          value: item.id.toString(),
                                        );
                                      }).toList()),
                                ],
                              )),

                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 15.0, top: 10),
                            child: TextField(
                              controller: _textTitle,
                              decoration: InputDecoration(
                                labelText: 'Subject',
                                hintText:
                                'Please Enter Subject',
                                errorText: _validateTitle
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
                                left: 20.0, right: 15.0, top: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 4,
                              maxLength: 1000,
                              controller: _textDescription,
                              decoration: InputDecoration(
                                errorText: _validateDesc
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                labelText: 'Description',
                                hintText:
                                'Please Enter Your Complain Description',
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
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    )
                                        : Image.asset(
                                      'assets/frame.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  openDialog(context, "2");
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 0.0, right: 0.0, top: 00),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 0.0, right: 0.0, top: 00),
                                    child: pickedImageTwo != null
                                        ? Image.file(
                                      pickedImageTwo,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    )
                                        : Image.asset(
                                      'assets/frame.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  openDialog(context, "3");
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 0.0, right: 0.0, top: 00),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 0.0, right: 0.0, top: 00),
                                    child: pickedImageThree != null
                                        ? Image.file(
                                      pickedImageThree,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    )
                                        : Image.asset(
                                      'assets/frame.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  openDialog(context, "4");
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 0.0, right: 0.0, top: 00),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 0.0, right: 0.0, top: 00),
                                    child: pickedImageFour != null
                                        ? Image.file(
                                      pickedImageFour,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    )
                                        : Image.asset(
                                      'assets/frame.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  openDialog(context, "5");
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(
                                      left: 0.0, right: 0.0, top: 00),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                        left: 0.0, right: 0.0, top: 00),
                                    child: pickedImageFive != null
                                        ? Image.file(
                                      pickedImageFive,
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.fitHeight,
                                    )
                                        : Image.asset(
                                      'assets/frame.png',
                                      height: 100,
                                      width: 100,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 100,
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 10),
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

  Future updateApi(String title, String description) async {
    EasyLoading.show();

    final prefs = await SharedPreferences.getInstance();

    String img_str1 = "";
    String img_str2 = "";
    String img_str3 = "";
    String img_str4 = "";
    String img_str5 = "";

    if (pickedImage != null) {
      img_str1 = base64Encode(pickedImage.readAsBytesSync());
    }

    if (pickedImageTwo != null) {
      img_str2 = base64Encode(pickedImageTwo.readAsBytesSync());
    }

    if (pickedImageThree != null) {
      img_str3 = base64Encode(pickedImageThree.readAsBytesSync());
    }

    if (pickedImageFour != null) {
      img_str4 = base64Encode(pickedImageFour.readAsBytesSync());
    }

    if (pickedImageFive != null) {
      img_str5 = base64Encode(pickedImageFive.readAsBytesSync());
    }

    final queryParameters = {
      'complaints_user': prefs.getInt("uuid").toString(),
      'company_id': "1",
      'department_id': _myDepartmentSelection,
      'subject': _textTitle.text.toString(),
      'description': _textDescription.text.toString(),
      'image_one': img_str1,
      'image_two': img_str2,
      'image_three': img_str3,
      'image_four': img_str4,
      'image_five': img_str5,
      'categories_id': _myTicketCategorySelection.toString(),
    };

    print(queryParameters);

    final response =
    await http.post(Uri.parse(ticket_add), body: queryParameters);

    print(response.body);

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

        if (prefs.getString('user_role') == "1") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    Complain(
                    )),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MyHomePages(
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
                builder: (context) =>
                    MyDashboardHomePages(
                      title: 'Eco App',
                    )),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    MyHomePages(
                      title: 'Eco App',
                    )),
          );
        }
      }
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
        builder: (context) =>
            AlertDialog(
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
    companyList();
    categoryList();

    departmentList();
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
      'company_id': "1",
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

  Future categoryList() async {
    final response = await http.get(Uri.parse(catagories_list));
    print("Category" + response.body);
    if (response.statusCode == 200) {
      print("Hello");

      final jsonResponse = json.decode(response.body);
      var rest = jsonResponse["result"] as List;
      //print(jsonResponse["result"] as List);
      setState(() {
        ticketcategorylist = rest
            .map<TicketCategoryModal>((json) =>
            TicketCategoryModal.fromJson(json))
            .toList();
      });
      print(ticketcategorylist);
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }


  showAlertDialog() {
    // set up the buttons
    Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {

        }
    );
    Widget continueButton = TextButton(
      child: Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text(
          "Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
  }
}