import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'AppConstant.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:learning/CameraPreview.dart';

class AnnouncementDetail extends StatefulWidget {
  var id;
  var title = "";
  var description = "";
  var image = "";

  AnnouncementDetail(
      {Key? key,
        required this.id,
        required this.title,
        required this.description,
        required this.image})
      : super(key: key);

  @override
  _UpdateAnnouncementState createState() => _UpdateAnnouncementState(
      id: id, title: title, description: description, image: image);
}

class _UpdateAnnouncementState extends State<AnnouncementDetail> {
  bool rememberMe = false;
  late var pickedImage = null;
  late var base64String = null;

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

  var id;
  var title = "";
  var description = "";
  var image = "";

  _UpdateAnnouncementState(
      {Key? key,
        required this.id,
        required this.title,
        required this.description,
        required this.image});

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
          title: Text("Announcement Details"),
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
                              enabled: false,
                              controller: _textTitle,
                              decoration: InputDecoration(
                                labelText: 'Announcement Title',
                                hintText:
                                'Please Enter Your Announcement Title',
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
                              maxLines: 15,
                              enabled: false,
                              maxLength: 1000,
                              controller: _textDescription,
                              decoration: InputDecoration(
                                errorText: _validateDesc
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                labelText: 'Announcement Description',
                                hintText:
                                'Please Enter Your Announcement Description',
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
    final queryParameters = {
      'uuid': id.toString(),
      'title': title,
      'description': description,
      'create_date': '',
      'image': base64String
    };
    print(queryParameters);
    final response =
    await http.post(Uri.parse(update_announcement), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        Fluttertoast.showToast(
            msg: "Announcement Updated Successfully",
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

  @override
  void initState() {
    super.initState();
    updateData();
  }

  void updateData() async {
    final prefs = await SharedPreferences.getInstance();
    _textTitle.text = title;
    _textDescription.text = description;

    http.Response response = await http.get(
      API_Base_urlWithout + image,
    );
    base64String = base64Encode(response.bodyBytes);
    setState(() {});
  }
}
