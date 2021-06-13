import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddClass.dart';
import 'dart:async';
import 'package:flutter_application_1/Navigation.dart';
import 'package:flutter_application_1/Class.dart';
import 'package:flutter_application_1/StudentProfile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Classes extends StatefulWidget {
  Classes({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Classes> {
  Future<List<Class>> _classsList;

  Future<List<Class>> getdata() async {
    List<Class> classList = [];
    var response = await http.get(
        Uri.parse("https://sktest87.000webhostapp.com/loadClassesinfo.php"));
    if (response.statusCode == 200) {
      print("data loaded");

      print(response.body);

      var classesJson = jsonDecode(response.body);
      for (var gradeJson in classesJson) {
        classList.add(Class.fromJson(gradeJson));
      }
      return classList;
    } else {
      throw Exception("failed to load");
    }
  }

  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Classes'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigation nav = new Navigation();
            nav.navigater(context, AddClass());
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<Class>>(
            future: _classsList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Class> classData = snapshot.data;
                return ListView.builder(
                    itemCount: classData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => itemSelected(
                            classData[index].englishDescription,
                            classData[index].arabicDescription,
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
                                      Text(classData[index].englishDescription +
                                          " " +
                                          classData[index].arabicDescription),
                                      Text(" "),
                                      Text(classData[index].id),
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
      _classsList = getdata();
    });
  }
}

void itemSelected(
    String englishDescription, String arabicDescription, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => StudentProfile(
          firstName: englishDescription, lastName: arabicDescription)));
}
