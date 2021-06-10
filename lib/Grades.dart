import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddGrade.dart';
import 'dart:async';
import 'package:flutter_application_1/Navigation.dart';
import 'package:flutter_application_1/Grade.dart';
import 'package:flutter_application_1/StudentProfile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Grades extends StatefulWidget {
  Grades({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Grades> {
  Future<List<Grade>> _gradeList;

  Future<List<Grade>> getdata() async {
    List<Grade> gradeList = [];
    var response = await http.get(
        Uri.parse("https://sktest87.000webhostapp.com/loadgradesinfo.php"));
    if (response.statusCode == 200) {
      print("data loaded");

      print(response.body);

      var gradesJson = jsonDecode(response.body);
      for (var gradeJson in gradesJson) {
        gradeList.add(Grade.fromJson(gradeJson));
      }
      return gradeList;
    } else {
      throw Exception("failed to load");
    }
  }

  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Grades'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigation nav = new Navigation();
            nav.navigater(context, AddGrade());
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<Grade>>(
            future: _gradeList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Grade> gradeData = snapshot.data;
                return ListView.builder(
                    itemCount: gradeData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => itemSelected(
                            gradeData[index].englishDescription,
                            gradeData[index].arabicDescription,
                            context),
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
                                      Text(gradeData[index].englishDescription +
                                          " " +
                                          gradeData[index].arabicDescription),
                                      Text(" "),
                                      Text(gradeData[index].id),
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
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            }));
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      _gradeList = getdata();
    });
  }
}

void itemSelected(
    String englishDescription, String arabicDescription, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => StudentProfile(
          firstName: englishDescription, lastName: arabicDescription)));
}
