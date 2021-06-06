class Student {
  final String id;
  final String firstName;
  final String lastName;

  Student({this.id, this.firstName, this.lastName});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'],
        firstName: json['First_Name'],
        lastName: json['last_Name']);
  }
}
