import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class AddStudent extends StatefulWidget {
  AddStudent({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<AddStudent> {
  // TextEditingController id = new TextEditingController();
  TextEditingController firstName = new TextEditingController();
  TextEditingController midName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController nationalId = new TextEditingController();
  TextEditingController grade = new TextEditingController();
  TextEditingController studentClass = new TextEditingController();
  TextEditingController transportionType = new TextEditingController();
  TextEditingController parentName = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController email = new TextEditingController();

  Future<String> senddata() async {
    String url = ("http://sktest87.000webhostapp.com");
    var data = {
      //"id": id.text,
      "firstname": firstName.text,
      "midname": midName.text,
      "lastname": lastName.text,
      "nationalid": nationalId.text,
      "grade": grade.text,
      "studentclass": studentClass.text,
      "transportationtype": transportionType.text,
      "parentname": parentName.text,
      "mobile": mobile.text,
      "email": email.text,
    };

    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print(response.body);
      Navigator.pop(context);
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
          title: Text('add student'),
        ),
        body: Form(
            key: _formkey,
            child: Padding(
                padding:
                    EdgeInsets.only(top: 8, left: 64, right: 64, bottom: 64),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: firstName,
                      decoration: InputDecoration(labelText: 'First name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: midName,
                      decoration: InputDecoration(labelText: 'M Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter Middle Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: lastName,
                      decoration: InputDecoration(labelText: 'Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter last Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nationalId,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'National ID'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter National Id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: grade,
                      decoration: InputDecoration(labelText: 'Grade'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter Grade';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: studentClass,
                      decoration: InputDecoration(labelText: 'Class'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter Class';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: transportionType,
                      decoration:
                          InputDecoration(labelText: 'Transportation Type'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter Transportation Type';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: parentName,
                      decoration: InputDecoration(labelText: 'Parent Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Enter parent Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: mobile,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: Icon(Icons.mobile_friendly_sharp),
                          labelText: 'Mobile'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter Mobile';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          icon: Icon(Icons.mail), labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print("pressed");
                          if (_formkey.currentState.validate()) {
                            senddata();
                          } else {}
                        },
                        child: Text('Add student')),
                  ],
                ))));
  }
}
