import 'package:flutter/material.dart';
import 'package:frontend/add_ons/borderless_btn.dart';
import 'package:frontend/add_ons/empty_msg.dart';
import 'package:frontend/add_ons/main_app_bar.dart';
import 'package:frontend/add_ons/stock_box.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool isAccountSetUp = false;
  final bool isStockMoreThanFour =false;


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
                Text("Account", style: TextStyle(color: customColors.app_white, fontSize: 16.0),),
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
                Text("0.0000 ETN", style: TextStyle(color: customColors.app_white, fontSize: 24.0),)
              ],
            ),
            thirdLine: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "₦0.00",
                  style: TextStyle(fontSize: 16.0, color:  customColors.app_white),
                ),
                
                isAccountSetUp ? borderless_btn("View Account",() {}) : borderless_btn("Set Up Account", () => next(context, "/accountSetup"))
              ],
            ),
          ),

          SizedBox(height: 80.0,),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Portfolio",
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 20.0
                      ),
                    ),

                    SizedBox(height: 20.0,),

                    isStockMoreThanFour 

                    ?

                    borderless_btn("View All", () => next(context, "/wallet"))

                    :

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

                isAccountSetUp 

                ?

                Container(
                  height: 332.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          stock_box(
                            name: "Apple Inc",
                            symbol: "APPL",
                            price: "1207.99",
                            percent: "1.2",
                            change: "54.77",
                            positive: false
                          ),

                          stock_box(
                            name: "Warner bros Discovery Inc",
                            symbol: "WBD",
                            price: "1207.99",
                            percent: "5",
                            change: "89.37",
                            positive: true
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          stock_box(
                            name: "Work Horse Group",
                            symbol: "WKHS",
                            price: "456.89",
                            percent: "5",
                            change: "9.37",
                            positive: true
                          ),

                          stock_box(
                            name: "Paramount Global",
                            symbol: "PARA",
                            price: "13507.99",
                            percent: "2",
                            change: "74.00",
                            positive: false
                          )
                        ],
                      )
                    ],
                  ),
                )

                :

                empty_msg("assets/images/empty_portfolio_a.svg", "You currently have no stocks in your portfolio")
              ],
            ),
          )
        ],
      )
    );
  }
}