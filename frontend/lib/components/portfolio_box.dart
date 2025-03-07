import 'package:flutter/material.dart';
import 'package:frontend/add_ons/empty_msg.dart';
import 'package:frontend/add_ons/stock_box.dart';
import 'package:frontend/add_ons/value_to_decimal.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/model/historyModel.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class PortfolioBox extends StatefulWidget {
  final bool customize;
  final int count;

  PortfolioBox({
    super.key,
    this.customize = false,
    this.count = 1
  });

  @override
  State<PortfolioBox> createState() => _PortfolioBoxState();
}

class _PortfolioBoxState extends State<PortfolioBox> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _fetchStockNumbers);
  }

  Future<void> _fetchStockNumbers() async {
    await Provider.of<HistoryModel>(context, listen: false).fetchAndUpdateStockNumbers();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isPortfolioEmpty = Provider.of<HistoryModel>(context).isPortfolioEmpty;
    final etnValue = Provider.of<Walletmodel>(context).etnValue;
    final dollarMultiple = 1 / etnValue;

    final List _stocks = Provider.of<HistoryModel>(context).portfolio;

    return Expanded(
      child: Column(
        children: [
          _isLoading
              ? Center(
                  child: CircularProgressIndicator(
                    color: customColors.app_light_a,
                    strokeWidth: 8.0,
                    strokeCap: StrokeCap.round,
                  ),
                )
              : isPortfolioEmpty
                  ? Container(
                      margin: EdgeInsets.symmetric(vertical: 32.0),
                      child: empty_msg("assets/images/empty_portfolio_a.svg",
                          "You currently have no stocks in your portfolio"),
                    )
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                        ),
                        itemCount: widget.customize ? widget.count : _stocks.length,
                        itemBuilder: (context, index) {
                          final stock = _stocks[index];
                          final stockName = stock['stockName'] ?? 'N/A';
                          final stockSymbol = stock['stockSymbol'] ?? 'N/A';
                          final regularMarketPrice = stock['regularMarketPrice'] ?? 0;
                          final regularMarketChangePercent = stock['regularMarketChangePercent'] ?? 0;
                          final regularMarketChange = stock['regularMarketChange'] ?? 0;

                          if (regularMarketPrice == 0) _fetchStockNumbers();

                          return ((index + 1) % 2 == 0 && (index + 1) % 4 == 0) ||
                                  ((index + 1) % 2 == 1 && (index + 1) % 4 == 1)
                              ? GestureDetector(
                                  onTap: () => nextWithData(context, '/stockInfo', stockSymbol),
                                  child: stock_box(
                                    name: stockName,
                                    symbol: stockSymbol,
                                    price: "${value_to_delimal(value: (regularMarketPrice * dollarMultiple), type: false)}",
                                    percent: "${value_to_delimal(value: (regularMarketChangePercent + 0.0), type: false)}",
                                    change: "${value_to_delimal(value: (regularMarketChange * dollarMultiple), type: false)}",
                                    positive: regularMarketChangePercent > 0,
                                    backgroundColor: customColors.app_dark_b,
                                  ),
                                )
                              : GestureDetector(
                                  onTap: () => nextWithData(context, '/stockInfo', stockSymbol),
                                  child: stock_box(
                                    name: stockName,
                                    symbol: stockSymbol,
                                    price: "${value_to_delimal(value: (regularMarketPrice * dollarMultiple), type: false)}",
                                    percent: "${value_to_delimal(value: (regularMarketChangePercent + 0.0), type: false)}",
                                    change: "${value_to_delimal(value: (regularMarketChange * dollarMultiple), type: false)}",
                                    positive: regularMarketChangePercent > 0,
                                  ),
                                );
                        },
                      ),
                    ),
        ],
      ),
    );
  }
}
