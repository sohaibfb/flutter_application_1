class Grade {
  final String id;
  final String serialCode;
  final String englishDescription;
  final String arabicDescription;

  Grade({
    this.id,
    this.serialCode,
    this.englishDescription,
    this.arabicDescription,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      serialCode: json['Serial_Code'],
      englishDescription: json['English_Name'],
      arabicDescription: json['Arabic_Name'],
    );
  }
}
