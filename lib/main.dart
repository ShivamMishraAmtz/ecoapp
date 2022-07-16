// @dart=2.9
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:learning/Dashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'EmployeeDashboard.dart';
import 'Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Set the fit size (fill in the screen size of the device in the design) If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
    return ScreenUtilInit(
      designSize: Size(360, 690),
      builder: () => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter_ScreenUtil',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(button: TextStyle(fontSize: 45.sp)),
        ),
        home: MyHomePage(),
        builder: EasyLoading.init(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  initState() {
    moveApi();
  }
  moveApi() {
    Timer(Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      print(prefs.getInt("uuid"));
      if (prefs.getInt("uuid") == null)
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      else if (prefs.getString('user_role') == "1") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyDashboardHomePages(
                    title: 'Eco App',
                  )),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => MyHomePages(
                    title: 'Eco App',
                  )),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: new ExactAssetImage('assets/signupimage.png'),
          ),
        ),
        child: Center(
            child: Image.asset(
          'assets/logo.png',
          height: 200,
          width: 200,
        )),
      ),
    );
  }

}
