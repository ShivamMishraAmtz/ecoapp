import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:learning/AppConstant.dart';
import 'package:learning/UpdateDepartmentStatus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyComplainDetail extends StatefulWidget {
  final int id;
   var complaints_user;
  var company_id;
  final int department_id;
  final String subject;
  final String description;
  final String image_one;
  final String image_two;
  final String image_three;
  final String image_four;
  final String image_five;

  final String resolved_by_user;
  final String remarks;
  final String resolved_image;
  final String resolved_date;
  final String create_date;
  final String status;

  MyComplainDetail({
    Key? key,
    required this.id,
    required this.complaints_user,
    required this.company_id,
    required this.department_id,
    required this.description,
    required this.subject,
    required this.image_one,
    required this.image_two,
    required this.image_three,
    required this.image_four,
    required this.image_five,
    required this.resolved_by_user,
    required this.remarks,
    required this.resolved_image,
    required this.resolved_date,
    required this.create_date,
    required this.status,
  }) : super(key: key);

  @override
  _MyComplainDetailState createState() => _MyComplainDetailState(
        id: id,
        complaints_user: complaints_user,
        company_id: company_id,
        department_id: department_id,
        description: description,
        subject: subject,
        image_one: image_one,
        image_two: image_two,
        image_three: image_three,
        image_four: image_four,
        image_five: image_five,
        resolved_by_user: resolved_by_user,
        remarks: remarks,
        resolved_image: resolved_image,
        resolved_date: resolved_date,
        create_date: create_date,
        status: status,
      );
}

class _MyComplainDetailState extends State<MyComplainDetail> {
  final int id;
  var complaints_user;
  var company_id;
  final int department_id;
  final String subject;
  final String description;
  final String image_one;
  final String image_two;
  final String image_three;
  final String image_four;
  final String image_five;
  final String resolved_by_user;
  final String remarks;
  final String resolved_image;
  final String resolved_date;
  final String create_date;
  final String status;

  _MyComplainDetailState(
      {Key? key,
      required this.id,
      required this.complaints_user,
      required this.company_id,
      required this.department_id,
      required this.subject,
      required this.description,
      required this.image_one,
      required this.image_two,
      required this.image_three,
      required this.image_four,
      required this.image_five,
      required this.resolved_by_user,
      required this.remarks,
      required this.resolved_image,
      required this.resolved_date,
      required this.create_date,
      required this.status});
  //
  // int _activeCurrentStep = 0;
  //
  // List<Step> stepList() => [
  //       Step(
  //         state:
  //             _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
  //         isActive: _activeCurrentStep >= 0,
  //         title: const Text('Pending'),
  //         content: Container(),
  //       ),
  //       Step(
  //         state:
  //             _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
  //         isActive: _activeCurrentStep >= 1,
  //         title: const Text('In-Progress'),
  //         content: Container(),
  //       ),
  //       Step(
  //         state: StepState.complete,
  //         isActive: _activeCurrentStep >= 2,
  //         title: const Text('Completed'),
  //         content: Container(),
  //       )
  //     ];

  int _activeCurrentStep = 0;
  int _checkCancellStatus = 0;

  List<Step> stepList() => [
    Step(
      state:
      _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 0,
      title: const Text('Pending',
        style: TextStyle(
          fontSize: 12,

        ),
      ),
      content: Container(),
    ),
    Step(
      state:
      _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 1,
      title: const Text('In-Progress',
        style: TextStyle(
          fontSize: 12,

        ),
      ),
      content: Container(),
    ),
    Step(
      state: StepState.complete,
      isActive: _activeCurrentStep >= 2,
      title: const Text('Completed',
        style: TextStyle(
          fontSize: 12,

        ),
      ),
      content: Container(),
    )
  ];

