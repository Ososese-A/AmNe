import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class WithdrawPageTwo extends StatefulWidget {
  const WithdrawPageTwo({super.key});

  @override
  State<WithdrawPageTwo> createState() => _WithdrawPageTwoState();
}

class _WithdrawPageTwoState extends State<WithdrawPageTwo> {
  final String walletError = "";
  final TextEditingController walletController = TextEditingController();

  final String amountError = "";
  final TextEditingController amountController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> walletAddress = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic> ?? {};
    final address = walletAddress['address'];


    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Withdraw Funds"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            SizedBox(height: 28.0),

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

            SizedBox(height: 40.0,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Receiver’s Wallet Address:",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
        
                SizedBox(height: 16.0),
        
                InputField(
                  placeholder: address, 
                  iconPath: 'assets/icons/wallet.svg', 
                  type: 'stock', 
                  error: walletError, 
                  fieldHeight: 100.0, 
                  errorHeight: 0.0, 
                  controller: walletController,
                  isItBuy: true,
                ),
              ],
            ),

            SizedBox(height: 56.0),
        
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
                  placeholder: "Amount", 
                  iconPath: 'assets/icons/ngn.svg', 
                  type: 'stock', 
                  error: amountError, 
                  fieldHeight: 200.0, 
                  errorHeight: 40.0, 
                  controller: amountController,
                  isItBuy: false,
                ),
              ],
            ),
        
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btn("Send", false, () => setMainPageWithData(context, '/transactionDetail', '/main', {
                    'transactionID': 'z9ZHBahg7qKXxgthu8eP3ABP7k3ra5WH',
                    'receiver': address,
                    'amount': '20.0000 ETN',
                    'gasFee': '0.00021 ETN',
                    'total': '20.00021 ETN'
                  })),
                ],
            )
          ],
        ),
      ),
    );;
  }
}