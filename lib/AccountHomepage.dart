import 'package:flutter/material.dart';
import 'package:flutter_application_1/Grades.dart';
import 'package:flutter_application_1/Users.dart';
import 'package:flutter_application_1/students.dart';
import 'package:flutter_application_1/Menu.dart';
import 'package:flutter_application_1/Navigation.dart';
import 'landingpage.dart';

class AccountHomepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          PopupMenuButton<String>(
              onSelected: (choice) => choiceAction(choice, context),
              itemBuilder: (BuildContext context) {
                return Menu.accountMenuChoice.map((String choice) {
                  return PopupMenuItem<String>(
                    child: Text(choice),
                    value: choice,
                  );
                }).toList();
              })
        ],
      ),
      body: Center(
        child: Text('Hello world'),
      ),
    );

    throw UnimplementedError();
  }
}

void choiceAction(String choice, BuildContext context) {
  switch (choice) {
    case Menu.settings_admin:
      Navigation().navigater(context, LandingPage());
      break;
  }
}
