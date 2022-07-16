import 'package:flutter/material.dart';
import 'package:learning/EmployeeAdd.dart';
import 'package:learning/Employees.dart';
import 'CompanyAdd.dart';
import 'Dashboard.dart';

class EmployeeCompany extends StatefulWidget {
  @override
  _EmployeeCompanyState createState() => _EmployeeCompanyState();
}

class _EmployeeCompanyState extends State<EmployeeCompany> {
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
          title: Text("Select Company"),
          backgroundColor: Colors.blue,
          actions: <Widget>[
            // IconButton(
            //   icon: Icon(
            //     Icons.shopping_cart_rounded,
            //     color: Colors.white,
            //   ),
            //   onPressed: () {},
            // )
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
                                  builder: (context) =>
                                      Employees(title: 'admin')),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://www.amtz.in/static/img/bg/pivot.jpg')),
                              title: Text('AMTZ Admin'),
                              subtitle: Text(
                                  'Wolds first integrated medical device manufacturing ecosystem and fastest industrial zone constructed under 100 acre. Incorporated on 30th April 2016, foundation stone laid on 19th August 2016 and Inaugurated on 13th December 2018'),
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
                                  builder: (context) =>
                                      Employees(title: 'medivalley')),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://amtz.in/image/download/uploads/Hub/Biovalley_image.jpg')),
                              title: Text('Medivalley'),
                              subtitle: Text(
                                  'Medivalley Incubation Council The innovation arm of the pioneering medical device manufacturing ecosystem, the Andhra Pradesh MedTech Zone (AMTZ), Medi Valley Atal Incubation Centre is funded by NITI Aayog under the Atal Innovation Mission.'),
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
                                  builder: (context) =>
                                      Employees(title: 'biovalley')),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://amtz.in/image/download/uploads/Hub/Biovalley_image.jpg')),
                              title: Text('Bio-valley'),
                              subtitle: Text(
                                  'Bio valley Incubation Council is India largest Life sciences focused incubator that supports start-ups through its unique ecosystem, providing unlimited access to cutting edge technologies, as well as market access assistance.'),
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
                                  builder: (context) =>
                                      Employees(title: 'kiht')),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://i0.wp.com/kiht.in/wp-content/uploads/2017/08/cropped-17190965_1619663808060975_2207317309793879674_n-1.jpg?fit=151%2C100&ssl=1')),
                              title: Text('KIHT'),
                              subtitle: Text(
                                  'Kalam Institute of Health Technology (KIHT) aims to facilitate focused research on critical components pertaining to medical devices by supporting institutions involved with R&D, industry, policy makers and knowledge repositories.'),
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
                                  builder: (context) =>
                                      Employees(title: 'ibsc')),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: NetworkImage(
                                      'https://ibsc-amtz.in/web/images/logo-2.png')),
                              title: Text('IBSC'),
                              subtitle: Text(
                                  'IBSC aims at strengthening the Biomedical Skill Sector in the country and with this objective develop job roles and approved by National Skill Development Agency (NSDA) and aligned with National Skill Qualification Framework (NSQF) under Ministry of Skill Development & Entrepreneurship (MSDE).'),
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
                      MaterialPageRoute(builder: (context) => EmployeeAdd()),
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
