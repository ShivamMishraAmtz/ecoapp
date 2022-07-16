import 'dart:async';

import 'package:flutter/material.dart';
import 'package:learning/EventAdd.dart';
import 'package:learning/EventDetail.dart';

class OurPartner extends StatefulWidget {
  @override
  _OurPartnerState createState() => _OurPartnerState();
}

class _OurPartnerState extends State<OurPartner> {
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
        title: Text("Our Partner"),
        backgroundColor: Colors.blue,
        actions: <Widget>[

        ],
      ),
      body: Stack(
        children: <Widget>[


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
