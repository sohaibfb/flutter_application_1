import 'package:flutter/material.dart';
import 'package:flutter_application_1/SignInAdmin.dart';
import 'package:flutter_application_1/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'landingpage.dart';

class LoadingPageAdmin extends StatefulWidget {
  @override
  _LoadingPageState createState() {
    return _LoadingPageState();
  }
}

class _LoadingPageState extends State<LoadingPageAdmin> {
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
  }

  @override
  void initState() {
    super.initState();
    checkSingedin(context);
  }
}

void checkSingedin(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  print(prefs.getString('tokenadmin'));
  if (prefs.getString('tokenadmin') == 'signedin') {
    print(prefs.getString('token'));

    Navigation().replacer(context, LandingPage());
    // Navigator.pushReplacement(
    //   context, MaterialPageRoute(builder: (context) => AccountHomepage()));
  } else {
    Navigation().replacer(context, SignInAdmin());
    // Navigator.pushReplacement(
    //   context, MaterialPageRoute(builder: (context) => SignIn()));
  }
}
