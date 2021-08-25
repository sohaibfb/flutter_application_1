import 'package:flutter/material.dart';
import 'package:flutter_application_1/Grades.dart';
import 'package:flutter_application_1/SignInAdmin.dart';
import 'package:flutter_application_1/Users.dart';
import 'package:flutter_application_1/students.dart';
import 'package:flutter_application_1/Menu.dart';
import 'package:flutter_application_1/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_shapes/flutter_shapes.dart';
import 'package:flutter_application_1/ShapePainter.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  Color circleColor1;
  Color lineColor1;
  Color circleColor2;
  Color lineColor2;
  Color circleColor3;
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
      body: Row(
        children: [
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('data'),
              CustomPaint(
                painter: ShapePainter(
                    circleColor1: Colors.grey,
                    lineColor1: Colors.grey,
                    circleColor2: Colors.grey,
                    lineColor2: Colors.grey,
                    circleColor3: Colors.grey),
              ),
            ],
          ),
          Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('data1'),
              CustomPaint(
                painter: ShapePainter(
                    circleColor1: Colors.grey,
                    lineColor1: Colors.grey,
                    circleColor2: Colors.grey,
                    lineColor2: Colors.grey,
                    circleColor3: Colors.grey),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

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
