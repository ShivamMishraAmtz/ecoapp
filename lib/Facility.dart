import 'package:flutter/material.dart';
import 'package:learning/EmployeeModal.dart';
import 'package:learning/FacilityAdd.dart';
import 'package:learning/FacilityModal.dart';
import 'package:learning/FacilityUpdate.dart';
import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'FacilityDetail.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/AppConstant.dart';

class Facility extends StatefulWidget {
  @override
  _FacilityState createState() => _FacilityState();
}

class _FacilityState extends State<Facility> {
  late List<dynamic> list = <dynamic>[];

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
          title: Text("Facility"),
          backgroundColor: Colors.blue,
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      child: GestureDetector(
                    onTap: () {
                      print(API_Base_urlWithout + list[index].image);
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FacilityUpdate(
                          employee_id: list[index].employee_id,
                          id: list[index].id,
                          title: list[index].title,
                          description: list[index].description,
                          image: API_Base_urlWithout + list[index].image,
                          location: list[index].location,
                          availibilty: list[index].availibilty,
                          cost: list[index].cost,
                          status: list[index].status,
                          create_date: list[index].create_date,
                        ),
                      ));
                    },
                    child: Container(
                      child: Card(
                        child: ListTile(
                            leading: Container(
                              width: 40,
                              child: Container(
                                  child: Image.network(
                                      API_Base_urlWithout + list[index].image)),
                            ),
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
                                              fontWeight: FontWeight.normal,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            list[index].description,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Location: " + list[index].location,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: 5, bottom: 5),
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                if (list[index].status == "1")
                                                  Container(
                                                    height: 28,
                                                    width: 80,
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
                                                if (list[index].status == "2")
                                                  Container(
                                                    height: 28,
                                                    width: 80,
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
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Availibility: " +
                                                list[index].availibilty,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "COST: " + list[index].cost,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            "Created Date: " +
                                                list[index].create_date,
                                            style: TextStyle(
                                              color: Colors.black87,
                                              fontSize: 15,
                                              fontWeight: FontWeight.normal,
                                              decorationStyle:
                                                  TextDecorationStyle.wavy,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )),
                      ),
                    ),
                  ));
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
                      MaterialPageRoute(builder: (context) => FacilityAdd()),
                    );
                  })),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    facilityList();
  }

  Future facilityList() async {
    final response = await http.get(Uri.parse(facilites_list));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var rest = jsonResponse["result"] as List;
      list = rest
          .map<FacilityModal>((json) => FacilityModal.fromJson(json))
          .toList();
      print(list);
      setState(() {});
    } else {
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }

  Future updateStatusApi(String uuid, String status) async {
    final queryParameters = {
      'facilities_id': uuid.toString(),
      'status': status.toString()
    };
    print(queryParameters);
    final response =
    await http.post(Uri.parse(status_facilites), body: queryParameters);
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
        facilityList();
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
