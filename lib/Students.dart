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
  List<Student> _studentList = [];

  Future<List<Student>> getdata() async {
    List studentList = [];
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
        body: Container());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getdata();
    });
  }
}
