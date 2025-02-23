import 'package:flutter/material.dart';
import 'package:frontend/pages/auth_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/intro_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/pin_page.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  //hive setup box
  await Hive.initFlutter();

  var con = await Hive.openBox('dis');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Comfortaa'),
      home: IntroPage(),
      routes: {
        '/home' : (context) => HomePage(),
        '/login' : (context) => LoginPage(),
        '/signup' : (context) => SignupPage(),
        '/intro' : (context) => IntroPage(),
        '/auth': (context) => AuthPage(),
        '/pin': (context) => PinPage()
      },
    );
  }
}