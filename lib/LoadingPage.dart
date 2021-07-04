import 'package:flutter/material.dart';
import 'package:flutter_application_1/Grades.dart';
import 'package:flutter_application_1/SignIn.dart';
import 'package:flutter_application_1/Users.dart';
import 'package:flutter_application_1/students.dart';
import 'package:flutter_application_1/Menu.dart';
import 'package:flutter_application_1/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AccountHomepage.dart';
import 'landingpage.dart';

class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() {
    return _LoadingPageState();
  }
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
        actions: <Widget>[],
      ),
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );

    throw UnimplementedError();
  }

  @override
  void initState() {
    super.initState();
    checkSingedin(context);
  }
}

void checkSingedin(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getString('token'));
  if (prefs.getString('token') == 'signedin') {
    print(prefs.getString('token'));
    // Navigation().navigater(context, AccountHomepage());

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AccountHomepage()));
  } else {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => SignIn()));
  }
}
