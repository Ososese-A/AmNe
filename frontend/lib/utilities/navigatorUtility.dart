import 'package:flutter/material.dart';

void nextPage (BuildContext context, String route) {
    Navigator.popAndPushNamed(context, route);
}

void next (BuildContext context, String route) {
  Navigator.pushNamed(context, route);
}

void setMainPage(BuildContext context, String route) {
  Navigator.pushNamedAndRemoveUntil(
    context,
    route,
    (Route<dynamic> route) => false, // Remove all previous routes
  );
}