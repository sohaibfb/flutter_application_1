import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddStudent.dart';
import 'package:flutter_application_1/Menu.dart';
import 'package:flutter_application_1/Navigation.dart';

import 'AddStudent.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("LandingPage"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          // IconButton(
          //   icon: Icon(Icons.notification_important), onPressed: () {}),
          PopupMenuButton<String>(
              onSelected: (choice) => choiceAction(choice, context),
              itemBuilder: (BuildContext context) {
                return Menu.menuChoice.map((String choice) {
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
    case Menu.settings_students:
      Navigation nav = new Navigation();
      nav.navigater(context, AddStudent());

      break;
  }
}
