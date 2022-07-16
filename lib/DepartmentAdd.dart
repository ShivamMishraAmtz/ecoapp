import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/CompanyDataModal.dart';
import 'package:learning/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:learning/DepartmentDataModal.dart';
import 'package:learning/EmployeeModal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppConstant.dart';
import 'Dashboard.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class DepartmentAdd extends StatefulWidget {
  @override
  _DepartmentAddState createState() => _DepartmentAddState();
}

class _DepartmentAddState extends State<DepartmentAdd> {
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


  late List<dynamic> list = [];
  String _mySelection = "";

  final _textFacilityTitle = TextEditingController();
  bool _validateFacilityTitle = false;

  final _textFacilityDescription = TextEditingController();
  bool _validateFacilityDescription = false;

  final _textFacilityLocation = TextEditingController();
  bool _validateFacilityLocation = false;

  final _textFacilityAvailibility = TextEditingController();
  bool _validateFacilityAvailibility = false;

  final _textFacilityCost = TextEditingController();
  bool _validateFacilityCost = false;
  late var pickedImage = null;
  late var base64String = null;



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
          title: Text("Add New Facility"),
          backgroundColor: Colors.blue,
          actions: <Widget>[

          ],
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


                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20),
                            child: TextField(
                              controller: _textFacilityTitle,
                              decoration: InputDecoration(
                                labelText: 'Event Facility Title',
                                hintText: 'Please Enter Your Event Title',
                                errorText:
                                _validateFacilityTitle ? 'Value Can\'t Be Empty' : null,
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
                                  _textFacilityTitle.text.isEmpty
                                      ? _validateFacilityTitle = true
                                      : _validateFacilityTitle = false;

                                  if (!_validateFacilityTitle && _mySelection!="")
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
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    companyList();
  }

  Future updateApi() async {

    EasyLoading.show();

    final prefs = await SharedPreferences.getInstance();
    print(prefs.getInt("uuid"));

    final queryParameters = {
      'company_id': _mySelection.toString(),
      'department_name': _textFacilityTitle.text,
      'user_id':prefs.getInt("uuid").toString(),
    };
    print(queryParameters);
    final response =
    await http.post(Uri.parse(department_register), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {

      EasyLoading.dismiss();

      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        Fluttertoast.showToast(
            msg: "Department Added Successfully",
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


}
