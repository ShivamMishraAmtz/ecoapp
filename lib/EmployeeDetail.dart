import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Dashboard.dart';

class EmployeeDetail extends StatefulWidget {
  @override
  _EmployeeDetailState createState() => _EmployeeDetailState();
}

class _EmployeeDetailState extends State<EmployeeDetail> {

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
          title: Text("Employee Details"),
          backgroundColor: Colors.blue,
          actions: <Widget>[

          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: <Widget>[
              ListView(
                // set the mainAxisAlignment property here
                children: <Widget>[
                  Container(
                    alignment: Alignment.topCenter,
                    margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/user.png'),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20),
                    child: TextField(
                      controller: _text,
                      decoration: InputDecoration(
                        hintText: 'Shivam Mishra',
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
                    child: TextField(
                      controller: _text,
                      decoration: InputDecoration(
                        hintText: '919838109180',
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
                    child: TextField(
                      controller: _text,
                      decoration: InputDecoration(
                        hintText: 'AMTZ Campus Vizag A.P',
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
                    child: TextField(
                      controller: _textPassword,
                      decoration: InputDecoration(
                        errorText: _validatePassword
                            ? 'Value Can\'t Be Empty'
                            : null,
                        hintText: 'Admin',
                        border: new OutlineInputBorder(
                            borderSide:
                            new BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 20),
                    child: MaterialButton(
                      height: 50,
                      minWidth: 350,
                      child: Text("Update"),
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyHomePages(
                                title: 'Eco App',
                              )),
                        );
                        //fetchPost();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
