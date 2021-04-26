import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation {
  void navigater(BuildContext context, Widget widget) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
  }
}
