import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_application_1/Grades.dart';
import 'package:flutter_application_1/SignInAdmin.dart';
import 'package:flutter_application_1/Users.dart';
import 'package:flutter_application_1/students.dart';
import 'package:flutter_application_1/Menu.dart';
import 'package:flutter_application_1/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shapes/flutter_shapes.dart';
import 'package:flutter_application_1/ShapeCircle1.dart';
import 'package:flutter_application_1/ShapeCircle2.dart';
import 'package:flutter_application_1/ShapeCircle3.dart';
import 'package:flutter_application_1/ShapeLine1.dart';
import 'package:flutter_application_1/ShapeLine2.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Color circleColor1, lineColor1, circleColor2, lineColor2, circleColor3;

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
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text('Home'),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '1',
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: circleColor1, shape: BoxShape.circle),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 5,
                        color: lineColor1,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Home'),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '2',
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: circleColor2, shape: BoxShape.circle),
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Divider(
                        thickness: 5,
                        color: lineColor2,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text('Home'),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              '3',
                              style: TextStyle(color: Colors.white),
                            ),
                            decoration: BoxDecoration(
                                color: circleColor3, shape: BoxShape.circle),
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
                ),
              ))),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    circleColor1 =
        lineColor1 = circleColor2 = lineColor2 = circleColor3 = Colors.grey;

    super.initState();
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

    case Menu.settings_signout:
      prefs.remove('tokenadmin');
      prefs.remove('schoolid');
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => SignInAdmin()));
      break;
  }
}
