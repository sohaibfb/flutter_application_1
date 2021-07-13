import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ApproveParentPendingRequest extends StatefulWidget {
  final String schoolId;
  final String firstName;
  final String lastName;
  final String nationalId;
  final String grade;
  final String studentClass;

  const ApproveParentPendingRequest(
      {Key key,
      this.schoolId,
      this.firstName,
      this.lastName,
      this.nationalId,
      this.grade,
      this.studentClass})
      : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<ApproveParentPendingRequest> {
  Future<String> updatedata() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String url = ("https://sktest87.000webhostapp.com/updatestudentstatus.php");
    var data = {
      "schoolid": prefs.get('schoolid'),
      "username": prefs.get('username'),
      "nationalid": widget.nationalId,
    };

    var response = await http.post(Uri.parse(url), body: data);
    if (response.statusCode == 200) {
      print(response.body);
      if (response.body.trim() == 'data updated successfully')
        Navigator.pop(context, 'success');
    } else {
      print("network error");
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
                ElevatedButton(
                    onPressed: () {
                      updatedata();
                    },
                    child: Text('confirm'))
              ],
            ),
          ),
        ));

    throw UnimplementedError();
  }
}
