import 'package:flutter/material.dart';
import 'package:frontend/pages/account_setup_page.dart';
import 'package:frontend/pages/auth_page.dart';
import 'package:frontend/pages/confirm_pin_page.dart';
import 'package:frontend/pages/enter_pin_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/intro_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/navigation_page.dart';
import 'package:frontend/pages/pin_page.dart';
import 'package:frontend/pages/profile_edit_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:frontend/pages/stock_page.dart';
import 'package:frontend/pages/wallet_page.dart';
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
      home: NavigationPage(),
      // home: HomePage(),
      // home: IntroPage(),
      // home: PinPage(),
      routes: {
        '/intro' : (context) => IntroPage(),
        '/auth': (context) => AuthPage(),
        '/signup' : (context) => SignupPage(),
        '/login' : (context) => LoginPage(),
        '/pin': (context) => PinPage(),
        '/cpin': (context) => ConfirmPinPage(),
        '/epin': (context) => EnterPinPage(),
        '/main' : (context) => NavigationPage(),
        '/home' : (context) => HomePage(),
        '/profile': (context) => ProfilePage(),
        '/stock': (context) => StockPage(),
        '/wallet': (context) => WalletPage(),
        '/accountSetup': (context) => AccountSetupPage(),
        '/profileEdit': (context) => ProfileEditPage(),
      },
    );
  }
}