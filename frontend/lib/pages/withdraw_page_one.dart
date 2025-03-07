import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class WithdrawPageOne extends StatefulWidget {
  const WithdrawPageOne({super.key});

  @override
  State<WithdrawPageOne> createState() => _WithdrawPageOneState();
}

class _WithdrawPageOneState extends State<WithdrawPageOne> {
  String walletError = "";
  TextEditingController walletController = TextEditingController();

  void _checkWallet () async {
    walletController.text = "0xBB583e59c9D50D1C58be39a98F0397872D9D28fD";
    final String wallet = walletController.text;

    if (wallet == '') {
      setState(() {
        walletError = 'Please enter a valid wallet address';
      });
    } else {
      final backendResponse =  await checkWallet(wallet: wallet);
      print("This is the backendResponse from withraw page");
      print(backendResponse);
      if (backendResponse['isThereError']) {
        setState(() {
          walletError = backendResponse['error'];
        });
      } else {
        nextWithData(context, '/withdrawTwo', {'address' : wallet,});
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Withdraw Funds"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            SizedBox(height: 28.0),
        
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Paste the wallet address of the receiver of the funds you would like to withdraw",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
        
                SizedBox(height: 16.0),
        
                InputField(
                  placeholder: "Wallet Address", 
                  iconPath: 'assets/icons/wallet_normal.svg', 
                  type: 'normal', 
                  error: walletError, 
                  fieldHeight: 140.0, 
                  errorHeight: 40.0, 
                  controller: walletController,
                ),
              ],
            ),
        
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // btn("Next", false, () => ),
                  btn("Next", false, () => _checkWallet()),
                ],
            )
          ],
        ),
      ),
    );
  }
}