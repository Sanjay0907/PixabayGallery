import 'package:intl/intl.dart';

class CommonFunctions{
  static getShortForm(var number) {
  var f = NumberFormat.compact(locale: "en_US");
  return f.format(number);
}
}