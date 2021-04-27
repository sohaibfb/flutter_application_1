import 'package:flutter/material.dart';

class AddStudent extends StatefulWidget {
  AddStudent({Key key}) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<AddStudent> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('add student'),
        ),
        body: Form(
            key: _formkey,
            child: Padding(
                padding:
                    EdgeInsets.only(top: 8, left: 64, right: 64, bottom: 64),
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Id'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'First name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'M Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Last Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(labelText: 'National ID'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Grade'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Class'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          InputDecoration(labelText: 'Transportation Type'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Parent Name'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          icon: Icon(Icons.mobile_friendly_sharp),
                          labelText: 'Mobile'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          icon: Icon(Icons.mail), labelText: 'Email'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter id';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {}, child: Text('Add student')),
                  ],
                ))));
  }
}
