import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/add_ons/value_to_decimal.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/notifiers/currency_notifier.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class BuyStockPage extends StatefulWidget {
  const BuyStockPage({super.key});

  @override
  State<BuyStockPage> createState() => _BuyStockPageState();
}

class _BuyStockPageState extends State<BuyStockPage> {
  String stockError = "";
  TextEditingController stockController = TextEditingController();

  String amountError = "";
  TextEditingController amountController = TextEditingController();

  bool stockFieldEnabled = false;
  FocusNode _focusNode = FocusNode();

  double etnPricePerShare = 0.0;

  double priceOfStocks = 0.0;
  double noOfStocks = 0.0;

  @override
  void dispose() {
    _focusNode.dispose();
    stockController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    amountController.addListener(setNumberOfShares);
    stockController.addListener(setPrice);
  }

  setPrice () {
    if (stockFieldEnabled) {
      setState(() {
      double price = double.tryParse(stockController.text) ?? 0.0;
      double priceToSet = price * etnPricePerShare;
      amountController.text = priceToSet.toStringAsFixed(2);
    });
    }
  }

  setNumberOfShares () {
    if (!stockFieldEnabled) {
      setState(() {
        double amount = double.tryParse(amountController.text) ?? 0.0;
        double numberOfShares = amount / etnPricePerShare;
        stockController.text = numberOfShares.toStringAsFixed(2);
      });
    }
  }

  void focusOnTextField () {
      print("clicked");
      setState(() {
        stockFieldEnabled = !stockFieldEnabled;
      });

        WidgetsBinding.instance.addPostFrameCallback((_) {
        if (stockFieldEnabled) {
          FocusScope.of(context).requestFocus(_focusNode);
        } else {
          _focusNode.unfocus();
        }
      });

      print(stockFieldEnabled);
    }

  @override
  Widget build(BuildContext context) {
    double balance = Provider.of<Walletmodel>(context).balance;
    Map shareInfo = ModalRoute.of(context)!.settings.arguments as Map;
    double pricePerShareNaira = shareInfo["pricePerShareNaira"];
    double pricePerShareDollars = shareInfo["pricePerShareDollars"];
    etnPricePerShare = shareInfo["etnPricePerShare"];
    double balanceInNaira = Provider.of<Walletmodel>(context).balanceInNaira;
    double balanceInDollars = Provider.of<Walletmodel>(context).balanceInDollars;
    String currency = Provider.of<CurrencyNotifier>(context).currency;
    String symbol = shareInfo["symbol"];
    String stockName = shareInfo["stockName"];


    void setMaxAmount(balance) {
      if (balance > 0) {
        final maxAmount = balance - 0.000042;
        final number = balance / etnPricePerShare;
        setState(() {
          amountController.text = maxAmount.toString();
          print("From set max amount");
          print(maxAmount);
          stockController.text = "${value_to_delimal(value: number, type: true)}";
        });
      } else {
        setState(() {
          amountController.text = "0";
          amountError = "You have no Electroneum in your account please fund your account";
        });

        pop_up(
          ctx: context, 
          txt: "You have no Electroneum in your account please fund your account",
          primaryBtn: true,
          primaryBtnTxt: "Fund Account",
          primaryBtnOnTap: () => nextNavPageWithData(context, 1),
        );
      }
    }

    void review () async {
      String theAmount = amountController.text;
      if (theAmount == "" || theAmount == "0") {
        setState(() {
          amountError = "Please enter a valid amount";
        });
      } else {
        try {
        final buyAmount = double.parse(amountController.text);
        print(buyAmount);
        if (buyAmount > balance) {
          setState(() {
            amountError = "Insufficient funds, please add more ETN to your wallet";
          });

          pop_up(
            ctx: context, 
            txt: "You have no Electroneum in your account please fund your account",
            primaryBtn: true,
            primaryBtnTxt: "Fund Account",
            primaryBtnOnTap: () => nextNavPageWithData(context, 1),
          );
        } else {
          priceOfStocks = double.parse(amountController.text);
          noOfStocks = double.parse(stockController.text);
          setState(() {
            amountError = "";
          });

          nextWithData(context, '/orderDetails', {
            'isItBuy' : true,
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
            amountError = "Invalid Amount";
          });
        } else {
          print("An error occured");
        }
      }
      }
    }


    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Buy Stock"),
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
                      fontSize: 22.0
                    ),
                ),
        
                SizedBox(height: 28.0,),
        
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
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
        
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "No of Shares:",
                  style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                ),
        
                SizedBox(height: 16.0),
        
                InputField(
                  placeholder: "0", 
                  iconPath: 'assets/icons/stock.svg', 
                  type: 'stock', 
                  error: stockError, 
                  fieldHeight: 100.0, 
                  errorHeight: 0.0, 
                  controller: stockController,
                  isItBuy: true,
                  isItEnabled: stockFieldEnabled,
                  focusNode: _focusNode,
                  disabledCallback: () => focusOnTextField()
                ),
              ],
            ),
        
            SizedBox(height: 16.0),
        
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
                  placeholder: 'Amount', 
                  iconPath: 'assets/icons/etn.svg', 
                  type: 'amount', 
                  error: amountError, 
                  fieldHeight: 180.0, 
                  errorHeight: 40.0, 
                  controller: amountController,
                  isItBuy: false,
                  setMaxAmount: () => setMaxAmount(balance),
                ),
              ],
            ),
        
            Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  btn("Review", false, () => review())
                ],
              )
          ],
        ),
      ),
    );
  }
}