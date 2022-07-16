import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learning/AppConstant.dart';
import 'package:learning/CompanyAdd.dart';
import 'package:learning/CompanyDataModal.dart';
import 'package:learning/CompanyDetails.dart';
import 'package:learning/CompanyUpdate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Dashboard.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Company extends StatefulWidget {
  @override
  _CompanyState createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  late List<dynamic> list = <dynamic>[];
  String user_role = "";

  @override
  Widget build(BuildContext context) {
    if (user_role == "2") {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("Our Company"),
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CompanyUpdate(
                          id: list[index].id,
                          image: ( list[index].company_logo!=null) ? API_Base_urlWithout + list[index].company_logo: "",
                          companyName: list[index].company_name,
                          companyDescription: list[index].description,
                          companyEmail: list[index].email_id,
                          companyType: list[index].type,
                          companyLocation: list[index].company_address,
                          companyContactNo: list[index].mobile_number_first,
                          companyContactNoSecond:
                              list[index].mobile_number_second,
                          url: list[index].url,
                        ),
                      ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: Card(
                        margin: EdgeInsets.all(0),
                        child: ListTile(

                          title:
                          (list[index].company_name != null)
                              ? Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          list[index].company_name,
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

                                          if(list[index]
                                              .mobile_number_first!=null)
                                            Flexible(
                                              child: Text(
                                                "Mob: " +
                                                    list[index]
                                                        .mobile_number_first,
                                                maxLines: 3,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  decorationStyle:
                                                  TextDecorationStyle.wavy,
                                                ),
                                              ),
                                            )
                                          else
                                            Flexible(
                                              child: Text(
                                                "Mob: N/A",
                                                maxLines: 3,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  decorationStyle:
                                                  TextDecorationStyle.wavy,
                                                ),
                                              ),
                                            )


                                          // if (list[index].status == "1")
                                          //   Container(
                                          //     height: 28,
                                          //     width: 65,
                                          //     child: FlatButton(
                                          //       child: Text("Active",
                                          //         style:
                                          //         TextStyle(fontSize: 10.0),
                                          //       ),
                                          //       color: Colors.green,
                                          //       textColor: Colors.white,
                                          //       onPressed: () {
                                          //         updateStatusApi(list[index].id.toString(), "2");
                                          //       },
                                          //     ),
                                          //   ),
                                          // if(list[index].status == "2")
                                          //   Container(
                                          //     height: 28,
                                          //     width: 75,
                                          //     child: FlatButton(
                                          //       child: Text("In-Active",
                                          //         style:
                                          //         TextStyle(fontSize: 10.0),
                                          //       ),
                                          //       color: Colors.redAccent,
                                          //       textColor: Colors.white,
                                          //       onPressed: () {
                                          //         updateStatusApi(list[index].id.toString(), "1");
                                          //       },
                                          //     ),
                                          //   ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      children: [
                                        if( list[index].email_id!=null)
                                          Flexible(
                                            child: Text(
                                              "Email Id: " +
                                                  list[index].email_id,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.normal,
                                                decorationStyle:
                                                TextDecorationStyle.wavy,
                                              ),
                                            ),
                                          )
                                        else
                                          Flexible(
                                            child: Text(
                                              "Email Id: N/A",
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
                                          "Address: " +
                                              list[index].company_address,
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
                          ) : null,
                          leading: (list[index].company_logo != null)
                              ? Container(
                              width: 50,
                              child:
                              Image.network(API_Base_urlWithout + list[index].company_logo))
                              : Container(
                              width: 50,
                              child:
                              Image.network("https://www.amtz.in/static/img/bg/admin_image.jpg")),
                        ) ,


                            ),
                      )
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
                        MaterialPageRoute(builder: (context) => CompanyAdd()),
                      );
                    })),
          ),
        ),
      );
    }
    else {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("All Company"),
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
                        // Navigator.of(context).push(MaterialPageRoute(
                        //   builder: (context) => CompanyUpdate(
                        //     id: list[index].id,
                        //     image: ( list[index].company_logo!=null) ? API_Base_urlWithout + list[index].company_logo: "",
                        //     companyName: list[index].company_name,
                        //     companyDescription: list[index].description,
                        //     companyEmail: list[index].email_id,
                        //     companyType: list[index].type,
                        //     companyLocation: list[index].company_address,
                        //     companyContactNo: list[index].mobile_number_first,
                        //     companyContactNoSecond:
                        //     list[index].mobile_number_second,
                        //     url: list[index].url,
                        //   ),
                        // ));
                      },
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Card(
                          margin: EdgeInsets.all(0),
                          child: ListTile(

                            title:
                            (list[index].company_name != null)
                                ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Text(
                                            list[index].company_name,
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

                                            if(list[index]
                                                .mobile_number_first!=null)
                                              Flexible(
                                                child: Text(
                                                  "Mob: " +
                                                      list[index]
                                                          .mobile_number_first,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    decorationStyle:
                                                    TextDecorationStyle.wavy,
                                                  ),
                                                ),
                                              )
                                            else
                                              Flexible(
                                                child: Text(
                                                  "Mob: N/A",
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.normal,
                                                    decorationStyle:
                                                    TextDecorationStyle.wavy,
                                                  ),
                                                ),
                                              )


                                            // if (list[index].status == "1")
                                            //   Container(
                                            //     height: 28,
                                            //     width: 65,
                                            //     child: FlatButton(
                                            //       child: Text("Active",
                                            //         style:
                                            //         TextStyle(fontSize: 10.0),
                                            //       ),
                                            //       color: Colors.green,
                                            //       textColor: Colors.white,
                                            //       onPressed: () {
                                            //         updateStatusApi(list[index].id.toString(), "2");
                                            //       },
                                            //     ),
                                            //   ),
                                            // if(list[index].status == "2")
                                            //   Container(
                                            //     height: 28,
                                            //     width: 75,
                                            //     child: FlatButton(
                                            //       child: Text("In-Active",
                                            //         style:
                                            //         TextStyle(fontSize: 10.0),
                                            //       ),
                                            //       color: Colors.redAccent,
                                            //       textColor: Colors.white,
                                            //       onPressed: () {
                                            //         updateStatusApi(list[index].id.toString(), "1");
                                            //       },
                                            //     ),
                                            //   ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          if( list[index].email_id!=null)
                                            Flexible(
                                              child: Text(
                                                "Email Id: " +
                                                    list[index].email_id,
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  decorationStyle:
                                                  TextDecorationStyle.wavy,
                                                ),
                                              ),
                                            )
                                          else
                                            Flexible(
                                              child: Text(
                                                "Email Id: N/A",
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
                                            "Address: " +
                                                list[index].company_address,
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
                            ) : null,
                            leading: (list[index].company_logo != null)
                                ? Container(
                                width: 50,
                                child:
                                Image.network(API_Base_urlWithout + list[index].company_logo))
                                : Container(
                                width: 50,
                                child:
                                Image.network("https://www.amtz.in/static/img/bg/admin_image.jpg")),
                          ) ,


                        ),
                      )
                  );
                }),
          ),

        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    getUserRole();
    companyList();
  }

  Future getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user_role = prefs.getString('user_role')!;
    });
  }

  Future companyList() async {
    EasyLoading.show();
    final response = await http.get(Uri.parse(company_list));
    print(response.body);
    if (response.statusCode == 200) {
      EasyLoading.dismiss();
      final jsonResponse = json.decode(response.body);
      print(jsonResponse["result"] as List);
      setState(() {});
      try {
        var rest = jsonResponse["result"] as List;
        list = rest
            .map<CompanyDataModal>((json) => CompanyDataModal.fromJson(json))
            .toList();
      } on Exception catch (_) {

      }
      setState(() {});


    } else {
      EasyLoading.dismiss();
      print(response.statusCode);
      throw Exception('Failed to create album.');
    }
  }
}
