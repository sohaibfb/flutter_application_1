import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/GetSharedPrefs.dart';
import 'package:flutter_application_1/Grades.dart';
import 'package:flutter_application_1/SignInAdmin.dart';
import 'package:flutter_application_1/Users.dart';
import 'package:flutter_application_1/students.dart';
import 'package:flutter_application_1/Menu.dart';
import 'package:flutter_application_1/Navigation.dart';
import 'package:flutter_application_1/transactions.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Locations.dart';
//import 'package:flutter_shapes/flutter_shapes.dart';
//import 'package:flutter_application_1/ShapeCircle1.dart';
//import 'package:flutter_application_1/ShapeCircle2.dart';
//import 'package:flutter_application_1/ShapeCircle3.dart';
//import 'package:flutter_application_1/ShapeLine1.dart';
//import 'package:flutter_application_1/ShapeLine2.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with WidgetsBindingObserver {
  Color circleColor1, lineColor1, circleColor2, lineColor2, circleColor3;
  Stream homeCount, movingCount, schoolCount;
  Stream countData1;
  Future<String> countData;
  AppLifecycleState _notifcation;
  bool resumed = true;

  Stream<String> getcount(String countType) async* {
    SharedPreferences prefs = await GetSharedPrefs().getsharedpreferences();
    var data = {
      "schoolid": prefs.get('schoolid'),
      "counttype": countType,
    };
    String url = ("https://sktest87.000webhostapp.com/gethomecount.php");
    var response;
    while (resumed) {
      //   Geofence.getCurrentLocation().then((coordinate) {
      //   print(
      //     "Your latitude is ${coordinate.latitude} and longitude ${coordinate.longitude}");
      //});
      response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        //print(prefs.get('schoolid'));
        //print("data loaded");

        //print(response.body);

        yield response.body.trim();
      } else {
        throw Exception("failed to load");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LandingPage"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          // IconButton(
          //   icon: Icon(Icons.notification_important), onPressed: () {}),
          PopupMenuButton<String>(
              onSelected: (choice) => choiceAction(choice, context),
              itemBuilder: (BuildContext context) {
                return Menu.adminMenuChoice.map((String choice) {
                  return PopupMenuItem<String>(
                    child: Text(choice),
                    value: choice,
                  );
                }).toList();
              })
        ],
      ),
      body: Center(
        child: Container(
            margin: EdgeInsets.symmetric(vertical: 200),
            padding: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Home'),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: StreamB(
                            count: homeCount,
                          ),
                          decoration: BoxDecoration(
                              color: circleColor1, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(""),
                    Expanded(
                      child: Divider(
                        thickness: 5,
                        color: lineColor1,
                      ),
                    ),
                  ],
                )),
                Expanded(
                  child: Column(
                    children: [
                      Text('Moving'),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: StreamB(
                            count: movingCount,
                          ),
                          decoration: BoxDecoration(
                              color: circleColor2, shape: BoxShape.circle),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                    child: Column(
                  children: [
                    Text(""),
                    Expanded(
                      child: Divider(
                        thickness: 5,
                        color: lineColor1,
                      ),
                    ),
                  ],
                )),
                Expanded(
                  child: Column(
                    children: [
                      Text('School'),
                      Expanded(
                        child: Container(
                          alignment: Alignment.center,
                          child: StreamB(
                            count: schoolCount,
                          ),
                          decoration: BoxDecoration(
                              color: circleColor3, shape: BoxShape.circle),
                        ),
                      ),
                    ],
                  ),
                )
                /*Padding(
          padding: EdgeInsets.only(left: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
            Text('data'),
            CustomPaint(
              painter: ShapeCircle1(
            circleColor1: Colors.grey,
              ),
            ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('data1'),
            CustomPaint(
              painter: ShapeLine1(
            lineColor1: Colors.grey,
            )),
          ],
          ),*/
              ],
            )),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);

    super.initState();
    //homeCount = '1';
    //movingCount = '2';
    // schoolCount = '3';
    //getmovingcount();
    //getschoolcount();
    circleColor1 =
        lineColor1 = circleColor2 = lineColor2 = circleColor3 = Colors.grey;
    loaddata();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    switch (state) {
      case AppLifecycleState.paused:
        resumed = false;

        break;
      case AppLifecycleState.resumed:
        resumed = true;
        loaddata();
        break;
    }
    setState(() {
      _notifcation = state;
      print('state:' + state.toString());
    });
  }

  void loaddata() {
    homeCount = getcount('1');
    movingCount = getcount('2');
    schoolCount = getcount('3');

    setState(() {
      circleColor1 = Colors.green[300];
    });
  }
}

class StreamB extends StatefulWidget {
  final Stream count;
  const StreamB({
    Key key,
    this.count,
  }) : super(key: key);

  @override
  _StreamB createState() => _StreamB();
}

class _StreamB extends State<StreamB> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (context, snapshot) {
        Widget child;
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            child = Text('hello');
            break;

          case ConnectionState.waiting:
            child = CircularProgressIndicator();
            break;

          case ConnectionState.active:
            child = Text(
              snapshot.data,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            );
            break;

          case ConnectionState.done:
            child = Text('Done');
            break;
        }
        return child;
      },
      stream: widget.count,
    );
  }
}

void choiceAction(String choice, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  switch (choice) {
    case Menu.settings_students:
      Navigation().navigater(context, Students());

      break;
    case Menu.settings_grades_and_classes:
      Navigation().navigater(context, Grades());
      break;

    case Menu.settings_accounts_and_permissions:
      Navigation().navigater(context, Users());
      break;

    case Menu.settings_location:
      Navigation().navigater(context, Locations());
      break;

    case Menu.settings_transactions:
      Navigation().navigater(context, Transactions());
      break;

    case Menu.settings_signout:
      prefs.remove('tokenadmin');
      prefs.remove('schoolid');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInAdmin()));
      break;
  }
}
