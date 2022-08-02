extension Capitalize on String {
  String get capitalize => '${this[0].toUpperCase()}${substring(1)}';

  String get allInCaps => toUpperCase();

  String get capitalizeFirstOfEach =>
      split(" ").map((str) => str.capitalize).join(" ");

  bool get isNumOnly {
    RegExp regex = RegExp('[0-9]');
    return regex.hasMatch(this);
  }

  DateTime get toDateTime {
    try {
      return DateTime.parse(this);
    } catch (e) {
      print(e);
      return DateTime.now();
    }
  }

  int toInt() {
    try {
      return int.parse(this);
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
