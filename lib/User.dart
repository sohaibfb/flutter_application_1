class User {
  final String schoolID;
  final String username;
  final String password;
  final String token;

  User({this.schoolID, this.username, this.password, this.token});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      schoolID: json['schoolID'],
      username: json['username'],
      password: json['password'],
      token: json['token'],
    );
  }
}
