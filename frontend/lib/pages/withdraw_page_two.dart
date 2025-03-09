import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/value_to_decimal.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class WithdrawPageTwo extends StatefulWidget {
  const WithdrawPageTwo({super.key});

  @override
  State<WithdrawPageTwo> createState() => _WithdrawPageTwoState();
}

class _WithdrawPageTwoState extends State<WithdrawPageTwo> {
  String walletError = "";
  TextEditingController walletController = TextEditingController();

  String amountError = "";
  TextEditingController amountController = TextEditingController();

  void setAddress (address) {
    setState(() {
      walletController.text = address;
    });
  }

  void setMaxAmount(balance) {
    final maxAmount = balance - 0.000042;
    setState(() {
      amountController.text = maxAmount.toString();
      print("From set max amount");
      print(maxAmount);
    });
  }

  void getGasFee (String userSender) async {
    final wallet = walletController.text;
    final amount = amountController.text;

    final backendResponse = await checkGasFee(wallet: wallet, amount: amount, sender: userSender);
    if (backendResponse["isThereError"]) {
        print(backendResponse['error']);
        setState(() {
          amountError = backendResponse['error'];
        });
    } else {
        print("This is the gas fee response");
        print(backendResponse["gasFee"].runtimeType);
        print(backendResponse["gasFee"]);
        // btn("Send", false, () => setMainPageWithData(context, '/transactionDetail', '/main', {
                  //   'transactionID': 'z9ZHBahg7qKXxgthu8eP3ABP7k3ra5WH',
                  //   'receiver': address,
                  //   'amount': '20.0000 ETN',
                  //   'gasFee': '0.00021 ETN',
                  //   'total': '20.00021 ETN'
                  // })),
        nextWithData(context, "/transactionDetail", {
          'receiver': wallet,
          'amount': amount,
          'gasFee': backendResponse["gasFee"],
          'total': (double.parse(amount) + double.parse(backendResponse["gasFee"]))
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> walletAddress = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final address = walletAddress['address'];
    setAddress(address);
    print(walletController.text);
    final balance = Provider.of<Walletmodel>(context).balance;
    final userSender = Provider.of<Walletmodel>(context).address;
    


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
                  "${value_to_delimal(value: balance, type: false)} ETN",
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
                  focusNode: FocusNode(),
                  isItEnabled: false,
                  disabledCallback: () => Navigator.pop(context),
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
                  iconPath: 'assets/icons/etn.svg', 
                  type: 'stock', 
                  error: amountError, 
                  fieldHeight: 200.0, 
                  errorHeight: 40.0, 
                  controller: amountController,
                  focusNode: FocusNode(),
                  isItBuy: false,
                  setMaxAmount: () => setMaxAmount(balance),
                ),
              ],
            ),
        
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btn("Send", false, () => getGasFee(userSender)),
                ],
            )
          ],
        ),
      ),
    );
  }
}