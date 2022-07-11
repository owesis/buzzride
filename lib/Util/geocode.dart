class geoCode {
  geoCode({this.name, required this.street, required this.country});

  String? name, street, country;

  factory geoCode.fromJson(Map<String, dynamic> json) {
    return geoCode(
        name: json['name'], street: json['street'], country: json['country']);
  }
}
