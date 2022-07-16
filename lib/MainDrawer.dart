import 'package:flutter/material.dart';
import 'package:learning/ChnagePassword.dart';
import 'package:learning/FAQ.dart';
import 'package:learning/Login.dart';
import 'package:learning/MyProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            Container(
              width: 304,
              child: Container(
                  width: double.infinity,
                  height: 250,
                  color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: AssetImage('assets/user.png'),
                      ),
                      Text(
                        "Shivam Mishra",
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ],
                  )),
            ),
          ],
        ),
        SizedBox(
          height: 20.0,
        ),
        ListTile(
          onTap: () {
            Navigator.pop(context);
          },
          leading: Icon(
            Icons.home,
            color: Colors.black,
          ),
          title: Text("Home"),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyProfile()),
            );
          },
          leading: Icon(
            Icons.verified_user_rounded,
            color: Colors.black,
          ),
          title: Text("Profile"),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FAQ()),
            );
          },
          leading: Icon(
            Icons.question_answer,
            color: Colors.black,
          ),
          title: Text("FAQ"),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePassword()),
            );
          },
          leading: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: Text("Setting"),
        ),
        ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChangePassword()),
            );
          },
          leading: Icon(
            Icons.password,
            color: Colors.black,
          ),
          title: Text("Change Password"),
        ),
        ListTile(
          onTap: () async {
            final prefs = await SharedPreferences.getInstance();
            prefs.clear();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
          leading: Icon(
            Icons.logout,
            color: Colors.black,
          ),
          title: Text("Logout"),
        )
      ],
    );
  }



}
