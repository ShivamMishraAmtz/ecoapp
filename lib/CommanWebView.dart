import 'dart:async';

import 'package:flutter/material.dart';
import 'AppConstant.dart';

class CommanWebView extends StatefulWidget {
  final String title;
  final String url;

  CommanWebView({Key? key, required this.title, required this.url})
      : super(key: key);

  @override
  _CommanWebViewDataState createState() => _CommanWebViewDataState(title: title, url: url);
}

class _CommanWebViewDataState extends State<CommanWebView> {
  bool isLoading = true;
  final String title;
  final String url;

  _CommanWebViewDataState({Key? key, required this.title, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(title),
        backgroundColor: Colors.blue,
        actions: <Widget>[],
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
