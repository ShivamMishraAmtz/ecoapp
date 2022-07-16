import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:learning/AppConstant.dart';
import 'package:learning/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyUpdate extends StatefulWidget {
  var id;
  var image = "";
  var companyName = "";
  var companyContactNo = "";
  var companyEmail = "";
  var companyRegistrationNo = "";
  var companyType = "";
  var companyLocation = "";
  var companyDescription = "";
  var companyContactNoSecond = "";
  var url = "";



  CompanyUpdate(
      {Key? key,
      required this.id,
      required this.image,
      required this.companyName,
      required this.companyDescription,
      required this.companyEmail,
      required this.companyType,
      required this.companyLocation,
      required this.companyContactNo,
      required this.companyContactNoSecond,
      required this.url})
      : super(key: key);

  @override
  _CompanyUpdateState createState() => _CompanyUpdateState(
    id: id,
    image: image,
    companyName: companyName,
    companyDescription: companyDescription,
    companyEmail: companyEmail,
    companyType: companyType,
    companyLocation: companyLocation,
    companyContactNo: companyContactNo,
    companyContactNoSecond: companyContactNoSecond,
    url: url,
  );
}

class _CompanyUpdateState extends State<CompanyUpdate> {
  bool rememberMe = false;
  bool _validate = false;
  final _text = TextEditingController();
  String user_role = "";

  final _textPassword = TextEditingController();

  void _onRememberMeChanged(bool newValue) => setState(() {
        rememberMe = newValue;

        if (rememberMe) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });

  final _textCompanyName = TextEditingController();
  final _textContactNo = TextEditingController();
  final _textEmail = TextEditingController();
  final _textOtherContactNoNo = TextEditingController();
  final _textCompanyType = TextEditingController();
  final _textHeadofficeLocation = TextEditingController();
  final _textDescription = TextEditingController();
  final _textUrl = TextEditingController();

  bool _validatePassword = false;
  bool _validateEmail = false;
  bool _validateCompanyName = false;
  bool _validateContactNo = false;
  bool _validateOtherContactNo = false;
  bool _validateCompanyType = false;
  bool _validateHeadofficeLocation = false;
  bool _validateDescription = false;
  bool _validateUrl = false;

  var id;
  var image = "";
  var companyName = "";
  var companyContactNo = "";
  var companyEmail = "";
  var companyRegistrationNo = "";
  var companyType = "";
  var companyLocation = "";
  var companyDescription = "";
  var companyContactNoSecond = "";
  var url = "";

  late var base64String = null;
  late var pickedImage = null;

  _CompanyUpdateState(
      {Key? key,
      required this.id,
      required this.image,
      required this.companyName,
      required this.companyDescription,
      required this.companyEmail,
      required this.companyType,
      required this.companyLocation,
      required this.companyContactNo,
      required this.companyContactNoSecond,
      required this.url});

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
          title: Text("Update Company"),
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
                            controller: _textOtherContactNoNo,
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
                              hintText: 'Enter Company Url',
                              border: new OutlineInputBorder(
                                  borderSide:
                                  new BorderSide(color: Colors.white)),
                            ),
                          ),
                        ),

                        if(user_role=="2")
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

                                    _textOtherContactNoNo.text.isEmpty
                                        ? _validateOtherContactNo = true
                                        : _validateOtherContactNo = false;

                                    updateApi();
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MyHomePages(
                                          title: 'Eco App',
                                        )),
                                  );
                                  //fetchPost();
                                },
                              ),
                            )
                        else
                            Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20, bottom: 50),
                          )


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
    getUserRole();
    updateData();
  }

  Future updateApi() async {
    final prefs = await SharedPreferences.getInstance();

    final queryParameters = {
      'uuid': id.toString(),
      'company_name': _textCompanyName.text,
      'mobile_number_first': _textContactNo.text,
      'mobile_number_second': _textOtherContactNoNo.text,
      'email_id': _textEmail.text,
      'company_address': _textHeadofficeLocation.text,
      'description': _textDescription.text,
      'type': _textCompanyType.text,
      'url':_textUrl.text,
      'company_logo': base64String,
    };


    final response =
        await http.post(Uri.parse(company_update), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        Fluttertoast.showToast(
            msg: "Company Updated Successfully",
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

  void updateData() async {
    _textCompanyName.text = companyName;
    _textDescription.text = companyDescription;
    _textContactNo.text = companyContactNo;
    _textOtherContactNoNo.text = companyContactNoSecond;
    _textCompanyType.text = companyType;
    _textHeadofficeLocation.text = companyLocation;
    _textEmail.text = companyEmail;
    _textUrl.text = url;
    http.Response response = await http.get(
      image,
    );
    base64String = base64Encode(response.bodyBytes);
    setState(() {});
  }

  Future getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user_role = prefs.getString('user_role')!;
    });
  }
}
