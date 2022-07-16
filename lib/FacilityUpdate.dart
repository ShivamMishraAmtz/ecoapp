import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:learning/EmployeeModal.dart';
import 'AppConstant.dart';
import 'Dashboard.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FacilityUpdate extends StatefulWidget {
  var employee_id;
  var id;
  var title;
  var description;
  var image;
  var location;
  var availibilty;
  var cost;
  var status;
  var create_date;

  FacilityUpdate(
      {Key? key,
        required this.employee_id,
        required this.id,
        required this.title,
        required this.description,
        required this.image,
        required this.location,
        required this.availibilty,
        required this.cost,
        required this.status,
        required this.create_date})
      : super(key: key);

  @override
  _FacilityUpdateState createState() => _FacilityUpdateState(
    employee_id: employee_id,
    id: id,
    title: title,
    description: description,
    image: image,
    location: location,
    availibilty: availibilty,
    cost: cost,
    status: status,
    create_date: create_date,
  );

}

class _FacilityUpdateState extends State<FacilityUpdate> {
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

  var employee_id;
  var id;
  var title;
  var description;
  var image;
  var location;
  var availibilty;
  var cost;
  var status;
  var create_date;

  _FacilityUpdateState(
      {Key? key,
        required this.employee_id,
        required this.id,
        required this.title,
        required this.description,
        required this.image,
        required this.location,
        required this.availibilty,
        required this.cost,
        required this.status,
        required this.create_date});

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
                                  left: 20.0, right: 20.0, top: 50),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blueAccent)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                //Center Column contents vertically,
                                children: <Widget>[
                                  DropdownButtonFormField<String>(
                                      isExpanded: true,
                                      decoration:
                                      InputDecoration.collapsed(hintText: ''),
                                      isDense: true,
                                      hint: new Text("Select Approver"),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _mySelection = newValue!;
                                        });
                                      },
                                      items: list.map((item) {
                                        return new DropdownMenuItem<String>(
                                          child: Text(
                                            item.user_id.first_name,
                                            style: TextStyle(height: 1.5),
                                          ),
                                          value: item.id.toString(),
                                        );
                                      }).toList()),
                                ],
                              )),
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
                                left: 20.0, right: 20.0, top: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              maxLength: 1000,
                              controller: _textFacilityDescription,
                              decoration: InputDecoration(
                                errorText: _validateFacilityDescription
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                labelText: 'Event Description',
                                hintText: 'Please Enter Your Event Description',
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 10,bottom: 20),
                            child: TextField(
                              controller: _textFacilityLocation,
                              decoration: InputDecoration(
                                labelText: 'Event Facility Location',
                                hintText: 'Please Enter Facility Location',
                                errorText:
                                _validateFacilityLocation ? 'Value Can\'t Be Empty' : null,
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 20),
                            child: TextField(
                              controller: _textFacilityAvailibility,
                              decoration: InputDecoration(
                                labelText: 'Event Facility Availibility',
                                hintText: 'Please Enter Facility Availibility',
                                errorText:
                                _validateFacilityAvailibility ? 'Value Can\'t Be Empty' : null,
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, bottom: 20),
                            child: TextField(
                              controller: _textFacilityCost,
                              decoration: InputDecoration(
                                labelText: 'Event Facility Cost',
                                hintText: 'Please Enter Facility Cost',
                                errorText:
                                _validateFacilityCost ? 'Value Can\'t Be Empty' : null,
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              openDialog(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  left: 0.0, right: 0.0, top: 00),
                              child: Container(
                                margin: const EdgeInsets.only(
                                    left: 0.0, right: 0.0, top: 00),
                                child: base64String != null
                                    ? new Image.memory(
                                  base64.decode(base64String),
                                  height: 100,
                                  width: 100,
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

                                  _textFacilityDescription.text.isEmpty
                                      ? _validateFacilityDescription = true
                                      : _validateFacilityDescription = false;

                                  _textFacilityLocation.text.isEmpty
                                      ? _validateFacilityLocation = true
                                      : _validateFacilityLocation = false;

                                  _textFacilityAvailibility.text.isEmpty
                                      ? _validateFacilityAvailibility = true
                                      : _validateFacilityAvailibility = false;

                                  _textFacilityCost.text.isEmpty
                                      ? _validateFacilityCost = true
                                      : _validateFacilityCost = false;


                                  if (!_validateFacilityTitle && !_validateFacilityDescription &&
                                      !_validateFacilityLocation && !_validateFacilityAvailibility && !_validateFacilityCost)
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
    employeeList();
    updateData();
  }

  Future updateApi() async {
    final queryParameters = {
      'facilities_id': id.toString(),
      'employee_id': _mySelection.toString(),
      'title': _textFacilityTitle.text,
      'description':_textFacilityDescription.text,
      'location':_textFacilityLocation.text,
      'availibilty':_textFacilityAvailibility.text,
      'cost':_textFacilityCost.text,
      'create_date':'2022-01-11',
      'image': base64String
    };
    print(queryParameters);
    final response =
    await http.post(Uri.parse(update_facilites), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        Fluttertoast.showToast(
            msg: "Announcement Added Successfully",
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

  Future employeeList() async {
    final response = await http.get(Uri.parse(employee_list));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var rest = jsonResponse["result"]["result_data"] as List;
      list = rest
          .map<EmployeeModal>((json) => EmployeeModal.fromJson(json))
          .toList();
      print(list);
      setState(() {});
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
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
    _textFacilityTitle.text = title;
    _textFacilityDescription.text = description;
    _textFacilityCost.text = cost;
    _textFacilityAvailibility.text = availibilty;
    _textFacilityLocation.text = location;
    _mySelection = employee_id.toString();
    http.Response response = await http.get(
      image,
    );
    base64String = base64Encode(response.bodyBytes);
    setState(() {});
  }


}
