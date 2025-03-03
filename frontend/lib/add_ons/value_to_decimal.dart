import 'package:intl/intl.dart';

String value_to_delimal ({required double value, required bool type}) {
  String res = type ? NumberFormat('#,##0.0000').format(value) : NumberFormat('#,##0.00').format(value);
  return res;
}