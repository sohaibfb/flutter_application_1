class Grade {
  final String id;
  final String englishDescription;
  final String arabicDescription;

  Grade({
    this.id,
    this.englishDescription,
    this.arabicDescription,
  });

  factory Grade.fromJson(Map<String, dynamic> json) {
    return Grade(
      id: json['id'],
      englishDescription: json['English_Name'],
      arabicDescription: json['Arabic_Name'],
    );
  }
}
