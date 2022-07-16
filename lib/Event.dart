import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/AppConstant.dart';
import 'package:learning/CommanWebView.dart';
import 'package:learning/EventAdd.dart';
import 'package:learning/EventDataModal.dart';
import 'package:learning/EventDetail.dart';
import 'package:http/http.dart' as http;
import 'package:learning/EventUpdate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'AnnouncementDataModal.dart';

class Event extends StatefulWidget {
  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  late List<dynamic> list = <dynamic>[];
  String user_role = "";

  @override
  Widget build(BuildContext context) {
    if (user_role == "2")
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("Events"),
            backgroundColor: Colors.blue,
            actions: <Widget>[],
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print(list[index]);
                      if (user_role == "2") {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EventUpdate(
                            id: list[index].id,
                            title: list[index].title,
                            description: list[index].description,
                            image: list[index].image,
                            from_date: list[index].from_date,
                            to_date: list[index].to_date,
                          ),
                        ));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EventDetail(
                            id: list[index].id,
                            title: list[index].title,
                            description: list[index].description,
                            image: list[index].image,
                            from_date: list[index].from_date,
                            to_date: list[index].to_date,
                          ),
                        ));
                      }
                    },
                    child: Container(
                      height: 180,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                            leading: Container(
                                width: 50,
                                child: Image.network(
                                    API_Base_urlWithout + list[index].image)),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            list[index].title,
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
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                list[index].description,
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
                                            if (list[index].status == "1" &&
                                                user_role == "2")
                                              Container(
                                                height: 28,
                                                width: 65,
                                                child: FlatButton(
                                                  child: Text(
                                                    "Active",
                                                    style: TextStyle(
                                                        fontSize: 10.0),
                                                  ),
                                                  color: Colors.green,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    updateStatusApi(
                                                        list[index]
                                                            .id
                                                            .toString(),
                                                        "2");
                                                  },
                                                ),
                                              ),
                                            if (list[index].status == "2" &&
                                                user_role == "2")
                                              Container(
                                                height: 28,
                                                width: 75,
                                                child: FlatButton(
                                                  child: Text(
                                                    "In-Active",
                                                    style: TextStyle(
                                                        fontSize: 10.0),
                                                  ),
                                                  color: Colors.redAccent,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    updateStatusApi(
                                                        list[index]
                                                            .id
                                                            .toString(),
                                                        "1");
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "From Date: " +
                                                  list[index].from_date,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                decorationStyle:
                                                    TextDecorationStyle.wavy,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "To Date: " + list[index].to_date,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        )
                                      ],
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
          floatingActionButton: Container(
            child: Align(
                alignment: Alignment.bottomRight,
                child: FloatingActionButton(
                    elevation: 0.0,
                    child: new Icon(Icons.add),
                    backgroundColor: new Color(0xFFE57373),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EventAdd()),
                      );
                    })),
          ),
        ),
      );
    else
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("Events"),
            backgroundColor: Colors.blue,
            actions: <Widget>[],
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      print(list[index]);
                      if (user_role == "2") {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EventUpdate(
                            id: list[index].id,
                            title: list[index].title,
                            description: list[index].description,
                            image: list[index].image,
                            from_date: list[index].from_date,
                            to_date: list[index].to_date,
                          ),
                        ));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EventDetail(
                            id: list[index].id,
                            title: list[index].title,
                            description: list[index].description,
                            image: list[index].image,
                            from_date: list[index].from_date,
                            to_date: list[index].to_date,
                          ),
                        ));
                      }
                    },
                    child: Container(
                      height: 140,
                      child: Card(
                        margin: EdgeInsets.all(10),
                        child: ListTile(
                            leading: Container(
                                width: 50,
                                child: Image.network(
                                    API_Base_urlWithout + list[index].image)),
                            title: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            list[index].title,
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
                                      margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                      child: Container(
                                        margin: EdgeInsets.only(top: 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Flexible(
                                              child: Text(
                                                list[index].description,
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
                                            if (list[index].status == "1" &&
                                                user_role == "2")
                                              Container(
                                                height: 28,
                                                width: 65,
                                                child: FlatButton(
                                                  child: Text(
                                                    "Active",
                                                    style: TextStyle(
                                                        fontSize: 10.0),
                                                  ),
                                                  color: Colors.green,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    updateStatusApi(
                                                        list[index]
                                                            .id
                                                            .toString(),
                                                        "2");
                                                  },
                                                ),
                                              ),
                                            if (list[index].status == "2" &&
                                                user_role == "2")
                                              Container(
                                                height: 28,
                                                width: 75,
                                                child: FlatButton(
                                                  child: Text(
                                                    "In-Active",
                                                    style: TextStyle(
                                                        fontSize: 10.0),
                                                  ),
                                                  color: Colors.redAccent,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    updateStatusApi(
                                                        list[index]
                                                            .id
                                                            .toString(),
                                                        "1");
                                                  },
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              "From Date: " +
                                                  list[index].from_date,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                decorationStyle:
                                                    TextDecorationStyle.wavy,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "To Date: " + list[index].to_date,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        )
                                      ],
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
        ),
      );
  }

  @override
  void initState() {
    super.initState();
    getUserRole();
    eventList();
  }

  Future eventList() async {
    EasyLoading.show();
    final response = await http.get(Uri.parse(events_list));
    print(response.body);
    setState(() {});
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final jsonResponse = json.decode(response.body);

      try {
        var rest = jsonResponse["result"] as List;
        list = rest
            .map<EventDataModal>((json) => EventDataModal.fromJson(json))
            .toList();
      } on Exception catch (_) {

    }
      setState(() {});
    } else {
      EasyLoading.dismiss();
      setState(() {});
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }

  Future updateStatusApi(String uuid, String status) async {
    final queryParameters = {
      'uuid': uuid.toString(),
      'status': status.toString()
    };
    print(queryParameters);
    final response =
        await http.post(Uri.parse(status_event), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        Fluttertoast.showToast(
            msg: "Status Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
        eventList();
      } else {
        Fluttertoast.showToast(
            msg: "Some Error Occured",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      }
    }
  }

  Future getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    user_role = prefs.getString('user_role')!;
    print(user_role);

  }
}
