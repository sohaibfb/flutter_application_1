import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddStudent.dart';
import 'dart:async';
import 'package:flutter_application_1/Navigation.dart';
import 'package:flutter_application_1/Student.dart';
import 'package:flutter_application_1/StudentProfile.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class Students extends StatefulWidget {
  Students({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Students> {
  Future<List<Student>> _studentList;

  Future<List<Student>> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = ("https://sktest87.000webhostapp.com/loadstudentsinfo.php");
    var data = {
      "schoolid": prefs.get('schoolid'),
    };

    var response = await http.post(Uri.parse(url), body: data);

    List<Student> studentList = [];
    if (response.statusCode == 200) {
      print("data loaded");
      var id = Uuid();
      var v4 = id.v4();
      print(v4);

      print(response.body);

      var studentsJson = jsonDecode(response.body);
      for (var studentJson in studentsJson) {
        studentList.add(Student.fromJson(studentJson));
      }
      return studentList;
    } else {
      throw Exception("failed to load");
    }
  }

  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Students'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String status = await Navigation().navigater(context, AddStudent());
            if (status == 'success') {
              setState(() {
                _studentList = getdata();
              });
            }
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<Student>>(
            future: _studentList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Student> studentData = snapshot.data;
                return ListView.builder(
                    itemCount: studentData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => itemSelected(
                            studentData[index].firstName,
                            studentData[index].lastName,
                            studentData[index].nationalId,
                            studentData[index].grade,
                            studentData[index].studentClass,
                            context),
                        child: Container(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                textDirection: TextDirection.ltr,
                                children: [
                                  Image(
                                      height: 100,
                                      image: AssetImage('assets/pic1.png')),
                                  Column(
                                    children: [
                                      Text(studentData[index].firstName +
                                          " " +
                                          studentData[index].lastName),
                                      Text(" "),
                                      Text(studentData[index].nationalId),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text(
                        "No Students Defined Yet",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }

                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _studentList = getdata();
    });
  }
}

void itemSelected(String firstName, String lastName, String nationalId,
    String grade, String studentClass, BuildContext context) {
  // Navigator.push(
  //   context,MaterialPageRoute(
  //     builder: (context) =>
  //       StudentProfile(firstName: firstName, lastName: lastName)));
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => StudentProfile(
            firstName: firstName,
            lastName: lastName,
            nationalId: nationalId,
            grade: grade,
            studentClass: studentClass,
          )));
}
