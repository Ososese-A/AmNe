import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/stock_page.dart';
import 'package:frontend/pages/wallet_page.dart';
import 'package:frontend/themes/theme.dart';

class NavigationPage extends StatefulWidget {
  static Route route(int pageIndex) {
    return MaterialPageRoute(
      builder: (contex) => NavigationPage(pageFromprev: pageIndex),
      settings: RouteSettings(
        name: '/main',
        arguments: pageIndex
      )
    );
  }

  final int pageFromprev;
  const NavigationPage({
    super.key,
    this.pageFromprev = 0
  });

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,

      body: _pages[_selectedPage],

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