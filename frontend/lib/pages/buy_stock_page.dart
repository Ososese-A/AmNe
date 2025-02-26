import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class BuyStockPage extends StatefulWidget {
  const BuyStockPage({super.key});

  @override
  State<BuyStockPage> createState() => _BuyStockPageState();
}

class _BuyStockPageState extends State<BuyStockPage> {
  final String stockError = "";
  final TextEditingController stockController = TextEditingController();

  final String amountError = "";
  final TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Buy Stock"),
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
        
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No of Shares:",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
        
                SizedBox(height: 16.0),
        
                InputField(
                  placeholder: "0", 
                  iconPath: 'assets/icons/stock.svg', 
                  type: 'stock', 
                  error: stockError, 
                  fieldHeight: 100.0, 
                  errorHeight: 0.0, 
                  controller: stockController,
                  isItBuy: true,
                ),
              ],
            ),
        
            SizedBox(height: 16.0),
        
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How much would you like to send?",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
        
                SizedBox(height: 16.0),
        
                InputField(
                  placeholder: 'Amount', 
                  iconPath: 'assets/icons/ngn.svg', 
                  type: 'amount', 
                  error: amountError, 
                  fieldHeight: 180.0, 
                  errorHeight: 40.0, 
                  controller: amountController
                ),
              ],
            ),
        
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btn("Review", false, () => nextWithData(context, '/orderDetails', {
                    'isItBuy' : true,
                    'pricePerStock' : '527.333 ETN',
                    'noOfStock' : '2.98',
                    'orderFee' : '5.0036 ETN',
                    'orderPrice' : '1,571.4523 ETN',
                    'total' : '1,576.4559 ETN'
                  })),
                ],
              )
          ],
        ),
      ),
    );
  }
}