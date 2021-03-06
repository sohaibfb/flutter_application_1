import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<SignUp> {
  TextEditingController username = new TextEditingController();
  TextEditingController password = new TextEditingController();

  Future<String> senddata() async {
    String url = ("https://sktest87.000webhostapp.com/signup.php");
    var data = {
      //"id": id.text,

      "username": username.text,
      "password": password.text,
    };

    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print(response.body);
      Navigator.pop(context, 'success');
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
                        child: Text('sign up')),
                  ],
                ))));
  }
}
