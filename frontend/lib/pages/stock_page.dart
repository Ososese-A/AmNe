import 'package:flutter/material.dart';
import 'package:frontend/add_ons/empty_msg.dart';
import 'package:frontend/add_ons/main_app_bar.dart';
import 'package:frontend/components/currency_badge.dart';
import 'package:frontend/components/search_bar.dart';
import 'package:frontend/components/stock_box.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final TextEditingController _searchController = TextEditingController();
  final bool stockNotFound = false;

  final List _stocks = [
    {
      'name': 'Apple Inc',
      'symbol': 'AAPL',
      'price': '247.10',
      'percent': '0.63',
      'change': '1.55',
    },
    {
      'name': 'Warner Bros Discovery Inc',
      'symbol': 'WBD',
      'price': '11.09',
      'percent': '0.31',
      'change': '2.88',
    },
    {
      'name': 'Broadcom Inc',
      'symbol': 'AVGO',
      'price': '207.93',
      'percent': '-4.91',
      'change': '10.73',
    },
    {
      'name': 'Walmart Inc',
      'symbol': 'WMT',
      'price': '93.71',
      'percent': '-1.13',
      'change': '1.07',
    },
    {
      'name': 'Nvidia Corporation',
      'symbol': 'NVDA',
      'price': '130.28',
      'percent': '-3.09',
      'change': '4.15',
    },
    {
      'name': 'Sonos Inc',
      'symbol': 'SONO',
      'price': '12.51',
      'percent': '4.86',
      'change': '0.58',
    },
    {
      'name': 'Western Digital Corporation',
      'symbol': 'WDC',
      'price': '49.02',
      'percent': '-5.58',
      'change': '2.90',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: main_app_bar(context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stock List",
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 32.0
                  ),
                ),

                CurrencyBadge(text: "NGN")
              ],
            ),

            SizedBox(height: 28.0,),

            StockSearch(
              controller: _searchController, 
              placeHolder: "Search for a stock", 
              onTap: () {}
            ),

            SizedBox(height: 24.0,),

            Center(
              child: Text(
                "Market Closed",
                style: TextStyle(
                  color: customColors.app_red,
                  fontSize: 16.0
                ),
              ),
            ),

            SizedBox(height: 20.0,),

            stockNotFound 

            ?

            Column(
              children: [
                SizedBox(height: 52.0,),
                empty_msg("assets/images/stock_not_found_a.svg", "Stock Not Found")
              ],
            )

            :

            Expanded(
              child: ListView.builder(
                itemCount: _stocks.length,
                itemBuilder: (context, index) {
                  return StockBox(
                    symbol: _stocks[index]['symbol'], 
                    name: _stocks[index]['name'], 
                    price: _stocks[index]['price'], 
                    percent: _stocks[index]['percent'], 
                    change: _stocks[index]['change'],
                    onTap: () => nextWithData(context, '/stockInfo', _stocks[index]['symbol']),
                  );
                }
              )
            )
          ],
        ),
      )
    );
  }
}