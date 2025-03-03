import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/stock_page.dart';
import 'package:frontend/pages/wallet_page.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';

class NavigationPage extends StatefulWidget {
  final int pageFromprev;
  var balance;
  var address;
  NavigationPage({
    super.key,
    this.pageFromprev = 0,
    this.balance = '0',
    this.address ='address'
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
    _getWalletInfo();
  }

  void _getWalletInfo() async {
    setState(() {
      isLoading = true;
    });

    final backendResponse = await getWallet(type: 'wallet');
    print('This is home page backend response');
    print(backendResponse);

    setState(() {
      isLoading = false;
      widget.balance = backendResponse['balance'];
      widget.address = backendResponse['address'];
    });
    setAS(true);
  }

double balanceValue () {
  double val = 0;
  return val;
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