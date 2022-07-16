import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:learning/BookiStatusDart.dart';
import 'package:learning/BuildingModal.dart';
import 'package:learning/ConferenceEventModal.dart';
import 'package:learning/EmployeeDashboard.dart';
import 'package:learning/HallModal.dart';
import 'package:learning/HallOverView.dart';
import 'package:learning/ShowHallFacility.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AppConstant.dart';

class HallBookingForm extends StatefulWidget {
  @override
  _HallBookingFormState createState() => _HallBookingFormState();
}

class _HallBookingFormState extends State<HallBookingForm> {
  bool withAudioVideo = true;
  bool withFood = true;
  bool _validate = false;
  final _text = TextEditingController();
  bool _validateNoOfPeople = false;
  bool _validateSubject = false;
  bool _validateDescription = false;
  bool _validateStartdate = false;
  bool _validateEnddate = false;
  bool _validateStartTime = false;
  bool _validateEndTime = false;
  late var pickedImage = null;
  final _textNoOfPeople = TextEditingController();
  final _textSubject = TextEditingController();
  final _textDescription = TextEditingController();
  final _textStartDate = TextEditingController();
  final _textEndDate = TextEditingController();
  final _textStartTime = TextEditingController();
  final _textEndTime = TextEditingController();
  DateTime selectedDate = DateTime.now();
  late List<dynamic> list = [];
  String _myBuildingSelection = "";
  String _myDeHallSelection = "";
  String _mySlotSelection = "";
  String _myEventTypeSelection = "";
  late List<dynamic> roomlist = [];
  late List<dynamic> EventList = [];
  late List<dynamic> slotlis = ["First Half", "Second Half", "Full Day"];
  late final GlobalKey<FormFieldState> _key = new GlobalKey<FormFieldState>();

  void _onWithAudioVideoChanged(bool newValue) => setState(() {
        withAudioVideo = newValue;
        if (withAudioVideo) {
          // TODO: Here goes your functionality that remembers the user.
        } else {
          // TODO: Forget the user
        }
      });

