import 'package:flutter/material.dart';
import 'package:flutter_application_1/landingpage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Flutter',
      home: LandingPage(),

      //color: Colors.amber,
    );
  }
}
