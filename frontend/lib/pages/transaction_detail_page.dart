import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/add_ons/value_to_decimal.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> transactionDetails = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final receiver = transactionDetails['receiver'];
    final gasFee = transactionDetails['gasFee'];
    final amount = transactionDetails['amount'];
    final total = transactionDetails['total'];
    final balance = Provider.of<Walletmodel>(context).balance;
    final address = Provider.of<Walletmodel>(context).address;


    void withdrawFunds () async {
      final backendResponse = await withdrawal(wallet: receiver, sender: address, amount: amount);

      if (backendResponse["isThereError"]) {
        pop_up(
          ctx: context, 
          txt: "Something went wrong on our end, please try again",
          primaryBtn: true,
          primaryBtnTxt: "Done",
          primaryBtnOnTap: () => Navigator.pop(context),
        );
      } else {
        setMainPage(context, "/transactionSuccess", "/transactionSuccess");
      }
    }


    return PopScope(
      child: Scaffold(
        backgroundColor: customColors.app_black,
        appBar: app_bar(context, 'Transaction Deatils'),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        "${value_to_delimal(value: balance, type: false)} ETN",
                        style: TextStyle(
                            color: customColors.app_white,
                            fontSize: 16.0
                          ),
                      ),
                    ],
                  ),
                
              SizedBox(height: 28.0,),
                
              MainCard(
                backgroundColor: customColors.app_dark_a,
                firstLine: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Receiver’s Wallet:',
                          style: TextStyle(
                            color: customColors.app_white,
                            fontSize: 16.0
                          ),
                        ),
                        Text(
                          receiver,
                          style: TextStyle(
                            color: customColors.app_white,
                            fontSize: 12.0
                          ),
                        ),
                      ],
                    ),
                  ],
                ), 
                secondLine: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Gas fee:',
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                    Text(
                      gasFee,
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ],
                ),
                
                extend: true,
                
                thirdLine:
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Amount:',
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                    Text(
                      "${value_to_delimal(value: double.parse(amount), type: true)}",
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ],
                ),
                
                forthLine:
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                    Text(
                      "${value_to_delimal(value: total, type: true)}",
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ],
                )
              ),
                
              SizedBox(height: 40.0,),
              btn('Proceed', false, () => withdrawFunds()),
            ],
          ),
        ),
      ),
    );
  }
}