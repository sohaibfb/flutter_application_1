import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddLocation.dart';
import 'package:flutter_application_1/Classes.dart';
import 'package:flutter_application_1/Location.dart';
import 'dart:async';
import 'package:flutter_application_1/Navigation.dart';
import 'package:flutter_application_1/Grade.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class Locations extends StatefulWidget {
  Locations({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Locations> {
  Future<List<Location>> _locationList;

  Future<List<Location>> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = ("https://sktest87.000webhostapp.com/loadlocationsinfo.php");
    var data = {
      "schoolid": prefs.get('schoolid'),
    };

    var response = await http.post(Uri.parse(url), body: data);
    List<Location> locationList = [];
    if (response.statusCode == 200) {
      print(prefs.get('schoolid'));
      print("data loaded");

      print(response.body);

      var locationsJson = jsonDecode(response.body);
      for (var locationJson in locationsJson) {
        locationList.add(Location.fromJson(locationJson));
      }
      return locationList;
    } else {
      throw Exception("failed to load");
    }
  }

  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Locations'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String status =
                await Navigation().navigater(context, AddLocation());
            if (status == 'success') {
              setState(() {
                _locationList = getdata();
              });
            }
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<Location>>(
            future: _locationList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Location> locationData = snapshot.data;
                return ListView.builder(
                    itemCount: locationData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => itemSelected(
                            locationData[index].serialCode, context),
                        child: Container(
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Row(
                                textDirection: TextDirection.ltr,
                                children: [
                                  Image(
                                      height: 100,
                                      image: AssetImage('assets/pic1.png')),
                                  Column(
                                    children: [
                                      Text(locationData[index]
                                              .englishDescription +
                                          " " +
                                          locationData[index]
                                              .arabicDescription),
                                      Text(" "),
                                      Text(locationData[index].id),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text(
                        "No Locations Defined Yet",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                }

                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _locationList = getdata();
    });
  }
}

void itemSelected(String serialCode, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Classes(
            serialCode: serialCode,
          )));
}
