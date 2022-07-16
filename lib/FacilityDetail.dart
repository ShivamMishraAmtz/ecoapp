import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FacilityDetail extends StatefulWidget {
  @override
  _FacilityDetailState createState() => _FacilityDetailState();
}

class _FacilityDetailState extends State<FacilityDetail> {
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
          title: Text("Facility Detail"),
          backgroundColor: Colors.blue,
          actions: <Widget>[

          ],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      Container(
                        height: 200,
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Image.network(
                              'https://i0.wp.com/www.amtz.in/wp-content/uploads/2017/03/gal1-e1504762451850.jpeg?fit=900%2C507&ssl=1',
                              fit: BoxFit.cover,
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(0.0),
                          ),
                          elevation: 5,
                          margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        ),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            title: Text(
                                'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is'),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                      ),
                    ],
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
