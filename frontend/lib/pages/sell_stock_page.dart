import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/value_to_decimal.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/notifiers/currency_notifier.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class SellStockPage extends StatefulWidget {
  const SellStockPage({super.key});

  @override
  State<SellStockPage> createState() => _SellStockPageState();
}

class _SellStockPageState extends State<SellStockPage> {
  String stockError = "";
  TextEditingController stockController = TextEditingController();
  double etnPricePerShare = 0.0;
  double priceOfStocks = 0.0;
  double noOfStocks = 0.0;

  @override
  Widget build(BuildContext context) {
    Map shareInfo = ModalRoute.of(context)!.settings.arguments as Map;
    etnPricePerShare = shareInfo["etnPricePerShare"];
    double pricePerShareNaira = shareInfo["pricePerShareNaira"];
    double pricePerShareDollars = shareInfo["pricePerShareDollars"];
    double balance = Provider.of<Walletmodel>(context).balance;
    double balanceInNaira = Provider.of<Walletmodel>(context).balanceInNaira;
    double balanceInDollars = Provider.of<Walletmodel>(context).balanceInDollars;
    String currency = Provider.of<CurrencyNotifier>(context).currency;
    String symbol = shareInfo["symbol"];
    String stockName = shareInfo["stockName"];
    double noOfStocksOwned = shareInfo["noOfStocksOwned"];

    void setMaxAmount() {
      final maxAmount = noOfStocksOwned;
      setState(() {
        stockController.text = maxAmount.toString();
        print("From set max amount");
        print(maxAmount);
        stockController.text = "$maxAmount";
      });
    }


    void review () async {
      String theAmount = stockController.text;
      if (theAmount == "" || theAmount == null) {
        setState(() {
          stockError = "Please enter a valid amount";
        });
      } else {
        try {
        final sellAmount = double.parse(stockController.text);
        print("stockController.text");
        print(stockController.text);
        print(sellAmount);
        if (sellAmount > noOfStocksOwned) {
          setState(() {
            stockError = "The amount of shares you entered is more than the amount of shares you own";
          });
        } else {
            priceOfStocks = sellAmount * etnPricePerShare;
            print("This is priceOfStocks $priceOfStocks");
            print("This is priceperstock/etnPrice $etnPricePerShare");
            print("This is noOfStocks $noOfStocks");
            noOfStocks = sellAmount;
            setState(() {
              stockError = "";
            });

          nextWithData(context, '/orderDetails', {
            'isItBuy' : false,
            'pricePerStock' : etnPricePerShare,
            'noOfStock' : noOfStocks,
            'orderFee' : 0.000042,
            'orderPrice' : priceOfStocks,
            'symbol': symbol,
            'stockName': stockName,
            'total' : (priceOfStocks + 0.000042)
          });
        }
      } catch (e) {
        if (e is FormatException) {
          print("Invalid Amount");
          setState(() {
            stockError = "Invalid Amount";
          });
        } else {
          print("An error occured");
        }
      }
      }
    }


    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Sell Stock"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
        
                Column(
                  children: [
                    Text(
                      currency == "NGN"
                      ?
                      "${value_to_delimal(value: balanceInNaira, type: false)} NGN"
                      :
                      "${value_to_delimal(value: balanceInDollars, type: false)} USD",
                      style: TextStyle(
                          color: customColors.app_white,
                          fontSize: 16.0
                        ),
                    ),

                    Text(
                      "(${value_to_delimal(value: balance, type: false)} ETN)",
                      style: TextStyle(
                          color: customColors.app_white,
                          fontSize: 14.0
                        ),
                    ),
                  ],
                ),
              ],
            ),
        
            SizedBox(height: 28.0,),
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Price per Share:",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 22.0
                    ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      currency == "NGN"
                      ?
                      "${value_to_delimal(value: pricePerShareNaira, type: false)} NGN"
                      :
                      "${value_to_delimal(value: pricePerShareDollars, type: false)} USD",
                      style: TextStyle(
                          color: customColors.app_white,
                          fontSize: 16.0
                        ),
                    ),
                    Text(
                      "(${value_to_delimal(value: etnPricePerShare, type: false)} ETN)",
                      style: TextStyle(
                          color: customColors.app_white,
                          fontSize: 14.0
                        ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 28.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "No of stocks owned:",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
                Text(
                  "$noOfStocksOwned",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
              ],
            ),

            SizedBox(height: 80.0,),
        
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "How many stocks would you like to send?",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
        
                SizedBox(height: 16.0),
        
                InputField(
                  placeholder: "0", 
                  iconPath: 'assets/icons/stock_normal.svg', 
                  type: 'stock', 
                  error: stockError, 
                  fieldHeight: 162.0, 
                  errorHeight: 40.0, 
                  controller: stockController,
                  isItBuy: false,
                  focusNode: FocusNode(),
                  setMaxAmount: setMaxAmount,
                ),
              ],
            ),
        
            SizedBox(height: 16.0),
        
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btn("Review", false, () => review()),
                ],
            )
          ],
        ),
      ),
    );
  }
}