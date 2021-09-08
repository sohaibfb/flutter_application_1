import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdateStudentStatus extends StatefulWidget {
  final String id;
  final String nationalId;
  final String schoolId;
  final String firstName;
  final String lastName;
  final String grade;
  final String studentClass;

  const UpdateStudentStatus(
      {Key key,
      this.id,
      this.nationalId,
      this.schoolId,
      this.firstName,
      this.lastName,
      this.grade,
      this.studentClass})
      : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<UpdateStudentStatus> {
  Future<String> updatedata(String type) async {
    String moveType;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (type == "school") {
      moveType = '1';
      print('movetype: ' + moveType);
      print('id: ' + widget.id);
      print('schoolID: ' + widget.schoolId);
      print('date: ' + DateTime.now().toString());
    } else {
      moveType = '2';
    }
    String url = ("https://sktest87.000webhostapp.com/updatestudentstatus.php");
    var data = {
      "schoolid": widget.schoolId,
      //"username": prefs.get('username'),
      "id": widget.id,
      "type": moveType,
      "date": DateTime.now().toString(),
    };

    try {
      var response = await http.post(Uri.parse(url), body: data);
      if (response.statusCode == 200) {
        print(response.body);
        if (response.body.trim() == 'data updated successfully')
          Navigator.pop(context, 'success');
      } else {
        print("network error");
      }
    } catch (e) {
      print(e);
    }
    return 'success';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Student Profile"),
        ),
        body: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Card(
                  child:
                      Image(height: 100, image: AssetImage('assets/pic1.png')),
                ),
                Column(
                  children: [
                    Text("  "),
                    Text(
                      widget.firstName + "  " + widget.lastName,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'ID#' + widget.nationalId,
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text('Grade: ' + widget.grade),
                    Text('Class: ' + widget.studentClass),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            updatedata("school");
                          },
                          child: Text('move to school')),
                      Divider(),
                      ElevatedButton(
                          onPressed: () {
                            updatedata('bus');
                          },
                          child: Text('move to bus'))
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
