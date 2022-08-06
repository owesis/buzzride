class Swahili {
  Swahili(
    this.key,
  );

  final int key;
  List dictionary = [
    "BuzzRide",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "Badili lugha",
    "",
    ""
  ];

  words() {
    return dictionary[key];
  }
}
