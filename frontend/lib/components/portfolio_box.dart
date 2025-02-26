import 'package:flutter/material.dart';
import 'package:frontend/add_ons/empty_msg.dart';
import 'package:frontend/add_ons/stock_box.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class PortfolioBox extends StatelessWidget {
  final bool customize;
  final int count;

  PortfolioBox({
    super.key,
    this.customize = false,
    this.count = 1
  });

  final isPortfolioEmpty = false;

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
      'name': 'Western Digital Corporation Incorporated',
      'symbol': 'WDC',
      'price': '49.02',
      'percent': '-5.58',
      'change': '2.90',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        isPortfolioEmpty 
        
        ? 
        
        Container
        (
          margin: EdgeInsets.symmetric(vertical: 32.0),
          child: empty_msg("assets/images/empty_portfolio_a.svg", "You currently have no stocks in your portfolio")
        )
        
        :
        
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ), 
            // itemCount: 4,
            itemCount: customize ? count : _stocks.length,
            itemBuilder: (context, index) {
            return ((index + 1) % 2 == 0 && (index + 1) % 4 == 0 ) || ((index + 1) % 2 == 1 && (index + 1) % 4 == 1 )
            ?
            GestureDetector(
              onTap: () => nextWithData(context, '/stockInfo', _stocks[index]['symbol']),
              child: stock_box(
                name: _stocks[index]['name'],
                symbol: _stocks[index]['symbol'],
                price: _stocks[index]['price'],
                percent: _stocks[index]['percent'],
                change: _stocks[index]['change'],
                positive: double.parse(_stocks[index]['percent']) > 0,
                backgroundColor: customColors.app_dark_b
              ),
            )
        
            :
        
            GestureDetector(
              onTap: () => nextWithData(context, '/stockInfo', _stocks[index]['symbol']),
              child: stock_box(
                name: _stocks[index]['name'],
                symbol: _stocks[index]['symbol'],
                price: _stocks[index]['price'],
                percent: _stocks[index]['percent'],
                change: _stocks[index]['change'],
                positive: double.parse(_stocks[index]['percent']) > 0,
              ),
            );
          },
          ),
        ),
      ],
    );
  }
}