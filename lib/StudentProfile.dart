import 'package:flutter/material.dart';

class StudentProfile extends StatefulWidget {
  final String firstName;
  final String lastName;

  const StudentProfile({Key key, this.firstName, this.lastName})
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
        body: Card(
          child: Container(
            child: Center(
                child: Column(
              children: <Widget>[
                Image(height: 100, image: AssetImage('assets/pic1.png')),
                Text("  "),
                Text(widget.firstName + "  " + widget.lastName),
              ],
            )),
          ),
        ));

    throw UnimplementedError();
  }
}
