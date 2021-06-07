class Student {
  final String id;
  final String firstName;
  final String lastName;
  final String nationalId;
  final String grade;
  final String studentClass;

  Student(
      {this.id,
      this.firstName,
      this.lastName,
      this.nationalId,
      this.grade,
      this.studentClass});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        id: json['id'],
        firstName: json['First_Name'],
        lastName: json['last_Name'],
        nationalId: json['national_Id'],
        grade: json['Grade'],
        studentClass: json['Class']);
  }
}
