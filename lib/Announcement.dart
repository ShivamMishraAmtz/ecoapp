import 'dart:async';
import 'dart:convert';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:learning/AnnouncementDataModal.dart';
import 'package:learning/AnnouncementDetail.dart';
import 'package:learning/AnouncementAdd.dart';
import 'package:learning/AppConstant.dart';
import 'package:learning/UpdateAnnouncement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Announcement extends StatefulWidget {
  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  late List<Widget> children = <Widget>[];

  String user_role = "";


  late List<dynamic> list = <dynamic>[];

  final _textStatus = TextEditingController();


  @override
  Widget build(BuildContext context) {
    if (user_role == "1")
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("Announcement List"),
            backgroundColor: Colors.blue,
            actions: <Widget>[],
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (user_role == "2")
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => UpdateAnnouncement(
                              id: list[index].id,
                              title: list[index].title,
                              description: list[index].description,
                              image: list[index].image,
                            ),
                          ));
                        else
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AnnouncementDetail(
                              id: list[index].id,
                              title: list[index].title,
                              description: list[index].description,
                              image: list[index].image,
                            ),
                          ));
                      },
                      child: Container(
                        height: 120,
                        child: Card(
                          margin: EdgeInsets.all(15),
                          child: ListTile(
                              leading: Container(
                                  width: 40,
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Image.network(
                                      API_Base_urlWithout + list[index].image)),
                              title: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              list[index].title,
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
                                                height: 25,
                                                width: 70,
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
        ),
      );
    else {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("Announcement"),
            backgroundColor: Colors.blue,
            actions: <Widget>[],
          ),
          backgroundColor: Colors.white,
          body: Center(
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        if (user_role == "2")
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                UpdateAnnouncement(
                                  id: list[index].id,
                                  title: list[index].title,
                                  description: list[index].description,
                                  image: list[index].image,
                                ),
                          ));
                        else
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) =>
                                AnnouncementDetail(
                                  id: list[index].id,
                                  title: list[index].title,
                                  description: list[index].description,
                                  image: list[index].image,
                                ),
                          ));
                      },
                      child: Container(
                        height: 120,
                        child: Card(
                          margin: EdgeInsets.all(10),
                          child: ListTile(
                              leading: Container(
                                  width: 40,
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Image.network(
                                      API_Base_urlWithout + list[index].image)),
                              title: Column(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                            child: Text(
                                              list[index].title,
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
                                                height: 25,
                                                width: 70,
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
                        MaterialPageRoute(
                            builder: (context) => AnnouncementAdd()),
                      );
                    })),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();

    BackButtonInterceptor.add(myInterceptor);

    getUserRole();
    announcementList();
  }

  Future getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user_role = prefs.getString('user_role')!;
    });
  }

  Future announcementList() async {
    EasyLoading.show();

    final response = await http.get(Uri.parse(announcement_list));
    print(response.body);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final jsonResponse = json.decode(response.body);
      var rest = jsonResponse["result"] as List;
      list = rest
          .map<AnnouncementDataModal>(
              (json) => AnnouncementDataModal.fromJson(json))
          .toList();

      setState(() {});
    } else {
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
        await http.post(Uri.parse(status_announcement), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        Fluttertoast.showToast(
            msg: "Status Added Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
        announcementList();
      } else {
        Fluttertoast.showToast(
            msg: "Some Error Occured",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      }
    }
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    print("BACK BUTTON!"); // Do some stuff.
    EasyLoading.dismiss();
    Navigator.of(context).pop();
    return true;
  }
}
