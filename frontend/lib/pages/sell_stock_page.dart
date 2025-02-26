import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class SellStockPage extends StatefulWidget {
  const SellStockPage({super.key});

  @override
  State<SellStockPage> createState() => _SellStockPageState();
}

class _SellStockPageState extends State<SellStockPage> {
  final String stockError = "";
  final TextEditingController stockController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Sell Stock"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            SizedBox(height: 28.0,),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Wallet Balance:",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
        
                SizedBox(height: 28.0,),
        
                Text(
                  "145,678.9999 ETN",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
              ],
            ),
        
            SizedBox(height: 28.0,),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price per Share:",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
                Text(
                  "527.333 ETN",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
              ],
            ),

            SizedBox(height: 28.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No of stocks owned:",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
                Text(
                  "24.97",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
              ],
            ),

            SizedBox(height: 80.0,),
        
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How many stocks would you like to send?",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
        
                SizedBox(height: 16.0),
        
                InputField(
                  placeholder: "0", 
                  iconPath: 'assets/icons/stock_normal.svg', 
                  type: 'stock', 
                  error: stockError, 
                  fieldHeight: 162.0, 
                  errorHeight: 40.0, 
                  controller: stockController,
                  isItBuy: false,
                ),
              ],
            ),
        
            SizedBox(height: 16.0),
        
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btn("Review", false, () => nextWithData(context, '/orderDetails', {
                    'isItBuy' : false,
                    'pricePerStock' : '527.333 ETN',
                    'noOfStock' : '2.98',
                    'orderFee' : '5.0036 ETN',
                  })),
                ],
            )
          ],
        ),
      ),
    );
  }
}