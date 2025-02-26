import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class OrderDetailPage extends StatelessWidget {
  const OrderDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> orderDetails = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};
    final isItBuy = orderDetails['isItBuy'];
    final pricePerStock = orderDetails['pricePerStock'];
    final noOfStock = orderDetails['noOfStock'];
    final orderFee = orderDetails['orderFee'];
    final orderPrice = orderDetails['orderPrice'] ?? '';
    final total = orderDetails['total'] ?? '';

    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'Order Deatils'),
      body: Column(
        children: [
          SizedBox(height: 28.0,),

          MainCard(
            backgroundColor: customColors.app_dark_a,
            firstLine: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price per stock:',
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 16.0
                  ),
                ),
                Text(
                  pricePerStock,
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 16.0
                  ),
                ),
              ],
            ), 
            secondLine: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'No of stock:',
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 16.0
                  ),
                ),
                Text(
                  noOfStock,
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 16.0
                  ),
                ),
              ],
            ), 

            thirdLine: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order fee:',
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 16.0
                  ),
                ),
                Text(
                  orderFee,
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 16.0
                  ),
                ),
              ],
            ),

            extend: true,

            forthLine: isItBuy

            ?

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order price:',
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 16.0
                  ),
                ),
                Text(
                  orderPrice,
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 16.0
                  ),
                ),
              ],
            )

            :

            Row(
              children: [
              ],
            ),

            fifthLine: isItBuy

            ?

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

            :

            Row(
              children: [
              ],
            )
          ),

          SizedBox(height: 40.0,),

          btn('Place Order', false, () => next(context, '/orderConfirmed'))
        ],
      ),
    );
  }
}