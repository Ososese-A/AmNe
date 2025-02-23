import 'package:flutter/material.dart';

void nextPage (context, String route) {
    Navigator.popAndPushNamed(context, route);
}

void next (context, String route) {
  Navigator.pushNamed(context, route);
}