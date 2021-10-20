class Location {
  final String id;
  final String serialCode;
  final String englishDescription;
  final String arabicDescription;
  final String latitude;
  final String longitude;
  final String radius;

  Location(
      {this.id,
      this.serialCode,
      this.englishDescription,
      this.arabicDescription,
      this.latitude,
      this.longitude,
      this.radius});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
        id: json['id'],
        serialCode: json['Serial_Code'],
        englishDescription: json['English_Name'],
        arabicDescription: json['Arabic_Name'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        radius: json['radius']);
  }
}
