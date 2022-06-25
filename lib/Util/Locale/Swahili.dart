class Swahili {
  Swahili(
    this.key,
  );

  final int key;
  List dictionary = [
    "Zali",
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
