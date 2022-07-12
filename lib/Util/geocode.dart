class geoCode {
  geoCode({this.name, required this.street, required this.country});

  String? name, street, country;

  factory geoCode.fromJson(Map<String, dynamic> json) => geoCode(
      name: json['Name'], street: json['Street'], country: json['Country']);
}
