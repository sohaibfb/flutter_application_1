import 'package:flutter/material.dart';
import 'package:flutter_application_1/AccountStudents.dart';
import 'package:flutter_application_1/SignIn.dart';
import 'package:flutter_application_1/Menu.dart';
import 'package:flutter_application_1/Navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LoadingPageAdmin.dart';
import 'ParentPendingRequest.dart';
import 'package:flutter_geofence/geofence.dart';

class AccountHomepage extends StatefulWidget {
  @override
  _AccountHomepageState createState() => _AccountHomepageState();
}

class _AccountHomepageState extends State<AccountHomepage> {
  int _index = 0;
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
          child: Column(
        children: [
          Text('Hello world'),
          Stepper(currentStep: _index, steps: [
            Step(
              title: Text('step1'),
              content: Text('data'),
            ),
            Step(title: Text('step2'), content: Text('hello step2'))
          ])
        ],
      )),
    );
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    Geofence.requestPermissions();
    Geofence.initialize();

    Geofence.startListening(GeolocationEvent.entry, (entry) {
      print('Latitude: ' +
          entry.latitude.toString() +
          '  longitude: ' +
          entry.longitude.toString());
    });

    Geofence.startListening(GeolocationEvent.exit, (entry) {
      print('Latitude: ' +
          entry.latitude.toString() +
          '  longitude: ' +
          entry.longitude.toString());
    });
    //Geofence.addGeolocation(Geofence.getCurrentLocation(),)
    //getLocation();
    setState(() {});
  }
}

void choiceAction(String choice, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  switch (choice) {
    case Menu.settings_admin:
      Navigation().navigater(context, LoadingPageAdmin());
      break;

    case Menu.settings_parents_pending_requests:
      Navigation().navigater(context, ParentPendingRequest());
      break;

    case Menu.settings_students:
      Navigation().navigater(context, AccountStudents());
      break;

    case Menu.settings_signout:
      prefs.remove('token');
      prefs.remove('tokenadmin');
      prefs.remove('schoolid');
      prefs.remove('username');
      Navigation().replacer(context, SignIn());
      break;
  }
}
