import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<AddStudent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Hello Student'),
      ),
    );
  }
}
