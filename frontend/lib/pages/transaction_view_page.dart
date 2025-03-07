import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class TransactionViewPage extends StatefulWidget {
  const TransactionViewPage({super.key});

  @override
  State<TransactionViewPage> createState() => _TransactionViewPageState();
}

class _TransactionViewPageState extends State<TransactionViewPage> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> transactionInfo = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic> ?? {};
    String transactionID = transactionInfo['transactionId'];
    String participant = transactionInfo['participant'];
    bool participantType = transactionInfo['participantType'];
    String transactionType = transactionInfo['transactionType'];
    String transactionFee = transactionInfo['transactionFee'];
    String currency = transactionInfo['currency'];
    String amount = transactionInfo['amount'];
    String date = transactionInfo['date'];
    String time = transactionInfo['time'];
    String total = (
      participantType 
      ? 
      "${double.parse(amount) + double.parse(transactionFee)}"
      :
      "${(double.parse(amount) * -1) + double.parse(transactionFee)}"
      );

    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'Transaction Info'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 28.0,),
        
            Text(
              transactionType,
              style: TextStyle(
                color: customColors.app_white,
                fontSize: 24.0
              ),
            ),
        
            SizedBox(height: 40.0,),
        
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
                        participantType ? 'Sender:' : 'Receiver:',
                        style: TextStyle(
                          color: customColors.app_white,
                          fontSize: 16.0
                        ),
                      ),
                      Container(
                        width: 320.0,
                        child: Text(
                          participant,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: customColors.app_white,
                            fontSize: 16.0
                          ),
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
                    'Transaction Fee:',
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                  ),
                  Text(
                    '$transactionFee $currency',
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
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                              participantType 
                              ?
                              '$amount $currency'
                              :
                              '${(double.parse(amount) * -1)} $currency'
                              ,
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
                              'Total:',
                              style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                            ),
                            Text(
                              '$total $currency',
                              style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            
              fifthLine:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Date:',
                              style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                            ),
                            Text(
                              date,
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
                              'Time:',
                              style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                            ),
                            Text(
                              time,
                              style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              )
            ),
        
            SizedBox(height: 40.0,),
            btn('Done', false, () => Navigator.pop(context)),
          ],
        ),
      ),
    );
  }
}