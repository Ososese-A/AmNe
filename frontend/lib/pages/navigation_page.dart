import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/pages/home_page.dart';
import 'package:frontend/pages/profile_page.dart';
import 'package:frontend/pages/stock_page.dart';
import 'package:frontend/pages/wallet_page.dart';
import 'package:frontend/themes/theme.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

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