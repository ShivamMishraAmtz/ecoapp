import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learning/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'AppConstant.dart';



class FAQAdd extends StatefulWidget {
  @override
  _FAQAddState createState() => _FAQAddState();
}

class _FAQAddState extends State<FAQAdd> {
  bool rememberMe = false;
  bool _validate = false;
  final _text = TextEditingController();

  bool _validatePassword = false;
  final _textPassword = TextEditingController();

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
          title: Text("Add New FAQ"),
          backgroundColor: Colors.blue,
          actions: <Widget>[

          ],
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
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 100),
                            child: TextField(
                              controller: _text,
                              decoration: InputDecoration(
                                labelText: 'Enter Question',
                                hintText: 'Please Enter Question',
                                errorText:
                                _validate ? 'Value Can\'t Be Empty' : null,
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20),
                            child: TextFormField(
                              keyboardType: TextInputType.multiline,
                              maxLines: 6,
                              maxLength: 1000,
                              controller: _textPassword,
                              decoration: InputDecoration(
                                errorText: _validatePassword
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                labelText: 'Enter Answer',
                                hintText: 'Please Enter Answer',
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),



                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20, bottom: 20),
                            child: MaterialButton(
                              height: 50,
                              minWidth: 350,
                              child: Text("Submit"),
                              textColor: Colors.white,
                              color: const Color(0xff033F93),
                              onPressed: () {
                                setState(() {
                                  _text.text.isEmpty
                                      ? _validate = true
                                      : _validate = false;

                                  _textPassword.text.isEmpty
                                      ? _validatePassword = true
                                      : _validatePassword = false;
                                });


                                if (!_validate && !_validatePassword)
                                   updateApi();


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
  }


  Future updateApi() async {

    EasyLoading.show();

    final prefs = await SharedPreferences.getInstance();
    print(prefs.getInt("uuid"));

    final queryParameters = {
      'added_by':prefs.getInt("uuid").toString(),
      'question':_text.text,
      'answer':_textPassword.text,
    };
    print(queryParameters);
    final response =
    await http.post(Uri.parse(add_faq), body: queryParameters);
    print(response.body);
    if (response.statusCode == 200) {

      EasyLoading.dismiss();

      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      if (jsonResponse['res_code'] == 200) {
        Fluttertoast.showToast(
            msg: "FAQ Added Successfully",
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
