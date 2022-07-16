import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:learning/BookingDetailModal.dart';
import 'package:learning/Dashboard.dart';
import 'package:http/http.dart' as http;
import 'package:learning/EmployeeDashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppConstant.dart';
import 'dart:io';

class BookiStatusDart extends StatefulWidget {
  @override
  _BookiStatusDartState createState() => _BookiStatusDartState();
}

class _BookiStatusDartState extends State<BookiStatusDart> {
  bool rememberMe = false;

  bool _validateEnddate = false;
  var data = "";

  late var pickedImage = null;

  final _textTitle = TextEditingController();
  final _textDescription = TextEditingController();
  final _textStartDate = TextEditingController();
  final _textEndDate = TextEditingController();
  DateTime selectedDate = DateTime.now();

  late List<dynamic> list = <dynamic>[];

  String employee_name = "";
  String location_name = "";
  String room_name = "";
  String on_date = "";
  String total_amount = "";

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
            title: Text("Booking Details"),
            backgroundColor: Colors.blue,
            actions: <Widget>[],
          ),
          backgroundColor: Colors.white,
          body: Container(

            child: Stack(
              children: [

                Container(
                  margin: EdgeInsets.only(top: 220,bottom: 45),
                  child: ListView.builder(
                      itemCount: list.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            height: 100,
                            child: Card(
                              margin: EdgeInsets.all(15),
                              child: ListTile(
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                 list[index].menu_name+": "+list[index].quantity+" "+list[index].item_name,
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    decorationStyle:
                                                    TextDecorationStyle.wavy,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                              children: [
                                                Flexible(
                                                  child: Text(
                                                    "Price/Item: Rs "+list[index].per_item_price,
                                                    maxLines: 3,
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 12,
                                                      fontWeight: FontWeight.normal,
                                                      decorationStyle:
                                                      TextDecorationStyle.wavy,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                        );
                      }),
                ),

                Container(
                  margin: EdgeInsets.only(left: 20, bottom: 0, top: 20, right: 2),
                  child: Text(
                    "$data",
                    style: TextStyle(fontSize: 14),
                    softWrap: true,
                    textAlign: TextAlign.start,
                  ),
                ),

                Container(
                  alignment: Alignment.bottomCenter,
                  margin: EdgeInsets.only(left: 0, bottom: 2, top: 400),
                  child: MaterialButton(
                    height: 50,
                    minWidth: 400,
                    child: Text(
                      "OK",
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


                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyDashboardHomePages(
                                title: '',
                              )),
                        );


                      });
                      //fetchPost();
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void initState() {
    super.initState();
    getDataApi();
  }

  Future updateData() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString("audio_video_support") == "1") {
      data = "Your Booking is confirmed for " +
          on_date +
          "\nWith Audio Video Support. \n\nyour booking details are given below\n\nBuilding Name: " +
          location_name +
          "\nHall Name: " +
          room_name +
          "\nEmployee Name: " +
          employee_name +
          "\nTotal Amount: Rs" +
          total_amount;
    } else {
      data = "Your Booking is confirmed for " +
          on_date +
          "\n\nyour booking details are given below\n\nBuilding Name: " +
          location_name +
          "\nHall Name: " +
          room_name +
          "\nEmployee Name: " +
          employee_name +
          "\nTotal Amount: Rs" +
          total_amount;
    }
    setState(() {});
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

  Future getDataApi() async {
    EasyLoading.show();
    final prefs = await SharedPreferences.getInstance();
    String order_no = prefs.getString("order_no").toString();
    final queryParameters = {
      'order_number': order_no,
    };
    print(queryParameters);
    final response = await http.post(Uri.parse(room_and_food_details),
        body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        EasyLoading.dismiss();
        employee_name = jsonResponse['result']['employee_name'].toString();
        location_name = jsonResponse['result']['location_name'].toString();
        room_name = jsonResponse['result']['room_name'].toString();
        on_date = jsonResponse['result']['on_date'].toString();
        total_amount = jsonResponse['result']['total_amount'].toString();
        var rest = jsonResponse["result"]["food_details"] as List;
        list = rest
            .map<BookingDetailModal>(
                (json) => BookingDetailModal.fromJson(json))
            .toList();

        updateData();

        setState(() {});

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
}
