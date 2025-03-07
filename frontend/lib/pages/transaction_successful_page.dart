import 'package:flutter/material.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/empty_msg.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class TransactionSuccessfulPage extends StatelessWidget {
  const TransactionSuccessfulPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            empty_msg('assets/images/welcome_a.svg', 'Transaction Successful'),

            SizedBox(height: 52.0,),

            btn('Done', false, () => setMainPage(context, '/main', '/main'))
          ],
        ),
      ),
    );;
  }
}