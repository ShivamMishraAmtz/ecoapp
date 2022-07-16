import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'AppConstant.dart';
import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:learning/CameraPreview.dart';

class AnnouncementAdd extends StatefulWidget {
  @override
  _AnnouncementAddState createState() => _AnnouncementAddState();
}

class _AnnouncementAddState extends State<AnnouncementAdd> {
  bool rememberMe = false;
  late var pickedImage = null;

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
          title: Text("Add New Announcement"),
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
                              maxLines: 6,
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
    final queryParameters = {
      'title': title,
      'description': description,
      'create_date':'',
      'image': base64Encode(pickedImage.readAsBytesSync())
    };

    print(queryParameters);

    final response =
    await http.post(Uri.parse(add_announcment), body: queryParameters);

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

        EasyLoading.dismiss();


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

        EasyLoading.dismiss();


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
        builder: (context) =>
            AlertDialog(
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
  }
}
