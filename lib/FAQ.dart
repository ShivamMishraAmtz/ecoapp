import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:learning/EmployeeModal.dart';
import 'package:learning/FAQAdd.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:learning/AppConstant.dart';
import 'package:learning/FaqModal.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FAQ extends StatefulWidget {
  @override
  _FAQState createState() => _FAQState();
}

class _FAQState extends State<FAQ> {

  final String title="";
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
            title: Text("FAQ"),
            backgroundColor: Colors.blue,
            actions: <Widget>[
            ],
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
                            color: new Color(0xFFEEEEEE),

                            margin: EdgeInsets.only(left: 10,
                                right: 10,
                                top: 10),

                            child: ExpansionTile(

                              title: Text(
                                list[index].question,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              children: [

                                Align(

                                  alignment: Alignment.topLeft,

                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 18, right: 8, top: 8, bottom: 8),
                                    child: Text(list[index].answer,
                                      style: TextStyle(fontSize: 15),

                                      softWrap: true,
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),


                              ],
                            ),

                          ),


                        )
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
                        MaterialPageRoute(builder: (context) => FAQAdd()),
                      );
                    })),
          ),
        ),
      );
    }
    else
      {
        return MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              iconTheme: IconThemeData(color: Colors.white),
              title: Text("FAQ"),
              backgroundColor: Colors.blue,
              actions: <Widget>[
              ],
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
                              color: new Color(0xFFEEEEEE),

                              margin: EdgeInsets.only(left: 10,
                                  right: 10,
                                  top: 10),

                              child: ExpansionTile(

                                title: Text(
                                  list[index].question,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                children: [

                                  Align(

                                    alignment: Alignment.topLeft,

                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 18, right: 8, top: 8, bottom: 8),
                                      child: Text(list[index].answer,
                                        style: TextStyle(fontSize: 15),

                                        softWrap: true,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ),


                                ],
                              ),

                            ),


                          )
                      );
                    }),
              ),
            ),

          ),
        );
      }
  }

  @override
  void initState() {
    super.initState();

    faqList();
    getUserRole();

  }


  Future getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user_role = prefs.getString('user_role')!;
    });
  }


  Future faqList() async {
    EasyLoading.show();
    final response = await http.get(Uri.parse(faq_list));
    print(response.body);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      EasyLoading.dismiss();
      var rest = jsonResponse["result"] as List;
      list = rest
          .map<FaqModal>((json) => FaqModal.fromJson(json))
          .toList();
      print(list);

      setState(() {});
    } else {
      print(response.statusCode);
      EasyLoading.dismiss();
      throw Exception('Failed to create album.');
    }
  }



}
