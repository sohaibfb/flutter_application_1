import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'Class.dart';
import 'Grade.dart';
import 'package:uuid/uuid.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<AddStudent> {
  String grade;
  String studentClass;
  String relatedCode;
  FocusNode myFocusNode;
  Future<List<Grade>> _gradeList;
  Future<List<Class>> _classList;
  TextEditingController firstName = new TextEditingController();
  TextEditingController midName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController nationalId = new TextEditingController();
  TextEditingController transportionType = new TextEditingController();
  TextEditingController parentName = new TextEditingController();
  TextEditingController mobile = new TextEditingController();
  TextEditingController email = new TextEditingController();

  Future<String> senddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = ("https://sktest87.000webhostapp.com");
    var data = {
      //"id": id.text,
      "schoolid": prefs.get('schoolid'),
      "firstname": firstName.text,
      "midname": midName.text,
      "lastname": lastName.text,
      "nationalid": nationalId.text,
      "grade": grade,
      "studentclass": studentClass,
      "transportationtype": transportionType.text,
      "parentname": parentName.text,
      "mobile": mobile.text,
      "email": email.text,
    };

    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      // print(response.body);

      Navigator.pop(context, 'success');
    } else {
      print("network error");
    }
    return 'success';
  }

  Future<List<Grade>> getgradedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = ("https://sktest87.000webhostapp.com/loadgradesinfo.php");
    var data = {
      "schoolid": prefs.get('schoolid'),
    };

    var response = await http.post(Uri.parse(url), body: data);
    List<Grade> gradeList = [];
    if (response.statusCode == 200) {
      print(prefs.get('schoolid'));
      print("data loaded");

      print(response.body);

      var gradesJson = jsonDecode(response.body);
      for (var gradeJson in gradesJson) {
        gradeList.add(Grade.fromJson(gradeJson));
      }
      return gradeList;
    } else {
      throw Exception("failed to load");
    }
  }

  Future<List<Class>> getclassdata() async {
    List<Class> classList = [];
    var data = {"serialcode": relatedCode};
    String url = ("https://sktest87.000webhostapp.com/loadclassesinfo.php");
    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print("data loaded");
      print("Class related code: " + relatedCode);
      print(response.body);

      var classesJson = jsonDecode(response.body);
      for (var gradeJson in classesJson) {
        classList.add(Class.fromJson(gradeJson));
      }

      return classList;
    } else {
      throw Exception("failed to load");
    }
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('add student'),
        ),
        body: FutureBuilder<List<Grade>>(
          future: _gradeList,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Grade> gradeData = snapshot.data;
              return Form(
                  key: _formkey,
                  child: Padding(
                      padding: EdgeInsets.only(
                          top: 8, left: 64, right: 64, bottom: 64),
                      child: ListView(
                        children: [
                          TextFormField(
                            controller: firstName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'First name'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter First Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: midName,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'M Name'),
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
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Last Name'),
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
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'National ID'),
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
                          DropdownButtonFormField(
                            focusNode: myFocusNode,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              //labelText: 'Grade'
                            ),
                            value: grade,
                            hint: Text("please choose a grade"),
                            onChanged: (newValue) {
                              myFocusNode.requestFocus();
                              setState(() {
                                grade = newValue;
                                relatedCode = newValue;
                                studentClass = null;
                                _classList = getclassdata();
                              });
                            },
                            items: //<String>['One', 'Two', 'three', 'Four']
                                gradeData
                                    .map<DropdownMenuItem<String>>((value) {
                              return DropdownMenuItem<String>(
                                value: value.serialCode,
                                child: Text(value.englishDescription),
                              );
                            }).toList(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          FutureBuilder(
                            future: _classList,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                List<Class> classData = snapshot.data;
                                return DropdownButtonFormField(
                                    focusNode: myFocusNode,
                                    hint: Text("please choose a class"),
                                    decoration: InputDecoration(
                                        border: OutlineInputBorder()),
                                    value: studentClass,
                                    onChanged: (newValue) {
                                      myFocusNode.requestFocus();
                                      setState(() {
                                        studentClass = newValue;
                                      });
                                    },
                                    items: classData
                                        .map<DropdownMenuItem<String>>((value) {
                                      return DropdownMenuItem<String>(
                                        value: value.serialCode,
                                        child: Text(value.englishDescription),
                                      );
                                    }).toList());
                              } else if (snapshot.hasError) {
                                Text("Snapshot error");
                              }
                              return DropdownButtonFormField(
                                  hint: Text("please choose a class"),
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder()),
                                  items: []);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: transportionType,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Transportation Type'),
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
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Parent Name'),
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
                                border: OutlineInputBorder(),
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
                                border: OutlineInputBorder(),
                                icon: Icon(Icons.mail),
                                labelText: 'Email'),
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
                                // if (_formkey.currentState.validate()) {
                                senddata();
                                // } else {}
                              },
                              child: Text('Add student')),
                        ],
                      )));
            }
            return CircularProgressIndicator();
          },
        ));
  }

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();

    setState(() {
      _gradeList = getgradedata();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    firstName.dispose();
    super.dispose();
  }
}
