import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/value_to_decimal.dart';
import 'package:frontend/components/portfolio_box.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/model/historyModel.dart';
import 'package:frontend/notifiers/currency_notifier.dart';
import 'package:frontend/themes/theme.dart';
import 'package:provider/provider.dart';

class PortfolioPage extends StatelessWidget {
  PortfolioPage({super.key});
  @override
  Widget build(BuildContext context) {
    final currency = Provider.of<CurrencyNotifier>(context).currency;
    final historyModel = Provider.of<HistoryModel>(context);
    final etnValue = Provider.of<Walletmodel>(context).etnValue;
    final rate = Provider.of<Walletmodel>(context).rate;

    final totalValueInEtn = historyModel.getTotalPortfolioValue(context);
    final totalValueInNaira = historyModel.getTotalPortfolioValue(context) * rate *etnValue;
    final totalValueInDollars = historyModel.getTotalPortfolioValue(context) *etnValue;
    final totalProfitLossInEtn = historyModel.getTotalProfitOrLoss(context);
    final totalProfitLossInNaira = historyModel.getTotalProfitOrLoss(context) * rate * etnValue;
    final totalProfitLossInDollars = historyModel.getTotalProfitOrLoss(context) * etnValue;
    final numStocks = historyModel.getNumberOfStocks(); 


    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'My Stock Portfolio'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
                SizedBox(height: 24.0,),

                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No of stock in portfolio:",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                          ),
                          Text(
                            "$numStocks",
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
                            "Portfolio profit/loss:",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                          ),
                          Column(
                            children: [
                              Text(
                                "${value_to_delimal(value: totalProfitLossInEtn, type: true)} ETN",
                                style: TextStyle(
                                    color: totalProfitLossInEtn < 0 ? customColors.app_red : customColors.app_green,
                                    fontSize: 16.0
                                  ),
                              ),
                              Text(
                                // "+ 57 USD",
                                currency == "NGN"
                                ?
                                "(${value_to_delimal(value: totalProfitLossInNaira, type: false)} NGN)"
                                :
                                "(${value_to_delimal(value: totalProfitLossInDollars, type: true)} USD)",
                                style: TextStyle(
                                    color: totalProfitLossInEtn < 0 ? customColors.app_red : customColors.app_green,
                                    fontSize: 12.0
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                  
                      SizedBox(height: 24.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Portfolio Value:",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                          ),
                          Column(
                            children: [
                              Text(
                                "${value_to_delimal(value: totalValueInEtn, type: true)} ETN",
                                style: TextStyle(
                                    color: customColors.app_white,
                                    fontSize: 16.0
                                  ),
                              ),
                              Text(
                                currency == "NGN"
                                ?
                                "(${value_to_delimal(value: totalValueInNaira, type: false)} NGN)"
                                :
                                "(${totalValueInDollars.toStringAsFixed(8)} USD)",
                                style: TextStyle(
                                    color: customColors.app_white,
                                    fontSize: 14.0
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 24.0,),

            PortfolioBox()
          ],
        ),
      ),
    );
  }
}