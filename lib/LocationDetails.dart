import 'package:flutter/material.dart';

class LocationDetails extends StatefulWidget {
  final String name;
  final String latitude;
  final String longitude;
  final String radius;

  const LocationDetails({
    Key key,
    this.name,
    this.latitude,
    this.longitude,
    this.radius,
  }) : super(key: key);

  @override
  _NameState createState() => _NameState();
}

class _NameState extends State<LocationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Location Details"),
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
                      widget.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Radius: ' + widget.radius.toString(),
                      style: TextStyle(color: Colors.blue),
                    ),
                    Text('Latitude: ' + widget.latitude.toString()),
                    Text('Longitude: ' + widget.longitude.toString()),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
