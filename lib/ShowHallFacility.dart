import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:learning/BookiStatusDart.dart';
import 'package:learning/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:learning/HallOverView.dart';
import 'package:learning/MenuModal.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppConstant.dart';
import 'dart:io';

class ShowHallFacility extends StatefulWidget {
  @override
  _ShowHallFacilityState createState() => _ShowHallFacilityState();
}

class _ShowHallFacilityState extends State<ShowHallFacility> {
  bool rememberMe = false;
  bool _validate = false;
  final _textQuantity = TextEditingController();
  bool _validateTitle = false;
  bool _validateDescription = false;
  bool _validateStartdate = false;
  bool _validateQuantity = false;

  late var pickedImage = null;

  final _textTitle = TextEditingController();
  final _textDescription = TextEditingController();
  final _textStartDate = TextEditingController();

  DateTime selectedDate = DateTime.now();

  num counts = -1;

  late List<dynamic> list = [];
  List<TextEditingController> _controllersFirst = [];
  List<TextEditingController> _idFirst = [];

  List<TextEditingController> _controllersSecond = [];
  List<TextEditingController> _idSecond = [];

  List<TextEditingController> _controllersThird = [];
  List<TextEditingController> _idThird = [];

  List<TextEditingController> _controllersFourth = [];
  List<TextEditingController> _idFourth = [];

  List<TextEditingController> _controllersFifth = [];
  List<TextEditingController> _idFifth = [];

