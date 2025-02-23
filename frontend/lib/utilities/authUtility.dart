import 'package:hive/hive.dart';

final _con = Hive.box('dis');

String getU () {
  final u = _con.get(1);
  return u;
}

String getJ () {
  final j = _con.get(2);
  return j;
}

void setU (u) {
  _con.put(1, u);
}

void setJ (j) {
  _con.put(2, j);
}