import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/model/historyModel.dart';
import 'package:frontend/notifiers/account_setup_notifier.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/stock_page.dart';
import 'package:frontend/pages/wallet_page.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class NavigationPage extends StatefulWidget {
  final int pageFromprev;
  NavigationPage({
    super.key,
    this.pageFromprev = 0,
  });

  static Route route(int pageIndex) {
    return MaterialPageRoute(
      builder: (context) => NavigationPage(pageFromprev: pageIndex),
      settings: RouteSettings(
        name: '/main',
        arguments: pageIndex
      )
    );
  }

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  bool isLoading = false;
  int _selectedPage = 0;

  final List _pages = [
    HomePage(),
    WalletPage(),
    StockPage(),
    ProfilePage()
  ];

  void _pageSelector (int index) {
    print("Button index $index");
    setState(() {
      _selectedPage = index;

      // WidgetsBinding.instance.addPostFrameCallback((_) {
      //   _getWalletInfo(Provider.of<Walletmodel>(context, listen: false), Provider.of<HistoryModel>(context, listen: false));
      // });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _selectedPage = widget.pageFromprev;
    setState(() {
      _selectedPage = widget.pageFromprev;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getWalletInfo(Provider.of<Walletmodel>(context, listen: false), Provider.of<HistoryModel>(context, listen: false));
    });
  }

  void _setAccountSetupState (bool newisAccountSetUp) {
    Provider.of<isAccountSetUpNotifier>(context, listen: false).setAccountSetUpState(newisAccountSetUp);
  }
  
  void _getWalletInfo(Walletmodel walletModel, HistoryModel historyModel) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });


  final backendResponse = await getWallet(type: 'wallet');

  if (backendResponse["isThereError"]) {
    return pop_up(
      ctx: context,
      txt: backendResponse["error"],
      primaryBtn: true,
      primaryBtnTxt: "Retry",
      primaryBtnOnTap: () => next(context, '/epin'),
    );
  } else {
      if (!(backendResponse["isAccountSetUp"])) {
        final isAccountSetUpState = backendResponse["isAccountSetUp"];
        print("This is the account setup state from navigation page");
        print(isAccountSetUpState);

        _setAccountSetupState(isAccountSetUpState);
        final rate = 0.0;
        final etnValue = 0.0;
        final toNaira = rate * etnValue;
        final toDollars = etnValue;

        walletModel.updateWalletInfo(
          newAddress: "User's Wallet Address", 
          newBalance: 0, 
          newBalanceInNaira: toNaira, 
          newBalanceInDollars: toDollars,
          newRate: rate,
          newEtenValue: etnValue
        );

          setState(() {
            isLoading = false;
          });

          return pop_up(
            ctx: context,
            txt: "Welcome to our platform! 🚀 To unlock all the exciting features and benefits we offer, please take a moment to set up your account. It's quick, easy, and will ensure you get the best experience possible.",
            primaryBtn: true,
            primaryBtnTxt: "Setup Account",
            primaryBtnOnTap: () => next(context, "/accountSetup"),
          );
      } else {
        _setAccountSetupState(true);
        print('This is home page backend response');
        print(backendResponse);
        print("This si the rate from the backendresponse");
        print(backendResponse['rate']);

        print("This is the financials info");
        print(backendResponse["financialsinfo"]);

        print("This is the transaction history");
        print(backendResponse["financialsinfo"]["transactionHistory"]);

        
        print("This is the order history");
        print(backendResponse["financialsinfo"]["orderHistory"]);

        print("This is the portfolio");
        print(backendResponse["financialsinfo"]["portfolio"]);

        final rate = backendResponse['rate'] + 0.0;
        final etnValue = backendResponse['etnValue'] + 0.0;
        final toNaira = rate * etnValue;
        final toDollars = etnValue;

        walletModel.updateWalletInfo(
          newAddress: backendResponse['address'], 
          newBalance: backendResponse['balance'], 
          newBalanceInNaira: toNaira, 
          newBalanceInDollars: toDollars,
          newRate: rate,
          newEtenValue: etnValue
        );

        historyModel.updateHistoryInfo(
          newTransactionHistory: backendResponse["financialsinfo"]["transactionHistory"],
          newOrderHistory: backendResponse["financialsinfo"]["orderHistory"],
          newPortfolio: backendResponse["financialsinfo"]["portfolio"],
        );

        setState(() {
          isLoading = false;
        });

        //pop up for beta version
        pop_up(
          ctx: context, 
          txt: "Welcome to our beta mode! 🚀Please note that during this phase, you can only transact with test Electroneum (ETN). Avoid depositing or transacting with real Electroneum as it won't be processed.Thank you for your understanding and participation!",
          primaryBtn: true,
          primaryBtnTxt: "Got it",
          primaryBtnOnTap: () {},
          minor: true
          );
      }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,

      body: Stack(
        children: [
           _pages[_selectedPage],

           if (isLoading)
          loading_spinner()
        ],
      ),

      bottomNavigationBar: CurvedNavigationBar(
        index: _selectedPage,
        backgroundColor: customColors.app_black,
        color: customColors.app_neutral,
        height: 75.0,
        buttonBackgroundColor: customColors.app_light_a,
        animationDuration: Duration(milliseconds: 300),
        items: [
          Container(
            child: _selectedPage == 0 ? svg_box(24.0, 24.0, "assets/icons/home_active.svg") : svg_box(26.0, 24.0, "assets/icons/home_normal.svg"),
          ),
          Container(
            child: _selectedPage == 1 ? svg_box(24.0, 32.0, "assets/icons/wallet_active.svg") : svg_box(28.0, 34.0, "assets/icons/wallet_normal.svg"),
          ),
          Container(
            child: _selectedPage == 2 ? svg_box(24.0, 28.0, "assets/icons/stock_active.svg") : svg_box(26.0, 34.0, "assets/icons/stock_normal.svg"),
          ),

          Container(
            child: _selectedPage == 3 ? svg_box(24.0, 20.0, "assets/icons/profile_active.svg") : svg_box(32.0, 24.0, "assets/icons/profile_normal.svg"),
          )
        ],
        onTap: (index) {
          _pageSelector(index);
        },
      ),
    );
  }
}