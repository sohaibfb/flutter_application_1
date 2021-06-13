class Class {
  final String id;
  final String englishDescription;
  final String arabicDescription;

  Class({
    this.id,
    this.englishDescription,
    this.arabicDescription,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      englishDescription: json['English_Name'],
      arabicDescription: json['Arabic_Name'],
    );
  }
}
