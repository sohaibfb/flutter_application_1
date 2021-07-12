import 'package:flutter/material.dart';
import 'package:flutter_application_1/LoadingPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: LoadingPage(),

      //color: Colors.amber,
    );
  }
}
