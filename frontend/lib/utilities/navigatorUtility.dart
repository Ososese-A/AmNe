import 'package:flutter/material.dart';
import 'package:frontend/pages/navigation_page.dart';

void nextPage (BuildContext ctx, String route) {
    Navigator.popAndPushNamed(ctx, route);
}

void next (BuildContext ctx, String route) {
  Navigator.pushNamed(ctx, route);
}

// bool _isNavigating = false;

// void next(BuildContext ctx, String route) {
//   if (!_isNavigating) {
//     _isNavigating = true;
//     Navigator.pushNamed(ctx, route).then((_) {
//       _isNavigating = false;
//     });
//   }
// }


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

// void setMainPageWithData(BuildContext ctx, String route, String singleRouteToKeep, data) {
//   Navigator.pushNamedAndRemoveUntil(
//     ctx,
//     route,
//     arguments: data,
//     ModalRoute.withName(singleRouteToKeep),
//   );
// }

void setMainPageWithData(BuildContext ctx, String route, String singleRouteToKeep, dynamic data) {
  Navigator.pushNamedAndRemoveUntil(
    ctx,
    route,
    (route) => route.settings.name == singleRouteToKeep,
    arguments: data, 
  );
}

void setMainAsMainPageWithData(BuildContext ctx, int data) {
  Navigator.of(ctx).pushAndRemoveUntil(
    NavigationPage.route(data),
    ModalRoute.withName('/main')
  );
}

void nextWithData (BuildContext ctx, String route, data) {
  Navigator.pushNamed(
    ctx,
    route,
    arguments: data,
  );
}

void nextNavPageWithData(BuildContext ctx, int data) {
  Navigator.of(ctx).push(
    NavigationPage.route(data),
  );
}