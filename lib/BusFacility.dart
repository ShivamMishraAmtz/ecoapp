import 'package:flutter/material.dart';
import 'package:learning/BusPassesAdd.dart';
import 'Dashboard.dart';

class BusFacility extends StatefulWidget {
  @override
  _BusFacilityState createState() => _BusFacilityState();
}

class _BusFacilityState extends State<BusFacility> {
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
          title: Text("Bus Passes"),
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
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.asset('assets/user.png'),
                            title: Text('Shivam Mishra\nPass No 3453765'),
                            subtitle: Text('Amtz To KurmanPalem'),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.asset('assets/user.png'),
                            title: Text('Anhad Preet Singh\nPass No 34599765'),
                            subtitle: Text('Amtz To KurmanPalem'),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.asset('assets/user.png'),
                            title: Text('Rajesh Singh\nPass No 34899765'),
                            subtitle: Text('Amtz To KurmanPalem'),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.asset('assets/user.png'),
                            title: Text('Shivam Singh\nPass No 39899765'),
                            subtitle: Text('Amtz To KurmanPalem'),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.asset('assets/user.png'),
                            title: Text('Rajshekhar Singh\nPass No 99899765'),
                            subtitle: Text('Amtz To KurmanPalem'),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                            leading: Image.asset('assets/user.png'),
                            title: Text('Rahul Yadav\nPass No 95899765'),
                            subtitle: Text('Amtz To KurmanPalem'),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                    ],
                  ),
                ],
              ),
            ],
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
                      MaterialPageRoute(builder: (context) => BusPassesAdd()),
                    );
                  })),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
