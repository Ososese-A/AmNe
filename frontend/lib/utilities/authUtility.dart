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

String getP () {
  final p = _con.get(3);
  return p;
}

void setU (u) {
  _con.put(1, u);
}

void setJ (j) {
  _con.put(2, j);
}

void setP (p) {
  _con.put(3, p);
}