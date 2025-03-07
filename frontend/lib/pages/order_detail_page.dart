import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/add_ons/value_to_decimal.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class OrderDetailPage extends StatefulWidget {
  OrderDetailPage({super.key});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  late bool isItBuy;

  late double pricePerStock;

  late double noOfStock;

  late double orderFee;

  late double orderPrice;

  late double total;

  late String symbol;

  late String stockName;

  bool isLoading = false;

  void _placeOrder (context) async {
    setState(() {
      isLoading = true;
    });
    final backendResponse = await placeOrder(
      isItBuy: isItBuy, 
      symbol: symbol, 
      pricePerStock: pricePerStock, 
      noOfStock: noOfStock, 
      orderPrice: orderPrice, 
      stockName: stockName, 
      orderFee: orderFee
    );
    // next(context, '/orderConfirmed');
    if (backendResponse["isThereError"]) {
        setState(() {
          isLoading = false;
        });
        pop_up(
          ctx: context, 
          txt: "Something went wrong on our end, please try again",
          primaryBtn: true,
          primaryBtnTxt: "Done",
          primaryBtnOnTap: () => Navigator.pop(context),
        );
      } else {
        setState(() {
          isLoading = true;
        });
        setMainPage(context, "/orderConfirmed", "/orderConfirmed");
      }

      setState(() {
          isLoading = true;
      });
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> orderDetails = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>? ?? {};
    isItBuy = orderDetails['isItBuy'];
    pricePerStock = orderDetails['pricePerStock'];
    noOfStock = orderDetails['noOfStock'];
    orderFee = orderDetails['orderFee'];
    orderPrice = orderDetails['orderPrice'];
    total = orderDetails['total'];
    symbol = orderDetails['symbol'];
    stockName = orderDetails['stockName'];

    print("This is noOfStock: $noOfStock and this is the runtimetype ${noOfStock.runtimeType}");

    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'Order Deatils'),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
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
                        "${value_to_delimal(value: pricePerStock, type: true)} ETN",
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
                        "${value_to_delimal(value: noOfStock, type: true)}",
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
                        "${orderFee} ETN",
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
                        "${value_to_delimal(value: orderPrice, type: true)} ETN",
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
                        "${value_to_delimal(value: total, type: true)} ETN",
                        // "${total}",
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
            
                btn('Place Order', false, () => _placeOrder(context))
              ],
            ),
          ),

          if (isLoading)
          loading_spinner()
        ],
      ),
    );
  }
}