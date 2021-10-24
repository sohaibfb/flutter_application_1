import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geofence/geofence.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddLocation extends StatefulWidget {
  AddLocation({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<AddLocation> {
  TextEditingController englishName = new TextEditingController();
  TextEditingController arabicName = new TextEditingController();
  TextEditingController latitude = new TextEditingController();
  TextEditingController longitude = new TextEditingController();
  TextEditingController radius = new TextEditingController();

  Future<String> senddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = ("https://sktest87.000webhostapp.com/addlocation.php");
    var data = {
      //"id": id.text,

      "schoolid": prefs.get('schoolid'),
      "englishname": englishName.text,
      "arabicname": arabicName.text,
      "latitude": latitude.text,
      "longitude": longitude.text,
      "radius": radius.text
    };

    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      Geolocation location = Geolocation(
          latitude: double.parse(latitude.text),
          longitude: double.parse(longitude.text),
          radius: double.parse(radius.text),
          id: englishName.text);

      Geofence.addGeolocation(location, GeolocationEvent.entry)
          .then((value) => print('Geofence added successfully'));

      print(response.body);
      Navigator.pop(context, 'success');
    } else {
      print("network error");
    }
    return 'success';
  }

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('add location'),
        ),
        body: Form(
            key: _formkey,
            child: Padding(
                padding:
                    EdgeInsets.only(top: 8, left: 64, right: 64, bottom: 64),
                child: ListView(
                  children: [
                    TextFormField(
                      controller: englishName,
                      decoration: InputDecoration(labelText: 'English name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter English name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: arabicName,
                      decoration: InputDecoration(labelText: 'Arabic Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter Arabic Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: latitude,
                      decoration: InputDecoration(labelText: 'latitude'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter English name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: longitude,
                      decoration: InputDecoration(labelText: 'longitude'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter English name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: radius,
                      decoration: InputDecoration(labelText: 'radius'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter English name';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                        onPressed: () {
                          print("pressed");
                          //if (_formkey.currentState.validate()) {
                          senddata();
                          // } else {}
                        },
                        child: Text('Add GeoFence')),
                    ElevatedButton(
                        onPressed: () {
                          print("pressed");

                          Geofence.getCurrentLocation().then((value) {
                            latitude.text = value.latitude.toString();
                            longitude.text = value.longitude.toString();
                          });
                        },
                        child: Text('get Location'))
                  ],
                ))));
  }
}
