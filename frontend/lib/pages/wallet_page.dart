import 'package:flutter/material.dart';
import 'package:frontend/add_ons/badge_btn.dart';
import 'package:frontend/add_ons/empty_msg.dart';
import 'package:frontend/add_ons/main_app_bar.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/components/currency_badge.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/themes/theme.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: main_app_bar(context),
      body: Column(
        children: [
          MainCard(
            firstLine: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CurrencyBadge(text: "NGN"),
                Container(
                  width: 64.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      svg_box(16.0, 16.0, 'assets/icons/filter.svg'),
                      svg_box(16.0, 16.0, 'assets/icons/obscure.svg'),
                    ],
                  ),
                )
              ],
            ),
            secondLine: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "0.0000 ETN", 
                      style: TextStyle(
                        color: customColors.app_white, 
                        fontSize: 24.0
                      ),
                    ),

                    Text(
                      "₦0.00",
                      style: TextStyle(
                        fontSize: 16.0, 
                        color:  customColors.app_white
                      ),
                    ),
                  ],
                )
              ],
            ),
            thirdLine: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                badge_btn("Withdraw"),
                badge_btn("Fund"),

                GestureDetector(
                  child: Container(
                    child: Row(
                      children: [
                        Text(
                          "Copy Wallet \naddress",
                          style: TextStyle(
                            color: customColors.app_white,
                            fontSize: 12.0
                          ),
                        ),

                        SizedBox(width: 8.0,),

                        svg_box(24.0, 24.0, "assets/icons/copy.svg")
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 80.0,),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Transaction History",
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 20.0
                      ),
                    ),

                    SizedBox(height: 20.0,),

                    Text(
                      "",
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 20.0
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.0,),

                empty_msg("assets/images/empty_transactions_a.svg", "You currently have no recorded transactions")
              ],
            ),
          )
        ],
      )
    );
  }
}