class Class {
  final String id;
  final String serialCode;
  final String englishDescription;
  final String arabicDescription;

  Class({
    this.id,
    this.serialCode,
    this.englishDescription,
    this.arabicDescription,
  });

  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'],
      serialCode: json['Serial_Code'],
      englishDescription: json['English_Name'],
      arabicDescription: json['Arabic_Name'],
    );
  }
}
