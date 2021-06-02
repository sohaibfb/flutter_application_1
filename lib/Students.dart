import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddStudent.dart';
import 'dart:async';
import 'package:flutter_application_1/Navigation.dart';
import 'package:http/http.dart' as http;

class Students extends StatefulWidget {
  Students({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Students> {
  List _users = [];
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

  Future<String> getdata() async {
    var response = await http.get(
        Uri.parse("https://sktest87.000webhostapp.com/loadstudentsinfo.php"));
    if (response.statusCode == 200) {
      print("data loaded");
      print(response.body);
    }
    return "success";
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
    getdata();
  }
}