  void _onWithFoodChanged(bool newValue) => setState(() {
        withFood = newValue;
        if (withFood) {
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
          title: Text("Book Hall"),
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
                                      isExpanded: true,
                                      decoration: InputDecoration.collapsed(
                                          hintText: ''),
                                      isDense: true,
                                      hint: new Text(
                                        "Select Building",
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          color: new Color(0xFF212121),
                                        ),
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          print("vbhjn" + newValue.toString());

                                          setState(() {
                                            _myBuildingSelection = newValue!;
                                            _textNoOfPeople.text = "";
                                            _myDeHallSelection = "";
                                            roomlist.clear();
                                            _key.currentState!.reset();
                                            _textNoOfPeople.text = "";
                                          });

                                          RoomList();
                                        });
                                      },
                                      items: list.map((item) {
                                        return new DropdownMenuItem<String>(
                                          child: Text(
                                            item.location_name,
                                            overflow: TextOverflow.clip,
                                            style: new TextStyle(
                                              fontSize: 13.0,
                                              color: new Color(0xFF212121),
                                            ),
                                          ),
                                          value: item.id.toString(),
                                        );
                                      }).toList()),
                                ],
                              )),
                          Row(
                            children: [
                              Container(
                                  width: 251.0,
                                  height: 60,
                                  margin: const EdgeInsets.only(
                                      left: 20.0, right: 0.0, top: 10),
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueAccent)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //Center Column contents vertically,
                                    children: <Widget>[
                                      DropdownButtonFormField<String>(
                                          key: _key,
                                          decoration: InputDecoration.collapsed(
                                              hintText: ''),
                                          isDense: true,
                                          hint: new Text(
                                            "Select Hall",
                                            style: new TextStyle(
                                              fontSize: 13.0,
                                              color: new Color(0xFF212121),
                                            ),
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              print("halll is" + newValue!);
                                              UpdateCapacity(newValue);
                                              _myDeHallSelection = newValue!;
                                            });
                                          },
                                          items: roomlist.map((item) {
                                            return new DropdownMenuItem<String>(
                                              child: Text(
                                                item.room_name,
                                                overflow: TextOverflow.clip,
                                                style: new TextStyle(
                                                  fontSize: 13.0,
                                                  color: new Color(0xFF212121),
                                                ),
                                              ),
                                              value: item.id.toString(),
                                            );
                                          }).toList()),
                                    ],
                                  )),
                              Container(
                                width: 58,
                                margin: const EdgeInsets.only(
                                    left: 10.0, right: 0.0, top: 10),
                                child: TextField(
                                  style: new TextStyle(
                                    fontSize: 13.0,
                                    color: new Color(0xFF212121),
                                  ),
                                  enabled: false,
                                  controller: _textNoOfPeople,
                                  decoration: InputDecoration(
                                    labelText: 'No Of People',
                                    hintText: 'Please Enter Your Event Title',
                                    errorText: _validateNoOfPeople
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                width: 150.0,
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 0.0, top: 10),
                                child: TextField(
                                  style: new TextStyle(
                                    fontSize: 13.0,
                                    color: new Color(0xFF212121),
                                  ),
                                  controller: _textStartDate,
                                  decoration: InputDecoration(
                                    labelText: 'Event Date',
                                    hintText: 'Please Select Event Date',
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
                                    _showStartDate();
                                  },
                                ),
                              ),
                              Container(
                                  width: 158.0,
                                  height: 60,
                                  margin: const EdgeInsets.only(
                                      left: 10.0, right: 0.0, top: 10),
                                  padding: const EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.blueAccent)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //Center Column contents vertically,
                                    children: <Widget>[
                                      DropdownButtonFormField<String>(
                                          decoration: InputDecoration.collapsed(
                                              hintText: ''),
                                          isDense: true,
                                          hint: new Text(
                                            "Time Slots",
                                            style: new TextStyle(
                                              fontSize: 13.0,
                                              color: new Color(0xFF212121),
                                            ),
                                          ),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _mySlotSelection = newValue!;
                                            });
                                          },
                                          items: slotlis.map((item) {
                                            return new DropdownMenuItem<String>(
                                              child: Text(item),
                                              value: item,
                                            );
                                          }).toList()),
                                    ],
                                  )),
                            ],
                          ),
                          Visibility(
                            visible: false,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  margin: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 15,
                                      bottom: 20),
                                  child: TextField(
                                      style: new TextStyle(
                                        fontSize: 13.0,
                                        color: new Color(0xFF212121),
                                      ),
                                      controller: _textEndDate,
                                      decoration: InputDecoration(
                                        errorText: _validateEnddate
                                            ? 'Value Can\'t Be Empty'
                                            : null,
                                        labelText: 'End Date',
                                        hintText: 'Please Enter End Date',
                                        border: new OutlineInputBorder(
                                            borderSide: new BorderSide(
                                                color: Colors.white)),
                                      ),
                                      readOnly: true,
                                      //set it true, so that user will not able to edit text
                                      onTap: () async {
                                        _showEndDate();
                                      }),
                                ),
                              ],
                            ),
                          ),
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
                                      decoration: InputDecoration.collapsed(
                                          hintText: ''),
                                      isDense: true,
                                      hint: new Text(
                                        "Event Type",
                                        style: new TextStyle(
                                          fontSize: 13.0,
                                          color: new Color(0xFF212121),
                                        ),
                                      ),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          _myEventTypeSelection = newValue!;
                                        });
                                      },
                                      items: EventList.map((item) {
                                        return new DropdownMenuItem<String>(
                                          child: Text(item.event_name),
                                          value: item.id.toString(),
                                        );
                                      }).toList()),
                                ],
                              )),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 10),
                            child: TextFormField(
                              style: new TextStyle(
                                fontSize: 13.0,
                                color: new Color(0xFF212121),
                              ),
                              keyboardType: TextInputType.multiline,
                              maxLines: 5,
                              maxLength: 1000,
                              controller: _textDescription,
                              decoration: InputDecoration(
                                errorText: _validateDescription
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                labelText: 'Event Description',
                                hintText: 'Please Enter Your Description',
                                border: new OutlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 5),
                                      Checkbox(
                                        value: withAudioVideo,
                                        onChanged: (bool? value) {
                                          _onWithAudioVideoChanged(value!);
                                        },
                                      ),
                                      Text("With Audio Video"),
                                    ],
                                  ),
                                ]),
                          ),
                          Container(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: <Widget>[
                                      SizedBox(width: 5),
                                      Checkbox(
                                        value: withFood,
                                        onChanged: (bool? value) {
                                          _onWithFoodChanged(value!);
                                        },
                                      ),
                                      Text("Need Food And Other Facilities?"),
                                    ],
                                  ),
                                ]),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 5, bottom: 20),
                            child: MaterialButton(
                              height: 50,
                              minWidth: 350,
                              child: Text("Submit Request"),
                              textColor: Colors.white,
                              color: const Color(0xff033F93),
                              onPressed: () {
                                setState(() {
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>ShowHallFacility()),
                                  // );

                                  if (_myBuildingSelection == "") {
                                    Fluttertoast.showToast(
                                        msg: "Please Select Building",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1);
                                  } else if (_myDeHallSelection == "") {
                                    Fluttertoast.showToast(
                                        msg: "Please Select Hall",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1);
                                  } else if (_mySlotSelection == "") {
                                    Fluttertoast.showToast(
                                        msg: "Please Select Slots",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1);
                                  } else if (_myEventTypeSelection == "") {
                                    Fluttertoast.showToast(
                                        msg: "Please Select Event Type",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1);
                                  } else if (_textStartDate.text.toString() ==
                                      "") {
                                    Fluttertoast.showToast(
                                        msg: "Please Select Event Date",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1);
                                  } else if (_textDescription.text.toString() ==
                                      "") {
                                    FocusScope.of(context).unfocus();

                                    Fluttertoast.showToast(
                                        msg: "Please Enter Description",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1);
                                  } else {
                                    if (withFood) {
                                      updateApi();
                                    } else {
                                      openNewDialog(context);
                                    }

                                  }

                                  // _textTitle.text.isEmpty
                                  //     ? _validateTitle = true
                                  //     : _validateTitle = false;
                                  //
                                  // _textDescription.text.isEmpty
                                  //     ? _validateDescription = true
                                  //     : _validateDescription = false;
                                  //
                                  // _textStartDate.text.isEmpty
                                  //     ? _validateStartdate = true
                                  //     : _validateStartdate = false;
                                  //
                                  // _textEndDate.text.isEmpty
                                  //     ? _validateEnddate = true
                                  //     : _validateEnddate = false;
                                  // updateApi();
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
    BuildingList();
    EventType();
  }

  Future<void> _showStartDate() async {
    DatePicker.showDatePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      var dates = DateTime.parse(date.toString());
      var formattedDate = "${dates.year}-${dates.month}-${dates.day}";
      _textStartDate.text = formattedDate.toString();
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Future<void> _showEndDate() async {
    DatePicker.showDatePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      var dates = DateTime.parse(date.toString());
      var formattedDate = "${dates.year}-${dates.month}-${dates.day}";
      _textEndDate.text = formattedDate.toString();
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Future<void> _showStartTime() async {
    DatePicker.showTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      var dates = DateTime.parse(date.toString());
      var formattedDate = "${dates.hour}:${dates.minute}:${dates.second}";
      _textStartTime.text = formattedDate.toString();
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Future<void> _showEndTime() async {
    DatePicker.showTimePicker(context, showTitleActions: true,
        onChanged: (date) {
      print('change $date');
    }, onConfirm: (date) {
      var dates = DateTime.parse(date.toString());
      var formattedDate = "${dates.hour}:${dates.minute}:${dates.second}";
      _textEndTime.text = formattedDate.toString();
      print('confirm $date');
    }, currentTime: DateTime.now(), locale: LocaleType.en);
  }

  Future updateApi() async {
    var av = "0";
    var ff = "0";

    if (withAudioVideo) {
      av = "1";
    }

    if (withFood) {
      ff = "1";
    }

    final prefs = await SharedPreferences.getInstance();
    prefs.setString("from_date_one", _textStartDate.text.toString());
    prefs.setString("audio_video_support", av);
    prefs.setString("food_support", ff);

    EasyLoading.show();
    final queryParameters = {
      'event_id': _myEventTypeSelection,
      'location_id': _myBuildingSelection,
      'room_id': _myDeHallSelection,
      'requested_employee': prefs.getInt("uuid").toString(),
      'from_date_one': _textStartDate.text.toString(),
      'to_date_one': _textStartDate.text.toString(),
      'slot_choice': _mySlotSelection,
      'audio_video_support': av,
      'food_facilites_list': ff,
    };

    print(queryParameters);
    final response =
        await http.post(Uri.parse(room_booking), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        print(jsonResponse['result']['id'].toString());
        prefs.setString(
            'hall_booking_id', jsonResponse['result']['id'].toString());

        EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: "Request Submitted Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        if (withFood) {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => ShowHallFacility()),
          // );
          Route route = MaterialPageRoute(builder: (context) => ShowHallFacility());
          Navigator.pushReplacement(context, route);
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => MyDashboardHomePages(
                  title: 'Eco App',
                )),
          );
        }
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: "This Slot is Already Booked!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
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

  Future BuildingList() async {
    final response = await http.get(Uri.parse(location_list));
    print(response.body);
    if (response.statusCode == 200) {
      print("Hello");
      final jsonResponse = json.decode(response.body);
      var rest = jsonResponse["result"] as List;
      //print(jsonResponse["result"] as List);
      setState(() {
        list = rest
            .map<BuildingModal>((json) => BuildingModal.fromJson(json))
            .toList();
      });
      print(list);
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }

  Future RoomList() async {
    print("_myBuildingSelection" + _myBuildingSelection);

    final queryParameters = {
      'location_name': _myBuildingSelection,
    };
    final response =
        await http.post(Uri.parse(room_list), body: queryParameters);
    print("Room Name List" + response.body);
    if (response.statusCode == 200) {
      print("Hello Department");
      final jsonResponse = json.decode(response.body);
      try {
        var rest = jsonResponse["result"] as List;

        print(jsonResponse["result"] as List);
        setState(() {
          roomlist =
              rest.map<HallModal>((json) => HallModal.fromJson(json)).toList();
        });

        ///print(departmentlist);
      } catch (err) {
        setState(() {
          roomlist.clear();
        });
        print(err.toString());
      }
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }

  Future EventType() async {
    final response = await http.get(Uri.parse(boocked_room_events));
    print("Event List" + response.body);
    if (response.statusCode == 200) {
      print("Hello Event");
      final jsonResponse = json.decode(response.body);
      try {
        var rest = jsonResponse["result"] as List;
        print(jsonResponse["result"] as List);
        setState(() {
          EventList = rest
              .map<ConferenceEventModal>(
                  (json) => ConferenceEventModal.fromJson(json))
              .toList();
        });
      } catch (err) {
        setState(() {
          EventList.clear();
        });
        print(err.toString());
      }
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }

  Future UpdateCapacity(String room_id) async {
    for (var i = 0; i < roomlist.length; i++) {
      print(roomlist[i].id.toString() + "  Equal " + room_id);
      print("Room name  " + roomlist[i].room_capacity.toString());
      if (roomlist[i].id.toString() == room_id.toString()) {
        _textNoOfPeople.text = roomlist[i].room_capacity.toString();
        break;
      }
    }
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
        Navigator.of(context).pop();
        updateApi();
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
}
