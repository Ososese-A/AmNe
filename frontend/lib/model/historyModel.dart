import 'package:flutter/material.dart';
import 'package:frontend/utilities/authUtility.dart';

class HistoryModel extends ChangeNotifier {
  List _transactionHistory = [];
  List _orderHistory = [];
  List _portfolio = [];
  bool _isPortfolioEmpty = true;
  bool _isFetching = false;

  List get transactionHistory => _transactionHistory;
  List get orderHistory=> _orderHistory;
  List get portfolio => _portfolio;
  bool get isPortfolioEmpty => _isPortfolioEmpty;

  void updateHistoryInfo({
    required List newTransactionHistory, 
    required List newOrderHistory, 
    required List newPortfolio
  }) {
    _transactionHistory = newTransactionHistory;
    _orderHistory = newOrderHistory;
    _portfolio = newPortfolio;
    _isPortfolioEmpty = _portfolio.isEmpty;
    notifyListeners();
  }

  Future<void> fetchAndUpdateStockNumbers() async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      for (var stock in _portfolio) {
      String symbol = stock['stockSymbol'];
      var stockNumbers = await getStockNumbers(type: 'stock', symbol: symbol);
      print('Stock Numbers for $symbol: $stockNumbers');
      // Update the stock in the portfolio with the fetched data
      stock['regularMarketPrice'] = stockNumbers['regularMarketPrice'] ?? 'N/A';
      stock['regularMarketChange'] = stockNumbers['regularMarketChange'] ?? 'N/A';
      stock['regularMarketChangePercent'] = stockNumbers['regularMarketChangePercent'] ?? 'N/A';
      stock['regularMarketTime'] = stockNumbers['regularMarketTime'] ?? 'N/A';
      }
    } finally {
      _isFetching = false;
      notifyListeners();
    }
    notifyListeners();
  }

  bool isStockInPortfolio(String symbol) {
    return _portfolio.any((stock) => stock['stockSymbol'] == symbol);
  }

  double getNoOfStocks(String symbol) {
    var stock = _portfolio.firstWhere((stock) => stock['stockSymbol'] == symbol, orElse: () => null);
    if (stock != null) {
      return stock['noOfStocks'];
    } else {
      return 0;
    }
  }

  double getBuyPricePerStock(String symbol) {
    var stock = _portfolio.firstWhere((stock) => stock['stockSymbol'] == symbol, orElse: () => null);
    if (stock != null) {
      return stock['pricePerStock'];
    } else {
      return 0;
    }
  }
}