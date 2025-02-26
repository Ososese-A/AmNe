import 'package:flutter/material.dart';

void nextPage (BuildContext ctx, String route) {
    Navigator.popAndPushNamed(ctx, route);
}

void next (BuildContext ctx, String route) {
  Navigator.pushNamed(ctx, route);
}

// void setMainPage(BuildContext ctx, String route) {
//   Navigator.pushNamedAndRemoveUntil(
//     ctx,
//     route,
//     (Route<dynamic> route) => false,
//   );
// }

void setMainPage(BuildContext ctx, String route, String singleRouteToKeep) {
  Navigator.pushNamedAndRemoveUntil(
    ctx,
    route,
    ModalRoute.withName(singleRouteToKeep),
  );
}

void setMainPageWithData(BuildContext ctx, String route, String singleRouteToKeep, data) {
  Navigator.pushNamedAndRemoveUntil(
    ctx,
    route,
    arguments: data,
    ModalRoute.withName(singleRouteToKeep),
  );
}

void nextWithData (BuildContext ctx, String route, data) {
  Navigator.pushNamed(
    ctx,
    route,
    arguments: data,
  );
}