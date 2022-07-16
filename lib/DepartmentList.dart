import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:learning/AnnouncementDataModal.dart';
import 'package:learning/AnnouncementDetail.dart';
import 'package:learning/AnouncementAdd.dart';
import 'package:learning/AppConstant.dart';
import 'package:learning/DepartmentAdd.dart';
import 'package:learning/DepartmentDataModal.dart';
import 'package:learning/UpdateAnnouncement.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepartmentList extends StatefulWidget {
  @override
  _DepartmentListState createState() => _DepartmentListState();
}

class _DepartmentListState extends State<DepartmentList> {
  late List<Widget> children = <Widget>[];

  late List<dynamic> list = <dynamic>[];

  final _textStatus = TextEditingController();

  String user_role = "";

  @override
  Widget build(BuildContext context) {
    if(user_role=="1")
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("Department List"),
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

                      },
                      child: Container(
                        height: 120,
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
                                              list[index].department_name,
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
                                                list[index].company_name,
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
            title: Text("Department List"),
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
                      },
                      child: Container(
                        height: 80,
                        child: Card(
                          margin: EdgeInsets.all(10),
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
                                              "Department Name: "+list[index].department_name,
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
                                                "Company Name: "+list[index].company_name,
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
                            builder: (context) => DepartmentAdd()),
                      );
                    })),
          ),

        ),
      );

  }

  @override
  void initState() {
    super.initState();
    getUserRole();
    departmentList();
  }

  Future getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    user_role = prefs.getString('user_role')!;
  }

  Future departmentList() async {
    EasyLoading.show();
    final response = await http.get(Uri.parse(department_get_list));
    print(response.body);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final jsonResponse = json.decode(response.body);
      var rest = jsonResponse["result"] as List;
      list = rest
          .map<DepartmentDataModal>(
              (json) => DepartmentDataModal.fromJson(json))
          .toList();
      setState(() {});
    } else {
      EasyLoading.dismiss();
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
        departmentList();
      } else {
        Fluttertoast.showToast(
            msg: "Some Error Occured",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      }
    }
  }
}
