import 'package:flutter/material.dart';
import 'package:learning/Dashboard.dart';

class BusPassesAdd extends StatefulWidget {
  @override
  _BusPassesAddState createState() => _BusPassesAddState();
}

class _BusPassesAddState extends State<BusPassesAdd> {
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
          title: Text("Add New Bus Passes"),
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
                                left: 20.0, right: 20.0, top: 20),
                            child: TextField(
                              controller: _text,
                              decoration: InputDecoration(
                                labelText: 'Event Candidate Name',
                                hintText: 'Please Enter Your Event Title',
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
                                labelText: 'Event Company Name',
                                hintText: 'Please Enter Your Event Title',
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
                                labelText: 'Event Employee ID',
                                hintText: 'Please Enter Your Event Title',
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
                                labelText: 'Event Vehicle Registration Number',
                                hintText: 'Please Enter Your Event Title',
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
                                labelText: 'Event Description',
                                hintText: 'Please Employee Designation',
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 10,bottom: 13),
                            child: TextField(
                              keyboardType: TextInputType.multiline,

                              controller: _textPassword,
                              decoration: InputDecoration(
                                errorText: _validatePassword
                                    ? 'Value Can\'t Be Empty'
                                    : null,
                                labelText: 'New Bus Pass No',
                                hintText: 'Please Employee Designation',
                                border: new OutlineInputBorder(
                                    borderSide:
                                    new BorderSide(color: Colors.white)),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Container(
                                width:
                                MediaQuery.of(context).size.width / 2 - 30,
                                margin: const EdgeInsets.only(
                                    left: 20.0, right: 0.0, top: 5, bottom: 20),
                                child: TextField(
                                  controller: _text,
                                  decoration: InputDecoration(
                                    labelText: 'Start From',
                                    hintText: 'Please Enter Event Start Date',
                                    errorText: _validate
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                              Container(
                                width:
                                MediaQuery.of(context).size.width / 2 - 30,
                                margin: const EdgeInsets.only(
                                    left: 20.0,
                                    right: 20.0,
                                    top: 5,
                                    bottom: 20),
                                child: TextField(
                                  controller: _textPassword,
                                  decoration: InputDecoration(
                                    errorText: _validatePassword
                                        ? 'Value Can\'t Be Empty'
                                        : null,
                                    labelText: 'Start End',
                                    hintText: 'Please Enter Event End Date',
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.white)),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 0.0, right: 0.0, top: 00),
                            child: Image.asset(
                              'assets/frame.png',
                              height: 200,
                              width: 200,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20),
                            child: MaterialButton(
                              height: 50,
                              minWidth: 350,
                              child: Text("Upload Picture"),
                              textColor: Colors.white,
                              color: Colors.blueGrey,
                              onPressed: () {
                                //fetchPost();
                              },
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
}
