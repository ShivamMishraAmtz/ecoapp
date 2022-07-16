import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:learning/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'AppConstant.dart';
import 'dart:io';

class HallOverView extends StatefulWidget {
  @override
  _HallOverViewState createState() => _HallOverViewState();
}

class _HallOverViewState extends State<HallOverView> {
  bool rememberMe = false;
  bool _validate = false;
  final _text = TextEditingController();

  bool _validateTitle = false;
  bool _validateDescription = false;
  bool _validateStartdate = false;
  bool _validateEnddate = false;

  late var pickedImage = null;

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
          title: Text("Request Details"),
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
                            color: new Color(0xFFEEEEEE),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                            padding: EdgeInsets.all(10),
                            child: Text("Total Price: 100Rs",
                              style: TextStyle(fontSize: 20),
                              softWrap: true,
                              textAlign: TextAlign.left,
                            ),
                          ),

                          Container(
                            color: new Color(0xFFEEEEEE),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                            padding: EdgeInsets.all(10),
                            child:

                            Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("Building Name",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),


                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("KCC",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("Room Name",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),


                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("Omega",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("Start Date",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),


                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("02May2022",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("End Date",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),


                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("03May2022",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("Event Type",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),


                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("Seminar",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("Description",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),


                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("Seminar",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("People Capacity",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),


                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(left: 0,bottom: 20),
                                      child: Text("250",
                                        style: TextStyle(fontSize: 20),
                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),

                                  ],
                                ),
                              ],
                            )
                          ),

                          Container(
                            color: new Color(0xFFEEEEEE),
                            height: 50,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                            padding: EdgeInsets.all(10),
                            child: Text("Breakfasts",
                              style: TextStyle(fontSize: 20),
                              softWrap: true,
                              textAlign: TextAlign.left,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20,top: 10),
                                child: Text("Tea",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 10,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: "200",
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),
                                    readOnly: true,
                                    enabled: false,
                                  //set it true, so that user will not able to edit text
                                   ),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20),
                                child: Text("Biscuit",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: "200",
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),
                                    readOnly: true,
                                    enabled: false,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {

                                      //_showEndDate();

                                    }),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20),
                                child: Text("Samosa",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: "200",
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),

                                    readOnly: true,
                                    enabled: false,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {

                                      //_showEndDate();

                                    }),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20),
                                child: Text("Idli Sambhar",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: "200",
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),

                                    readOnly: true,
                                    enabled: false,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {

                                      //_showEndDate();

                                    }),
                              ),
                            ],
                          ),

                          Container(
                            color: new Color(0xFFEEEEEE),
                            height: 50,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                            padding: EdgeInsets.all(10),
                            child: Text("Lunch",
                              style: TextStyle(fontSize: 20),
                              softWrap: true,
                              textAlign: TextAlign.left,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20,top: 10),
                                child: Text("Lunch Plate",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 10,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: "200",
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),

                                    readOnly: true,
                                    enabled: false,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {

                                      //_showEndDate();

                                    }),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20),
                                child: Text("Ice Cream",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: '200',
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),

                                    readOnly: true,
                                    enabled: false,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {

                                      //_showEndDate();

                                    }),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20),
                                child: Text("Sweets",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: '200',
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),

                                    readOnly: true,
                                    enabled: false,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {

                                      //_showEndDate();

                                    }),
                              ),
                            ],
                          ),

                          Container(
                            color: new Color(0xFFEEEEEE),
                            height: 50,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(left: 5,top: 5,right: 5),
                            padding: EdgeInsets.all(10),
                            child: Text("Snacks",
                              style: TextStyle(fontSize: 20),
                              softWrap: true,
                              textAlign: TextAlign.left,
                            ),
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20,top: 10),
                                child: Text("Tea",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 10,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: '200',
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),

                                    readOnly: true,
                                    enabled: false,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {

                                      //_showEndDate();

                                    }),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20),
                                child: Text("Biscuit",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: '200',
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),

                                    readOnly: true,
                                    enabled: false,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {

                                      //_showEndDate();

                                    }),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20),
                                child: Text("Samosa",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: '200',
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),
                                    readOnly: true,
                                    enabled: false,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {

                                      //_showEndDate();

                                    }),
                              ),
                            ],
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(left: 20,bottom: 20),
                                child: Text("Idli Sambhar",
                                  style: TextStyle(fontSize: 20),
                                  softWrap: true,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                alignment: Alignment.bottomRight,
                                height: 40,
                                width:
                                MediaQuery.of(context).size.width/3,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 0,
                                    bottom: 20),
                                child: TextField(
                                    controller: _textEndDate,
                                    decoration: InputDecoration(
                                      errorText: _validateEnddate
                                          ? 'Value Can\'t Be Empty'
                                          : null,
                                      labelText: '200',
                                      border: new OutlineInputBorder(
                                          borderSide: new BorderSide(
                                              color: Colors.white)),
                                    ),
                                    readOnly: true,
                                    enabled: false,
                                    //set it true, so that user will not able to edit text
                                    onTap: () async {

                                      //_showEndDate();

                                    }),
                              ),
                            ],
                          ),

                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20, bottom: 20),
                            child: MaterialButton(
                              height: 50,
                              minWidth: 350,
                              child: Text("Confirm Request"),
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

  }




  Future<void> _showDate() async {
    DatePicker.showDatePicker(context,
        showTitleActions: true,
        onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          print('confirm $date');
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }



  Future<void> _showTime() async {
    DatePicker.showTimePicker(context,
        showTitleActions: true,
        onChanged: (date) {
          print('change $date');
        }, onConfirm: (date) {
          print('confirm $date');
        }, currentTime: DateTime.now(), locale: LocaleType.en);
  }


  Future updateApi() async {
    EasyLoading.show();
    final queryParameters = {
      'title': _textTitle.text,
      'description': _textDescription.text,
      'image': base64Encode(pickedImage.readAsBytesSync()),
      'from_date': _textStartDate.text,
      'to_date': _textEndDate.text,
    };
    print(queryParameters);
    final response =
    await http.post(Uri.parse(add_events), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: "Event Added Successfully",
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
