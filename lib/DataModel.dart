import 'package:flutter/material.dart';

class DataModel extends ChangeNotifier {
  void updateHomepage() {
    notifyListeners();
  }
}
