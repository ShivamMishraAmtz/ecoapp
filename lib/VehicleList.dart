import 'package:flutter/material.dart';
import 'package:learning/BusFacility.dart';
import 'package:learning/VehicleAdd.dart';

class VehicleList extends StatefulWidget {
  @override
  _VehicleListState createState() => _VehicleListState();
}

class _VehicleListState extends State<VehicleList> {
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
          title: Text("Vehicle List"),
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
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BusFacility()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.asset('assets/bus.png'),
                              title: Text('Tejaswani Bus(AP 39 463683)'),
                              subtitle: Text('Amtz To KurmanPalem'),
                            ),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BusFacility()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.asset('assets/bus.png'),
                              title: Text('Tata Bus(AP 39 673683)'),
                              subtitle: Text('Amtz To Gajuwaka'),
                            ),
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        margin: EdgeInsets.all(10),
                      ),
                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BusFacility()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: Image.asset('assets/van.png'),
                              title: Text('Tata Magic(AP 39 893683)'),
                              subtitle: Text('Amtz To KurmanPalem'),
                            ),
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
                      MaterialPageRoute(
                          builder: (context) => VehicleAdd()),
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
