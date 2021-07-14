class Student {
  final String schoolId;
  final String id;
  final String firstName;
  final String lastName;
  final String nationalId;
  final String grade;
  final String studentClass;

  Student(
      {this.schoolId,
      this.id,
      this.firstName,
      this.lastName,
      this.nationalId,
      this.grade,
      this.studentClass});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
        schoolId: json['School_Id'],
        id: json['Id'],
        firstName: json['First_Name'],
        lastName: json['Last_Name'],
        nationalId: json['National_Id'],
        grade: json['Grade'],
        studentClass: json['Class']);
  }
}
