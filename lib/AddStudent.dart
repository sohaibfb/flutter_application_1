import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<AddStudent> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('add student'),
        ),
        body: Padding(
            child: Center(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [Text('ID'), TextField()],
            )),
            padding: EdgeInsets.fromLTRB(32, 0, 32, 0)));
  }
}
