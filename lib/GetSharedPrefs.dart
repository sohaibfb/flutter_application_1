import 'package:shared_preferences/shared_preferences.dart';

class GetSharedPrefs {
  getsharedpreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }
}