  List<Step> stepCancelList() => [
    Step(
      state:
      _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 0,
      title: const Text('Pending'),
      content: Container(),
    ),
    Step(
      state:
      _activeCurrentStep <= 1 ? StepState.editing : StepState.complete,
      isActive: _activeCurrentStep >= 1,
      title: const Text('In-Progress'),
      content: Container(),
    ),
    Step(
      state: StepState.error,
      isActive: _activeCurrentStep >= 2,
      title: const Text('Cancelled'),
      content: Container(),
    )
  ];

  String user_role = "";



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
          title: Text("Complain Detail"),
          backgroundColor: Colors.blue,
          actions: <Widget>[],
        ),
        backgroundColor: Colors.white,
        body: Center(
          child: Stack(
            children: <Widget>[
              if (_activeCurrentStep == 0 ||
                  _activeCurrentStep == 1 ||
                  _activeCurrentStep == 2)
                Container(
                  child: Stepper(
                    type: StepperType.horizontal,
                    currentStep: _activeCurrentStep,
                    controlsBuilder:
                        (BuildContext context, ControlsDetails controls) {
                      return Row(
                        children: <Widget>[],
                      );
                    },
                    steps: stepList(),
                  ),
                ),
              if (_checkCancellStatus == 1)
                Container(
                  child: Stepper(
                    type: StepperType.horizontal,
                    currentStep: _activeCurrentStep,
                    controlsBuilder:
                        (BuildContext context, ControlsDetails controls) {
                      return Row(
                        children: <Widget>[],
                      );
                    },
                    steps: stepCancelList(),
                  ),
                ),



              Container(
                margin: EdgeInsets.only(top: 70),
                child: ListView(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          subject,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decorationStyle: TextDecorationStyle.wavy,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        margin: EdgeInsets.all(10),
                        child: Text(description),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        if(image_one!=null)
                        Container(
                          height: 120,
                          width: 120,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.network(
                                API_Base_urlWithout + image_one,
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

                        if(image_two!=null)
                        Container(
                          height: 120,
                          width: 120,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.network(
                                API_Base_urlWithout + image_two,
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

                        if(image_three!=null)
                        Container(
                          height: 120,
                          width: 120,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.network(
                                API_Base_urlWithout + image_three,
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
                      ],
                    ),

                    if(image_four!=null || image_five!=null)

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if(image_four!=null)
                        Container(
                          height: 120,
                          width: 120,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.network(
                                API_Base_urlWithout + image_four,
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
                        if(image_five!=null)
                        Container(
                          height: 120,
                          width: 120,
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: Image.network(
                                API_Base_urlWithout + image_five,
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

                        Container(
                          height: 120,
                          width: 120,
                        ),
                      ],
                    ),

                    if(remarks!=null)...{
                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.only(left: 10, top: 10),
                            child: Text(
                              "Remarks",
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                decorationStyle: TextDecorationStyle.wavy,
                              ),
                            ),
                          ),
                        ),

                        Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 10, top: 10),
                          child: Text(
                            "Resolved Date- "+resolved_date,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              decorationStyle: TextDecorationStyle.wavy,
                            ),
                          ),
                        ),
                      ),

                        Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Text(remarks),
                          ),
                        ),
                      },

                    if(user_role == "2")
                      Container(
                      margin: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 20),
                      child: MaterialButton(
                        height: 50,
                        minWidth: 350,
                        child: Text("Update Status"),
                        textColor: Colors.white,
                        color: const Color(0xff033F93),
                        onPressed: () {
                          setState(() {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UpdateDepartmentStatus(
                                id: id,
                              ),
                            ));
                          });
                          //fetchPost();
                        },
                      ),
                    ),


                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      user_role = prefs.getString('user_role')!;

      print(user_role+"   sdghmh");
    });
  }

  @override
  void initState() {
    super.initState();
    getUserRole();
    print(status);
    setState(() {


      _activeCurrentStep = int.parse(status) - 1;

      if (_activeCurrentStep > 2) {
        _activeCurrentStep = 0;
        _checkCancellStatus = 1;
      } else {
        _checkCancellStatus = 0;
      }
    });


  }
}
