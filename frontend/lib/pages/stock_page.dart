import 'package:flutter/material.dart';
import 'package:frontend/add_ons/empty_msg.dart';
import 'package:frontend/add_ons/main_app_bar.dart';
import 'package:frontend/components/currency_badge.dart';
import 'package:frontend/components/search_bar.dart';
import 'package:frontend/themes/theme.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: main_app_bar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stock List",
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 32.0
                  ),
                ),

                CurrencyBadge(text: "NGN")
              ],
            ),

            SizedBox(height: 28.0,),

            StockSearch(
              controller: _searchController, 
              placeHolder: "Search for a stock", 
              onTap: () {}
            ),

            SizedBox(height: 24.0,),

            Center(
              child: Text(
                "Market Closed",
                style: TextStyle(
                  color: customColors.app_red,
                  fontSize: 16.0
                ),
              ),
            ),

            SizedBox(height: 72.0,),

            empty_msg("assets/images/stock_not_found_a.svg", "Stock Not Found")
          ],
        ),
      )
    );
  }
}