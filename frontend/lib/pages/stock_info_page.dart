import 'package:flutter/material.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/add_ons/sec_app_bar.dart';
import 'package:frontend/add_ons/value_to_decimal.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/model/historyModel.dart';
import 'package:frontend/notifiers/currency_notifier.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class StockInfoPage extends StatefulWidget {
  const StockInfoPage({super.key});

  @override
  State<StockInfoPage> createState() => _StockInfoPageState();
}

class _StockInfoPageState extends State<StockInfoPage> {
  bool isExpanded = false;
  bool isLoading = false;
  String name = "";
  String symbol = "";
  String description = "";
  double change = 0.0;
  double percent = 0.0;
  double price = 0.0;

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    final String stockData = ModalRoute.of(context)!.settings.arguments as String? ?? 'SYMB';
    if (name == "") {
      _getStockInfo(stockData);
    }
    // _getStockInfo(stockData);
  }

  void _getStockInfo (stock) async {
    setState(() {
      isLoading = true;
    });

    print("This is the stock being passed");
    print(stock);
    final stockInfo = await getStockInfo(type: "stockInfo", symbol: stock);
    print("STockInfo from stock infor page");
    print(stockInfo);

    setState(() {
      name = stockInfo["name"];
      symbol = stockInfo["symbol"];
      description = stockInfo["stockInfo"];
      price = stockInfo["regularMarketPrice"];
      percent = stockInfo["regularMarketChangePercent"];
      change = stockInfo["regularMarketChange"];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String stockData = ModalRoute.of(context)!.settings.arguments as String? ?? 'SYMB';
    String currency = Provider.of<CurrencyNotifier>(context).currency;
    double rate = Provider.of<Walletmodel>(context).rate;
    double balance = Provider.of<Walletmodel>(context).balance;
    double etnValue = Provider.of<Walletmodel>(context).etnValue;
    double stockInEtn = price / etnValue;
    print(balance);
    print(price);
    print(etnValue);

    HistoryModel historyModel = Provider.of<HistoryModel>(context);
    print("This is the check for the symbol $symbol");
    bool isInPortfolio = historyModel.isStockInPortfolio(symbol);
    print("This is the check for the isInportfolio $isInPortfolio");

     void _expansionToggle () {
      setState(() {
        isExpanded = !isExpanded;
      });
     }

     final noOfStockOwned = historyModel.getNoOfStocks(symbol);
     print("$noOfStockOwned");
     final buyPricePerStock = historyModel.getBuyPricePerStock(symbol);
     final profitOrLossPriceInter = stockInEtn - buyPricePerStock;
     final profitOrLossPrice = profitOrLossPriceInter * buyPricePerStock * noOfStockOwned;

    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: sec_app_bar(context, "Stock Info"),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal:  16.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 28.0,),
                      Text(
                        name,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: customColors.app_white,
                            fontSize: 36.0
                          ),
                      ),
              
                      SizedBox(height: 12.0,),
              
                      Text(
                        "($stockData)",
                        style: TextStyle(
                            color: customColors.app_white,
                            fontSize: 20.0
                          ),
                      ),
                    ],
                  ),
          
                  SizedBox(height: 36.0,),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currency == "NGN"
                            ?
                            "${value_to_delimal(value: (price * rate), type: false)} NGN"
                            :
                            "${value_to_delimal(value: price, type: false)} USD",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                          ),

                          SizedBox(height:  16.0),

                          Text(
                            "(${value_to_delimal(value: stockInEtn, type: false)} ETN)",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 14.0
                              ),
                          )
                        ],
                      ),
              
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            percent < 0 
                            ? 
                            "${value_to_delimal(value: percent, type: false)}%"
                            :
                            "+${value_to_delimal(value: percent, type: false)}%",
                            style: TextStyle(
                                color: percent < 0 ? customColors.app_red : customColors.app_green,
                                fontSize: 16.0
                              ),
                          ),
              
                          SizedBox(width: 20.0,),
                          
                          Text(
                            currency == "NGN"
                            ?
                            percent < 0 ? "${value_to_delimal(value: (change * rate), type: false)}" : "+${value_to_delimal(value: (change * rate), type: false)}"
                            :
                            percent < 0 ? "${value_to_delimal(value: change, type: false)}" : "+${value_to_delimal(value: change, type: false)}",
                            style: TextStyle(
                                color: percent < 0 ? customColors.app_red : customColors.app_green,
                                fontSize: 16.0
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
          
                  isInPortfolio
          
                  ?
          
                  Column(
                    children: [
                      SizedBox(height: 36.0,),
          
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "No of stocks owned:",
                                style: TextStyle(
                                    color: customColors.app_white,
                                    fontSize: 20.0
                                  ),
                              ),
                              Text(
                                "$noOfStockOwned",
                                style: TextStyle(
                                    color: customColors.app_white,
                                    fontSize: 16.0
                                  ),
                              ),
                            ],
                          ),
          
                          SizedBox(height: 36.0,),
          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total profit/loss:",
                                style: TextStyle(
                                    color: customColors.app_white,
                                    fontSize: 20.0
                                  ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    currency == "NGN"
                                    ?
                                    "${value_to_delimal(value: (profitOrLossPriceInter * rate), type: false)} NGN"
                                    :
                                    "${value_to_delimal(value: profitOrLossPriceInter, type: false)} USD",
                                    style: TextStyle(
                                        color: profitOrLossPrice > 0 ? customColors.app_green : customColors.app_red,
                                        fontSize: 16.0
                                      ),
                                  ),
                                  Text(
                                    "(${value_to_delimal(value: profitOrLossPrice, type: false)} ETN)",
                                    style: TextStyle(
                                        color: profitOrLossPrice > 0 ? customColors.app_green : customColors.app_red,
                                        fontSize: 14.0
                                      ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      
                      SizedBox(height: 36.0,),
                    ],
                  )
          
                  :
          
                  SizedBox(height: 36.0,),
          
                  Text(
                    description,
                    overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                    maxLines: isExpanded ? null : 10,
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                  ),
          
                  GestureDetector(
                    onTap: _expansionToggle,
                    child: Text(
                      isExpanded ? "Show Less" : "Show More",
                      style: TextStyle(
                        color: customColors.app_light_a,
                        fontSize: 16.0
                    ),
                    ),
                  ),
          
                  SizedBox(height: 36.0,),
          
                  // btn('Buy', false, () => next(context, '/buy')),
                  btn('Buy', false, () => nextWithData(context, '/buy', {
                    "symbol": symbol,
                    "stockName": name,
                    "pricePerShareNaira": (price * rate),
                    "pricePerShareDollars": price,
                    "etnPricePerShare": (stockInEtn)
                  })),
          
                  isInPortfolio 
                  ?
                  Column(
                    children: [
                      SizedBox(height: 36.0,),
          
                      btn('Sell', true, () => nextWithData(context, '/sell', {
                        "symbol": symbol,
                        "stockName": name,
                        "pricePerShareNaira": (price * rate),
                        "pricePerShareDollars": price,
                        "etnPricePerShare": (stockInEtn),
                        "noOfStocksOwned": noOfStockOwned
                      })),
                      
                      SizedBox(height: 36.0,),
                    ],
                  )
                  :
                  SizedBox(height: 36.0,)
                ],
              ),
            ),
          ),

          if (isLoading)
          loading_spinner()
        ],
      ),
    );
  }
}