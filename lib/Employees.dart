import 'dart:ui';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/AppConstant.dart';
import 'package:learning/EmployeeAdd.dart';
import 'package:learning/EmployeeDetail.dart';
import 'package:learning/EmployeeModal.dart';
import 'Dashboard.dart';
import 'package:http/http.dart' as http;

class Employees extends StatefulWidget {
  final String title;
  Employees({Key? key, required this.title}) : super(key: key);
  @override
  _EmployeesState createState() => _EmployeesState(title: title);
}

class _EmployeesState extends State<Employees> {
  final String title;
  late List<dynamic> list = <dynamic>[];
  _EmployeesState({Key? key, required this.title});

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
          title: Text("User List"),
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
                      child:GestureDetector(
                        onTap: () {
                          print(list[index]);
                          // Navigator.of(context).push(MaterialPageRoute(
                          //   builder: (context) => EventUpdate(
                          //     id: list[index].id,
                          //     title: list[index].title,
                          //     description: list[index].description,
                          //     image: list[index].image,
                          //     from_date: list[index].from_date,
                          //     to_date: list[index].to_date,
                          //   ),
                          // ));
                        },
                        child: Container(
                          child: Card(
                            child: ListTile(
                                leading: Container(
                                  width: 70,
                                  child: Container(
                                      child: Image.network(API_Base_urlWithout +
                                          list[index].profile_image)),
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
                                                list[index].user_id.first_name,
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
                                            if (list[index].phone_number != null)
                                              Flexible(
                                                child: Text(
                                                  "Mobile No: " +
                                                      list[index].phone_number,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.normal,
                                                    decorationStyle:
                                                    TextDecorationStyle.wavy,
                                                  ),
                                                ),
                                              ),
                                            if (list[index].phone_number == null)
                                              Flexible(
                                                child: Text(
                                                  "Mobile No: N/A",
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
                                            if (list[index].company != null)
                                                Flexible(
                                                child: Text(
                                                  "Company: " +
                                                      list[index]
                                                          .company,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.normal,
                                                    decorationStyle:
                                                    TextDecorationStyle.wavy,
                                                  ),
                                                ),
                                              ),
                                            if (list[index].company == null)
                                                Flexible(
                                                child: Text(
                                                  "Comapny: N/A",
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
                                            if (list[index].department != null)
                                              Flexible(
                                                child: Text(
                                                  "Department: " +
                                                      list[index].department,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.normal,
                                                    decorationStyle:
                                                    TextDecorationStyle.wavy,
                                                  ),
                                                ),
                                              ),
                                            if (list[index].department == null)
                                              Flexible(
                                                child: Text(
                                                  "Department: N/A",
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
                                            if (list[index].dob != null)
                                              Flexible(
                                                child: Text(
                                                  "DOB: " + list[index].dob,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.normal,
                                                    decorationStyle:
                                                    TextDecorationStyle.wavy,
                                                  ),
                                                ),
                                              ),
                                            if (list[index].dob == null)
                                              Flexible(
                                                child: Text(
                                                  "DOB: N/A",
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
                                            if (list[index].city != null)
                                              Flexible(
                                                child: Text(
                                                  "City: " + list[index].city,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.normal,
                                                    decorationStyle:
                                                    TextDecorationStyle.wavy,
                                                  ),
                                                ),
                                              ),
                                            if (list[index].city == null)
                                              Flexible(
                                                child: Text(
                                                  "City: N/A",
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
                                            if (list[index].address != null)
                                              Flexible(
                                                child: Text(
                                                  "Address: " + list[index].address,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.normal,
                                                    decorationStyle:
                                                    TextDecorationStyle.wavy,
                                                  ),
                                                ),
                                              ),
                                            if (list[index].address == null)
                                              Flexible(
                                                child: Text(
                                                  "Address: N/A",
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
                                            if (list[index].other_email != null)
                                              Flexible(
                                                child: Text(
                                                  "Email: " +
                                                      list[index].other_email,
                                                  style: TextStyle(
                                                    color: Colors.black87,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.normal,
                                                    decorationStyle:
                                                    TextDecorationStyle.wavy,
                                                  ),
                                                ),
                                              ),
                                            if (list[index].other_email == null)
                                              Flexible(
                                                child: Text(
                                                  "Email: N/A",
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

                                        Container(
                                          margin:
                                          EdgeInsets.only(top: 5, bottom: 5),
                                          child: Container(
                                            margin: EdgeInsets.only(top: 5),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.end,
                                              children: [
                                                if (list[index].user_id.is_active == true)
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
                                                            list[index].user_id
                                                                .id
                                                                .toString(),
                                                            "2");
                                                      },
                                                    ),
                                                  ),
                                                if (list[index].user_id.is_active == false)
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
                                                            list[index].user_id
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
                                  ],
                                )),
                          ),
                        ),
                      )
                  );
                }),
          ),
        ),
        floatingActionButton: Container(
            margin: EdgeInsets.only(bottom: 60),
          child: Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                  elevation: 0.0,
                  child: new Icon(Icons.add),
                  backgroundColor: new Color(0xFFE57373),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EmployeeAdd()),
                    );
                  })),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    employeeList();
  }

  Future employeeList() async {
    EasyLoading.show();
    final response = await http.get(Uri.parse(employee_list));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      var rest = jsonResponse["result"]["result_data"] as List;
      list = rest
          .map<EmployeeModal>((json) => EmployeeModal.fromJson(json))
          .toList();
      print(list);

      EasyLoading.dismiss();
      setState(() {});


    } else {
      print(response.statusCode);
      EasyLoading.dismiss();

      throw Exception('Failed to create album.');
    }
  }

  Future updateStatusApi(String uuid, String status) async {
    EasyLoading.show();

    final queryParameters = {
      'uuid': uuid.toString(),
      'status': status.toString()
    };
    print(queryParameters);
    final response =
        await http.post(Uri.parse(status_employee), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: "Status Updated Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
        employeeList();
      } else {
        EasyLoading.dismiss();
        Fluttertoast.showToast(
            msg: "Some Error Occured",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      }
    }
    else
      {
        EasyLoading.dismiss();
      }
  }
}
