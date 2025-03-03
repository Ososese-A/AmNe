import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class TransactionDetailPage extends StatelessWidget {
  const TransactionDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> transactionDetails = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final transactionID = transactionDetails['transactionID'];
    final receiver = transactionDetails['receiver'];
    final gasFee = transactionDetails['gasFee'];
    final amount = transactionDetails['amount'];
    final total = transactionDetails['total'];


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
                        "145,678.9999 ETN",
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
                          'Transaction ID:',
                          style: TextStyle(
                            color: customColors.app_white,
                            fontSize: 16.0
                          ),
                        ),
                        Text(
                          transactionID,
                          style: TextStyle(
                            color: customColors.app_white,
                            fontSize: 16.0
                          ),
                        ),
                      ],
                    ),
                  ],
                ), 
                secondLine: Row(
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
                            fontSize: 16.0
                          ),
                        ),
                      ],
                    ),
                  ],
                ), 
                
                thirdLine: Row(
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
                
                forthLine:
                
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
                      amount,
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ],
                ),
                
                fifthLine:
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
                      total,
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ],
                )
              ),
                
              SizedBox(height: 40.0,),
              btn('Done', false, () => setMainAsMainPageWithData(context, 3)),
            ],
          ),
        ),
      ),
    );
  }
}