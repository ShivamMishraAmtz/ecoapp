import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learning/EventAdd.dart';
import 'package:learning/EventDetail.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  bool isLoading=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Contact Us"),
        backgroundColor: Colors.blue,
        actions: <Widget>[

        ],
      ),
      body: Stack(
        children: <Widget>[

          isLoading ? Center( child: CircularProgressIndicator(),)
              : Stack(),
        ],
      ),
    );
  }





  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      setState(() {
        isLoading = false;
      });
    });




  }
}
