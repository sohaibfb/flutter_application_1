import 'package:flutter/material.dart';
import 'package:flutter_application_1/AddUser.dart';
import 'package:flutter_application_1/Classes.dart';
import 'dart:async';
import 'package:flutter_application_1/Navigation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'User.dart';

class Users extends StatefulWidget {
  Users({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<Users> {
  Future<List<User>> _userList;

  Future<List<User>> getdata() async {
    List<User> userList = [];
    var response = await http
        .get(Uri.parse("https://sktest87.000webhostapp.com/loadusersinfo.php"));
    if (response.statusCode == 200) {
      print("data loaded");

      print(response.body);

      var usersJson = jsonDecode(response.body);
      for (var userJson in usersJson) {
        userList.add(User.fromJson(userJson));
      }
      return userList;
    } else {
      throw Exception("failed to load");
    }
  }

  //final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Users'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String status = await Navigation().navigater(context, AddUser());
            if (status == 'success') {
              setState(() {
                _userList = getdata();
              });
            }
          },
          child: Icon(Icons.add),
        ),
        body: FutureBuilder<List<User>>(
            future: _userList,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<User> gradeData = snapshot.data;
                return ListView.builder(
                    itemCount: gradeData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () =>
                            itemSelected(gradeData[index].username, context),
                        child: Container(
                            child:
                                Card(child: Text(gradeData[index].username))),
                      );
                    });
              } else if (snapshot.hasError) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                      child: Text(
                        "No Users Defined Yet",
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
      _userList = getdata();
    });
  }
}

void itemSelected(String serialCode, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Classes(
            serialCode: serialCode,
          )));
}
