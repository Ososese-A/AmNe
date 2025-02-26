import 'package:flutter/material.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/empty_msg.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class OrderConfirmPage extends StatelessWidget {
  const OrderConfirmPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            empty_msg('assets/images/success_a.svg', 'Order Placed Successfully'),

            SizedBox(height: 16.0,),

            Container(
              width: 340.0,
              child: Text(
                '(If the market is currently closed your order will be filled as soon as it is open)',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: customColors.app_white,
                  fontSize: 16.0
                ),
              ),
            ),

            SizedBox(height: 36.0,),

            btn('Done', false, () => setMainPage(context, '/main', '/main'))
          ],
        ),
      ),
    );
  }
}