import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String nationalId;
  final String grade;
  final String studentClass;

  const StudentProfile(
      {Key key,
      this.firstName,
      this.lastName,
      this.nationalId,
      this.grade,
      this.studentClass})
      : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<StudentProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Student Profile"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Card(
                  child:
                      Image(height: 100, image: AssetImage('assets/pic1.png')),
                ),
                Column(
                  children: [
                    Text("  "),
                    Text(
                      widget.firstName + "  " + widget.lastName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ID#' + widget.nationalId,
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text('Grade: ' + widget.grade),
                    Text('Class: ' + widget.studentClass),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
