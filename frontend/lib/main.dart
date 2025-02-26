import 'package:flutter/material.dart';
import 'package:frontend/pages/account_setup_page.dart';
import 'package:frontend/pages/auth_page.dart';
import 'package:frontend/pages/buy_stock_page.dart';
import 'package:frontend/pages/confirm_pin_page.dart';
import 'package:frontend/pages/enter_pin_page.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/intro_page.dart';
import 'package:frontend/pages/kyc_upload_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/navigation_page.dart';
import 'package:frontend/pages/order_confirm_page.dart';
import 'package:frontend/pages/order_detail_page.dart';
import 'package:frontend/pages/pin_page.dart';
import 'package:frontend/pages/portfolio_page.dart';
import 'package:frontend/pages/profile_edit_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/sell_stock_page.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:frontend/pages/stock_info_page.dart';
import 'package:frontend/pages/stock_page.dart';
import 'package:frontend/pages/transaction_detail_page.dart';
import 'package:frontend/pages/wallet_page.dart';
import 'package:frontend/pages/withdraw_page_one.dart';
import 'package:frontend/pages/withdraw_page_two.dart';
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Comfortaa'),
      // home: NavigationPage(),
      // home: HomePage(),
      // home: IntroPage(),
      // home: PinPage(),
      // home: BuyStockPage(),
      // home: StockInfoPage(),
      // initialRoute: '/main',
      initialRoute: '/pin',
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
        '/portfolio' : (context) => PortfolioPage(),
        '/profile': (context) => ProfilePage(),
        '/stock': (context) => StockPage(),
        '/stockInfo': (context) => StockInfoPage(),
        '/buy': (context) => BuyStockPage(),
        '/sell': (context) => SellStockPage(),
        '/orderDetails': (context) => OrderDetailPage(),
        '/orderConfirmed': (context) => OrderConfirmPage(),
        '/wallet': (context) => WalletPage(),
        '/withdrawOne': (context) => WithdrawPageOne(),
        '/withdrawTwo': (context) => WithdrawPageTwo(),
        '/transactionDetail': (context) => TransactionDetailPage(),
        '/accountSetup': (context) => AccountSetupPage(),
        '/kycUpload': (context) => KycUploadPage(),
        '/profileEdit': (context) => ProfileEditPage(),
      },
    );
  }
}