import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddClass extends StatefulWidget {
  final String id;
  AddClass({Key key, this.id}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<AddClass> {
  TextEditingController englishName = new TextEditingController();
  TextEditingController arabicName = new TextEditingController();

  Future<String> senddata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = ("https://sktest87.000webhostapp.com/addclass.php");
    var data = {
      //"id": id.text,
      "id": widget.id,
      "schoolid": prefs.get('schoolid'),
      "englishname": englishName.text,
      "arabicname": arabicName.text,
    };

    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print(response.body);
      Navigator.pop(context);
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
          title: Text('add class'),
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
                    ElevatedButton(
                        onPressed: () {
                          print("pressed");
                          //if (_formkey.currentState.validate()) {
                          senddata();
                          // } else {}
                        },
                        child: Text('Add class')),
                  ],
                ))));
  }
}
