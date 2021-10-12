import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddStudent.dart';
import 'dart:async';
import 'package:flutter_application_1/Navigation.dart';
import 'package:flutter_application_1/Student.dart';
import 'package:flutter_application_1/UpdateStudentStatus.dart';
import 'package:flutter_geofence/geofence.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class Transactions extends StatefulWidget {
  Transactions({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Transactions> {
  Future<List<Student>> _studentList;
  TextEditingController dateText = new TextEditingController();

  String date = DateFormat('yyyyMMdd').format(DateTime.now());
  Future<List<Student>> getdata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = ("https://sktest87.000webhostapp.com/loadstudentsinfo.php");
    var data = {
      "schoolid": prefs.get('schoolid'),
    };

    var response = await http.post(Uri.parse(url), body: data);

    List<Student> studentList = [];
    if (response.statusCode == 200) {
      print("data loaded");
      var id = Uuid();
      var v4 = id.v4();
      // print(v4);

      // print(response.body);

      var studentsJson = jsonDecode(response.body);
      for (var studentJson in studentsJson) {
        studentList.add(Student.fromJson(studentJson));
      }
      return studentList;
    } else {
      throw Exception("failed to load");
    }
  }

  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Transactions'),
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.symmetric(
                  horizontal: 30 * MediaQuery.of(context).size.width / 100,
                ),
                height: 60,
                // width: double.maxFinite,
                color: Colors.blue,
                child: TextField(
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          borderSide: BorderSide(width: 30))),
                  readOnly: true,
                  controller: dateText,
                  style: TextStyle(decorationColor: Colors.white),
                  textAlign: TextAlign.center,
                )), //Text(date)),
            Container(
              child: Expanded(
                child: FutureBuilder<List<Student>>(
                    future: _studentList,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<Student> studentData = snapshot.data;
                        return ListView.builder(
                            itemCount: studentData.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () async {
                                  String status = await itemSelected(
                                      studentData[index].schoolId,
                                      studentData[index].id,
                                      studentData[index].nationalId,
                                      studentData[index].firstName,
                                      studentData[index].lastName,
                                      studentData[index].grade,
                                      studentData[index].studentClass,
                                      context);

                                  if (status == 'success') {
                                    setState(() {
                                      _studentList = getdata();
                                    });
                                  }
                                },
                                child: Container(
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        // textDirection: TextDirection.LTR,
                                        children: [
                                          Image(
                                              height: 100,
                                              image: AssetImage(
                                                  'assets/pic1.png')),
                                          Column(
                                            children: [
                                              Text(studentData[index]
                                                      .firstName +
                                                  " " +
                                                  studentData[index].lastName),
                                              Text(" "),
                                              Text(studentData[index]
                                                  .nationalId),
                                              Text(
                                                'Status',
                                                style: TextStyle(
                                                    color: Colors.blue),
                                              )
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
                                "No Students Defined Yet",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          );
                        }

                        return Text("${snapshot.error}");
                      }
                      return CircularProgressIndicator();
                    }),
              ),
            ),
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    // initPlatformState();
    setState(() {
      dateText.text = date.toString();
      _studentList = getdata();
    });
  }
}

Future<void> initPlatformState() async {
  // If the widget was removed from the tree while the asynchronous platform
  // message was in flight, we want to discard the reply rather than calling
  // setState to update our non-existent appearance.
  // if (!mounted) return;
  Geofence.initialize();
  Geofence.requestPermissions();
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

  Geofence.getCurrentLocation().then((coordinate) {
    print(
        "Your latitude is ${coordinate.latitude} and longitude ${coordinate.longitude}");
  });
}

itemSelected(
    String schoolId,
    String id,
    String nationalId,
    String firstName,
    String lastName,
    String grade,
    String studentClass,
    BuildContext context) async {
  // Navigator.push(
  //   context,MaterialPageRoute(
  //     builder: (context) =>
  //       StudentProfile(firstName: firstName, lastName: lastName)));
  String status = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => UpdateStudentStatus(
            schoolId: schoolId,
            id: id,
            nationalId: nationalId,
            firstName: firstName,
            lastName: lastName,
            grade: grade,
            studentClass: studentClass,
          )));
  return status;
}
