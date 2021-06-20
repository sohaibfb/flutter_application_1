import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation {
  navigater(BuildContext context, Widget widget) async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => widget));
    return result;
  }
}
