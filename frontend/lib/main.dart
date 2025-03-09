import 'package:flutter/material.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/model/historyModel.dart';
import 'package:frontend/notifiers/account_setup_notifier.dart';
import 'package:frontend/notifiers/currency_notifier.dart';
import 'package:frontend/notifiers/obscure_notifier.dart';
import 'package:frontend/pages/about_page.dart';
import 'package:frontend/pages/account_setup_page.dart';
import 'package:frontend/pages/account_setup_page_three.dart';
import 'package:frontend/pages/account_setup_page_two.dart';
import 'package:frontend/pages/auth_page.dart';
import 'package:frontend/pages/buy_stock_page.dart';
import 'package:frontend/pages/confirm_pin_page.dart';
import 'package:frontend/pages/contact_us_page.dart';
import 'package:frontend/pages/enter_pin_page.dart';
import 'package:frontend/pages/faq_page.dart';
import 'package:frontend/pages/forgot_password_page_one.dart';
import 'package:frontend/pages/forgot_password_page_two.dart';
import 'package:frontend/pages/get_help_page.dart';
import 'package:frontend/pages/intro_page.dart';
import 'package:frontend/pages/kyc_upload_page.dart';
import 'package:frontend/pages/login_page.dart';
import 'package:frontend/pages/my_stats_page.dart';
import 'package:frontend/pages/navigation_page.dart';
import 'package:frontend/pages/order_confirm_page.dart';
import 'package:frontend/pages/order_detail_page.dart';
import 'package:frontend/pages/pin_page.dart';
import 'package:frontend/pages/portfolio_page.dart';
import 'package:frontend/pages/profile_edit_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/refer_a_friend_page.dart';
import 'package:frontend/pages/reset_password_page_one.dart';
import 'package:frontend/pages/reset_password_page_three.dart';
import 'package:frontend/pages/reset_password_page_two.dart';
import 'package:frontend/pages/reset_pin_page_one.dart';
import 'package:frontend/pages/reset_pin_page_three.dart';
import 'package:frontend/pages/reset_pin_page_two.dart';
import 'package:frontend/pages/sell_stock_page.dart';
import 'package:frontend/pages/signup_page.dart';
import 'package:frontend/pages/stock_info_page.dart';
import 'package:frontend/pages/stock_page.dart';
import 'package:frontend/pages/transaction_detail_page.dart';
import 'package:frontend/pages/transaction_history_page.dart';
import 'package:frontend/pages/transaction_successful_page.dart';
import 'package:frontend/pages/transaction_view_page.dart';
import 'package:frontend/pages/withdraw_page_one.dart';
import 'package:frontend/pages/withdraw_page_two.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

void main() async {
  //hive setup box
  await Hive.initFlutter();

  var con = await Hive.openBox('dis');
  con.get(1);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Walletmodel()),
        ChangeNotifierProvider(create: (context) => CurrencyNotifier()),
        ChangeNotifierProvider(create: (context) => isAccountSetUpNotifier()),
        ChangeNotifierProvider(create: (context) => HistoryModel()),
        ChangeNotifierProvider(create: (context) => ObscureNotifier()),
        ChangeNotifierProvider(create: (context) => Accountmodel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Comfortaa'),
      // home: NavigationPage(),
      // home: IntroPage(),
      // home: LoginPage(),
      // home: KycUploadPage(),
      // home: SignupPage(),
      // home: AuthPage(),
      // home: PinPage(),
      // home: BuyStockPage(),
      // home: StockInfoPage(),
      // initialRoute: '/main',
      initialRoute: '/intro',
      routes: {
        '/intro' : (context) => IntroPage(),
        '/auth': (context) => AuthPage(),
        '/signup' : (context) => SignupPage(),
        '/login' : (context) => LoginPage(),
        '/forgotPasswordOne' : (context) => ForgotPasswordPageOne(),
        '/forgotPasswordTwo' : (context) => ForgotPasswordPageTwo(),
        '/pin': (context) => PinPage(),
        '/cpin': (context) => ConfirmPinPage(),
        '/epin': (context) => EnterPinPage(),
        '/main' : (context) => NavigationPage(),
        '/portfolio' : (context) => PortfolioPage(),
        '/profile': (context) => ProfilePage(),
        '/stock': (context) => StockPage(),
        '/stockInfo': (context) => StockInfoPage(),
        '/buy': (context) => BuyStockPage(),
        '/sell': (context) => SellStockPage(),
        '/orderDetails': (context) => OrderDetailPage(),
        '/orderConfirmed': (context) => OrderConfirmPage(),
        '/history': (context) => TransactionHistoryPage(),
        '/viewTransaction': (context) => TransactionViewPage(),
        '/withdrawOne': (context) => WithdrawPageOne(),
        '/withdrawTwo': (context) => WithdrawPageTwo(),
        '/transactionDetail': (context) => TransactionDetailPage(),
        '/transactionSuccess': (context) => TransactionSuccessfulPage(),
        '/accountSetup': (context) => AccountSetupPage(),
        '/accountSetupTwo': (context) => AccountSetupPageTwo(),
        '/accountSetupThree': (context) => AccountSetupPageThree(),
        '/kycUpload': (context) => KycUploadPage(),
        '/profileEdit': (context) => ProfileEditPage(),
        '/referral': (context) => ReferAFriendPage(),
        '/gethelp': (context) => GetHelpPage(),
        '/faq': (context) => FaqPage(),
        '/contact': (context) => ContactUsPage(),
        '/stats': (context) => MyStatsPage(),
        '/about': (context) => AboutPage(),
        '/resetPinOne': (context) => ResetPinPageOne(),
        '/resetPinTwo': (context) => ResetPinPageTwo(),
        '/resetPinThree': (context) => ResetPinPageThree(),
        '/resetPasswordOne': (context) => ResetPasswordPageOne(),
        '/resetPasswordTwo': (context) => ResetPasswordPageTwo(),
        '/resetPasswordThree': (context) => ResetPasswordPageThree(),
      },
    );
  }
}