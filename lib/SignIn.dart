import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/AccountHomepage.dart';
import 'package:flutter_application_1/Navigation.dart';
import 'package:flutter_application_1/SignUp.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<SignIn> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  Future<String> senddata() async {
    String url = ("https://sktest87.000webhostapp.com/signin.php");
    var data = {
      //"id": id.text,

      "username": username.text,
      "password": password.text,
    };

    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      var uuid = Uuid();
      var token = uuid.v4();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', 'signedin');
      //print(prefs.getString('token'));
      // print(response.body);

      Navigation().navigater(context, AccountHomepage());
    } else {
      print("network error");
    }
    return 'success';
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
        ),
        body: Form(
            key: _formkey,
            child: Padding(
                padding:
                    EdgeInsets.only(top: 8, left: 64, right: 64, bottom: 64),
                child: ListView(
                  children: [
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
                          senddata();
                          // } else {}
                        },
                        child: Text('sign in')),
                    ElevatedButton(
                        onPressed: () {
                          Navigation().navigater(context, SignUp());
                        },
                        child: Text('sign up'))
                  ],
                ))));
  }

  @override
  void initState() {
    // TODO: implement initState

    checkSingedin(context);
    super.initState();
  }
}

void checkSingedin(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getString('token') == 'signed') {
    Navigation().navigater(context, AccountHomepage());
  }
}