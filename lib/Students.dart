import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddStudent.dart';
import 'dart:async';
import 'package:flutter_application_1/Navigation.dart';
import 'package:flutter_application_1/Student.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Students extends StatefulWidget {
  Students({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Students> {
  Future<List<Student>> _studentList;

  Future<List<Student>> getdata() async {
    List<Student> studentList = [];
    var response = await http.get(
        Uri.parse("https://sktest87.000webhostapp.com/loadstudentsinfo.php"));
    if (response.statusCode == 200) {
      print("data loaded");

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
          onPressed: () {
            Navigation nav = new Navigation();
            nav.navigater(context, AddStudent());
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
                      return Container(
                        child: Card(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(studentData[index].id),
                                  Text(studentData[index].nationalId),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(studentData[index].firstName),
                                  Text(studentData[index].lastName),
                                ],
                              )
                            ],
                          ),
                        )),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      _studentList = getdata();
    });
  }
}