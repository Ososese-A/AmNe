import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/components/portfolio_box.dart';
import 'package:frontend/themes/theme.dart';

class PortfolioPage extends StatelessWidget {
  PortfolioPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'My Stock Portfolio'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
                SizedBox(height: 24.0,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No of stock in portfolio:",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                          ),
                          Text(
                            "8",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                          ),
                        ],
                      ),
                      
                  
                      SizedBox(height: 24.0,),
                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Portfolio profit/loss:",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                          ),
                          Text(
                            "+ 57 USD",
                            style: TextStyle(
                                color: customColors.app_green,
                                fontSize: 16.0
                              ),
                          ),
                        ],
                      ),
                  
                      SizedBox(height: 24.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Portfolio Value:",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                          ),
                          Text(
                            "40,000 USD",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 24.0,),

            PortfolioBox()
          ],
        ),
      ),
    );
  }
}