import 'package:flutter/material.dart';
import 'package:flutter_application_1/ApproveParentPendingRequest.dart';
import 'dart:async';
import 'package:flutter_application_1/Student.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class ParentPendingRequest extends StatefulWidget {
  ParentPendingRequest({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<ParentPendingRequest> {
  Future<List<Student>> _studentList;

  Future<List<Student>> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url =
        ("https://sktest87.000webhostapp.com/loadpendingstudentsinfo.php");
    var data = {
      "username": prefs.get('username'),
    };
    try {
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
    } catch (e) {
      throw Exception(e.message);
    }
  }

  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pending Requests'),
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
                        onTap: () async {
                          String status = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ApproveParentPendingRequest(
                                        schoolId: studentData[index].schoolId,
                                        firstName: studentData[index].firstName,
                                        lastName: studentData[index].lastName,
                                        nationalId:
                                            studentData[index].nationalId,
                                        grade: studentData[index].grade,
                                        studentClass:
                                            studentData[index].studentClass,
                                      )));
                          if (status == 'success') {
                            setState(() {
                              _studentList = getdata();
                            });
                          }
                        },
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
                        "No Pending Requests",
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
    String grade, String studentClass, BuildContext context) async {
  String status = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ApproveParentPendingRequest(
            firstName: firstName,
            lastName: lastName,
            nationalId: nationalId,
            grade: grade,
            studentClass: studentClass,
          )));
}
