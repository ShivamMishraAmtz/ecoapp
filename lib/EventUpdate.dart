import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:learning/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'AppConstant.dart';
import 'dart:io';

class EventUpdate extends StatefulWidget {
  var id;
  var title = "";
  var description = "";
  var image = "";
  var from_date = "";
  var to_date = "";

  EventUpdate(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.from_date,
      required this.to_date})
      : super(key: key);

  @override
  _EventUpdateState createState() => _EventUpdateState(
      id: id,
      title: title,
      description: description,
      image: image,
      from_date: from_date,
      to_date: to_date);
}

class _EventUpdateState extends State<EventUpdate> {
  bool rememberMe = false;
  bool _validate = false;
  final _text = TextEditingController();

  bool _validateTitle = false;
  bool _validateDescription = false;
  bool _validateStartdate = false;
  bool _validateEnddate = false;

  late var pickedImage = null;
  late var base64String = null;

  final _textTitle = TextEditingController();
  final _textDescription = TextEditingController();
  final _textStartDate = TextEditingController();
  final _textEndDate = TextEditingController();

  DateTime selectedDate = DateTime.now();

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });

  var id;
  var title = "";
  var description = "";
  var image = "";
  var from_date = "";
  var to_date = "";

  _EventUpdateState(
      {Key? key,
      required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.from_date,
      required this.to_date});

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
          title: Text("Update Event"),
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
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20),
                            child: TextField(
                              controller: _textTitle,
                              decoration: InputDecoration(
                                labelText: 'Event Title',
                                hintText: 'Please Enter Your Event Title',
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
                                left: 20.0, right: 20.0, top: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              maxLength: 1000,
                              controller: _textDescription,
                              decoration: InputDecoration(
                                errorText: _validateDescription
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 30,
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 0.0, top: 5, bottom: 20),
                                child: TextField(
                                  controller: _textStartDate,
                                  decoration: InputDecoration(
                                    labelText: 'Event Start Date',
                                    hintText: 'Please Enter Event Start Date',
                                    errorText: _validateStartdate
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white)),
                                  ),

                                  readOnly: true,
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));
                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      setState(() {
                                        var now = new DateTime.now();
                                        var formatter =
                                            new DateFormat('yyyy-MM-dd');
                                        String formattedDate =
                                            formatter.format(pickedDate);
                                        _textStartDate.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                              Container(
                                width:
                                    MediaQuery.of(context).size.width / 2 - 30,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 5,
                                    bottom: 20),
                                child: TextField(
                                  controller: _textEndDate,
                                  decoration: InputDecoration(
                                    errorText: _validateEnddate
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    labelText: 'Event End Date',
                                    hintText: 'Please Enter Event End Date',
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white)),
                                  ),

                                  readOnly: true,
                                  //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));
                                    if (pickedDate != null) {
                                      print(
                                          pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                      setState(() {
                                        var formatter =
                                            new DateFormat('yyyy-MM-dd');
                                        String formattedDate =
                                            formatter.format(pickedDate);
                                        _textEndDate.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      print("Date is not selected");
                                    }
                                  },
                                ),
                              ),
                            ],
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
                                        height: 200,
                                        width: 200,
                                      )
                                    : Image.asset(
                                        'assets/frame.png',
                                        height: 200,
                                        width: 200,
                                      ),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20, bottom: 20),
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
                                      ? _validateDescription = true
                                      : _validateDescription = false;

                                  _textStartDate.text.isEmpty
                                      ? _validateStartdate = true
                                      : _validateStartdate = false;

                                  _textEndDate.text.isEmpty
                                      ? _validateEnddate = true
                                      : _validateEnddate = false;

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
    updateData();
  }

  Future updateApi() async {
    print("Hello  ......");

    EasyLoading.show();

    final queryParameters = {
      'uuid': id.toString(),
      'title': _textTitle.text,
      'description': _textDescription.text,
      'image': base64String,
      'from_date': _textStartDate.text,
      'to_date': _textEndDate.text,
    };
    print(queryParameters);
    final response =
        await http.post(Uri.parse(update_events), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {

        EasyLoading.dismiss();


        Fluttertoast.showToast(
            msg: "Event Updated Successfully",
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

  OpenPicker(ImageSource source) async {
    pickedImage = (await ImagePicker.pickImage(source: source)) as File;
    base64String = base64Encode(pickedImage.readAsBytesSync());
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

  void updateData() async {
    final prefs = await SharedPreferences.getInstance();
    _textTitle.text = title;
    _textDescription.text = description;
    _textStartDate.text = from_date;
    _textEndDate.text = to_date;
    http.Response response = await http.get(
      API_Base_urlWithout + image,
    );
    base64String = base64Encode(response.bodyBytes);
    setState(() {});
  }
}
