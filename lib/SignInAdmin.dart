import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/landingpage.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SignInAdmin extends StatefulWidget {
  SignInAdmin({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<SignInAdmin> {
  TextEditingController schoolID = new TextEditingController();
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();
  Future<String> _checkStatus;

  Future<String> senddata() async {
    String status;
    String url = ("https://sktest87.000webhostapp.com/signinadmin.php");
    var data = {
      //"id": id.text,
      "school_id": schoolID.text,
      "username": username.text,
      "password": password.text,
    };

    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      var uuid = Uuid();
      var token = uuid.v4();

      if (response.body.trim() == "SIGNED") {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('tokenadmin', 'signedin');
        await prefs.setString('schoolid', schoolID.text);
        print(prefs.getString('token'));
        status = '1';

        // return response.body;
      } else {
        status = '0';
        print('objext');
        //return response.body;
      }
    } else {
      print("network error");
    }
    return response.body.trim();
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Form(
          key: _formkey,
          child: Padding(
              padding: EdgeInsets.only(top: 8, left: 64, right: 64, bottom: 64),
              child: ListView(
                children: [
                  TextFormField(
                    controller: schoolID,
                    decoration: InputDecoration(labelText: 'school ID'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter school ID';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: username,
                    decoration: InputDecoration(labelText: 'username'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter username';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: password,
                    decoration: InputDecoration(labelText: 'password'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'enter password';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                      onPressed: () {
                        print("pressed");
                        //if (_formkey.currentState.validate()) {
                        setState(() {
                          _checkStatus = senddata();
                        });
                        _checkStatus
                            .then((value) => authinticateUser(context, value));
                      },
                      child: Text('sign in')),
                ],
              ))),
    );
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
}

void authinticateUser(BuildContext context, String value) {
  if (value == 'SIGNED') {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LandingPage()));
  } else if (value == 'user does not exist') {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('error'),
          content: Text('user does not exit'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('ok'))
          ],
        );
      },
    );
  }
}
