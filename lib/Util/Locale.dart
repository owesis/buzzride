import 'package:buzzride/Util/Locale/English.dart';
import 'package:buzzride/Util/Locale/Swahili.dart';

class OLocale {
  OLocale(
    this.swahili,
    this.key,
  ) : super();
  final bool swahili;
  final int key;
  String get() {
    return swahili ? Swahili(key).words() : English(key).words();
  }
}
