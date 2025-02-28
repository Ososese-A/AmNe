import 'package:hive/hive.dart';

final _con = Hive.box('dis');

String getCur () {
  final cur = _con.get(4);
  return cur;
}

void setCur (cur) {
  _con.put(4, cur);
}