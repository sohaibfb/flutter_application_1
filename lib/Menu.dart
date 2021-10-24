import 'package:badges/badges.dart';

class Menu {
  static const String Profile = "Profile";
  static const String settings_students = "students";
  static const String settings_accounts_and_permissions =
      "Accounts and Permissions";
  static const String settings_grades_and_classes = "grades and classes";
  static const String settings_save_option = "save";
  static const String settings_preferences = "preferences";
  static const String settings_dashboards = "Dashboards";
  static const String settings_parents = "Parents";
  static const String settings_parents_pending_requests = "Pending Requests";
  static const String settings_trans_type_parent = "parents";
  static const String settings_trans_type_bus = "Bus";
  static const String settings_trans_type_walking = "Walking";
  static const String settings_admin = "Admin";
  static const String settings_signout = "Sign Out";
  static const String settings_notification = "notifications";
  static const String settings_transactions = "transactions";
  static const String settings_location = "location";

  static const List<String> adminMenuChoice = <String>[
    Profile,
    settings_students,
    settings_grades_and_classes,
    settings_accounts_and_permissions,
    settings_preferences,
    settings_transactions,
    settings_location,
    settings_dashboards,
    settings_signout,
  ];

  static const List<String> accountMenuChoice = <String>[
    settings_admin,
    settings_parents_pending_requests,
    settings_students,
    settings_signout,
  ];
}