  List<TextEditingController> _controllersSixth = [];
  List<TextEditingController> _idSixth = [];

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
    counts = 0;
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("Facilities"),
            backgroundColor: Colors.blue,
            actions: <Widget>[],
          ),
          Expanded(
            child: ListView.builder(
                padding: EdgeInsets.only(bottom: 230),
                shrinkWrap: true,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int indexx) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        color: new Color(0xFFEEEEEE),
                        height: 50,
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(left: 5, top: 5, right: 5),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          list[indexx].menu_name,
                          style: TextStyle(fontSize: 20),
                          softWrap: true,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      ListView.builder(
                          padding: EdgeInsets.only(bottom: 0),
                          itemCount: list[indexx].get_sub_menu.length,
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(
                                      left: 20, bottom: 20, top: 10),
                                  child: Text(

                                    list[indexx].get_sub_menu[index]
                                        ["sub_menu_name"],
                                    style: TextStyle(fontSize: 15),
                                    softWrap: true,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                if (indexx == 0) ...{
                                  Visibility(
                                    child: TextFormField(

                                        controller: _idFirst[index]..text =list[indexx].get_sub_menu[index]["id"].toString()!!,
                                        decoration: InputDecoration(),
                                        readOnly: true),
                                    visible: false,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    margin: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 10.0,
                                        top: 10,
                                        bottom: 20),
                                    child: TextField(
                                        controller: _controllersFirst[index],
                                        decoration: InputDecoration(

                                          errorText: _validateQuantity
                                              ? 'Value Can\'t Be Empty'
                                              : null,
                                          labelText: "Quantity",
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          //_showEndDate();
                                        }),
                                  ),
                                },
                                if (indexx == 1) ...{
                                  Visibility(
                                    child: TextFormField(
                                        controller: _idSecond[index]..text =list[indexx].get_sub_menu[index]["id"].toString()!!,
                                        decoration: InputDecoration(),
                                        readOnly: true),
                                    visible: false,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    margin: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 10.0,
                                        top: 10,
                                        bottom: 20),
                                    child: TextField(
                                        controller: _controllersSecond[index],
                                        decoration: InputDecoration(
                                          labelText: "Quantity",
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          //_showEndDate();
                                        }),
                                  ),
                                },
                                if (indexx == 2)...{
                                  Visibility(
                                    child: TextFormField(
                                        controller: _idThird[index]..text =list[indexx].get_sub_menu[index]["id"].toString()!!,
                                        decoration: InputDecoration(),
                                        readOnly: true),
                                    visible: false,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    margin: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 10.0,
                                        top: 10,
                                        bottom: 20),
                                    child: TextField(
                                        controller: _controllersThird[index],
                                        decoration: InputDecoration(
                                          labelText: "Quantity",
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          //_showEndDate();
                                        }),
                                  )},
                                if (indexx == 3)...{
                                  Visibility(
                                    child: TextFormField(
                                        controller: _idFourth[index]..text =list[indexx].get_sub_menu[index]["id"].toString()!!,
                                        decoration: InputDecoration(),
                                        readOnly: true),
                                    visible: false,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    margin: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 10.0,
                                        top: 10,
                                        bottom: 20),
                                    child: TextField(
                                        controller: _controllersFourth[index],
                                        decoration: InputDecoration(
                                          labelText: "Quantity",
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          //_showEndDate();
                                        }),
                                  )},
                                if (indexx == 4)...{
                                  Visibility(
                                    child: TextFormField(
                                        controller: _idFifth[index]..text =list[indexx].get_sub_menu[index]["id"].toString()!!,
                                        decoration: InputDecoration(),
                                        readOnly: true),
                                    visible: false,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    margin: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 10.0,
                                        top: 10,
                                        bottom: 20),
                                    child: TextField(
                                        controller: _controllersFifth[index],
                                        decoration: InputDecoration(
                                          labelText: "Quantity",
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          //_showEndDate();
                                        }),
                                  )},
                                if (indexx == 5)...{
                                  Visibility(
                                    child: TextFormField(
                                        controller: _idFifth[index]..text =list[indexx].get_sub_menu[index]["id"].toString(),
                                        decoration: InputDecoration(),
                                        readOnly: true),
                                    visible: false,
                                  ),
                                  Container(
                                    alignment: Alignment.bottomRight,
                                    height: 40,
                                    width:
                                        MediaQuery.of(context).size.width / 3,
                                    margin: const EdgeInsets.only(
                                        left: 20.0,
                                        right: 10.0,
                                        top: 10,
                                        bottom: 20),
                                    child: TextField(
                                        controller: _controllersSixth[index],
                                        decoration: InputDecoration(
                                          labelText: "Quantity",
                                          border: new OutlineInputBorder(
                                              borderSide: new BorderSide(
                                                  color: Colors.white)),
                                        ),
                                        //set it true, so that user will not able to edit text
                                        onTap: () async {
                                          //_showEndDate();
                                        }),
                                  )},
                              ],
                            );
                          }),
                    ],
                  );
                }),
          ),


          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: MaterialButton(
              height: 50,
              minWidth: 350,
              child: Text(
                "Submit Request",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
              ),
              textColor: Colors.white,
              color: const Color(0xff033F93),
              onPressed: () {
                setState(() {
                  print(_controllersFirst[0].text);
                  openNewDialog(context);
                });

                //fetchPost();
              },
            ),
          ),



        ],
      ),
    );
  }


  void openNewDialog(BuildContext context) {
    //

    // set up the buttons
    Widget cancelButton = TextButton(
        child: Text(
          "Cancel",
          style: new TextStyle(
            fontSize: 15.0,
            color: new Color(0xFF212121),
          ),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        });
    Widget continueButton = TextButton(
      child: Text(
        "Continue",
        style: new TextStyle(
          fontSize: 15.0,
          color: new Color(0xFF212121),
        ),
      ),
      onPressed: () {
        updateApi();
        Navigator.of(context).pop();


      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm"),
      content: Text("Do you really want to continue?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }




  Future updateApi() async {
    EasyLoading.show();
    var queryParameters = [];
    for (var i = 0; i < _controllersFirst.length; i++) {
      var test = {
        '"iteam_id"': '"'+_idFirst[i].text.toString()+'"',
        '"quantity"': '"'+_controllersFirst[i].text.toString()+'"'
      };
      if (!_controllersFirst[i].text.toString().isEmpty) queryParameters.add(test);
    }

    for (var i = 0; i < _controllersSecond.length; i++) {
      var test = {
        '"iteam_id"': '"'+_idSecond[i].text.toString()+'"',
        '"quantity"': '"'+_controllersSecond[i].text.toString()+'"'
      };
      if (!_controllersSecond[i].text.toString().isEmpty) queryParameters.add(test);
    }
    for (var i = 0; i < _controllersThird.length; i++) {
      var test = {
        '"iteam_id"': '"'+_idThird[i].text.toString()+'"',
        '"quantity"': '"'+_controllersThird[i].text.toString()+'"'
      };
      if (!_controllersThird[i].text.toString().isEmpty) queryParameters.add(test);
    }
    for (var i = 0; i < _controllersFourth.length; i++) {
      var test = {
        '"iteam_id"': '"'+_idFourth[i].text.toString()+'"',
        '"quantity"': '"'+_controllersFourth[i].text.toString()+'"'
      };
      if (!_controllersFourth[i].text.toString().isEmpty) queryParameters.add(test);
    }
    print(queryParameters);
    final prefs = await SharedPreferences.getInstance();
    final finalqueryParameters = {
      'booking_room_id': prefs.getString("hall_booking_id").toString(),
      'foods': queryParameters.toString(),
      'customre_id': prefs.getInt("uuid").toString()
    };
    print(finalqueryParameters.toString());
    final response =
        await http.post(Uri.parse(booking_order_details), body: finalqueryParameters);
    print("RESPONCE"+response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        EasyLoading.dismiss();

        print(jsonResponse['result']['order_number']);
        final prefs = await SharedPreferences.getInstance();
        prefs.setString("order_no", jsonResponse['result']['order_number'].toString());

        Fluttertoast.showToast(
            msg: "Request Submitted Successfully!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        Route route = MaterialPageRoute(builder: (context) => BookiStatusDart());
        Navigator.pushReplacement(context, route);

      } else {
        EasyLoading.dismiss();

        Fluttertoast.showToast(
            msg: "Some Error Occured",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(
        //       builder: (context) => MyHomePages(
        //             title: 'Eco App',
        //           )),
        // );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 100; i++) {
      _controllersFirst.add(new TextEditingController());
      _idFirst.add(new TextEditingController());

      _controllersSecond.add(new TextEditingController());
      _idSecond.add(new TextEditingController());

      _controllersThird.add(new TextEditingController());
      _idThird.add(new TextEditingController());

      _controllersFourth.add(new TextEditingController());
      _idFourth.add(new TextEditingController());

      _controllersFifth.add(new TextEditingController());
      _idFifth.add(new TextEditingController());

      _controllersSixth.add(new TextEditingController());
      _idSixth.add(new TextEditingController());
    }
    getAllMenuList();
  }

  Future<void> _showDate() async {
    DatePicker.showDatePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Future<void> _showTime() async {
    DatePicker.showTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
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

  Future getAllMenuList() async {
    final response = await http.get(Uri.parse(facilites_add_menu));
    print(response.body);
    if (response.statusCode == 200) {
      print("Hello");
      final jsonResponse = json.decode(response.body);
      var rest = jsonResponse["result"] as List;
      //print(jsonResponse["result"] as List);
      setState(() {
        list = rest.map<MenuModal>((json) => MenuModal.fromJson(json)).toList();
      });
      print(list[0].get_sub_menu[0]["sub_menu_name"]);
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }



}
