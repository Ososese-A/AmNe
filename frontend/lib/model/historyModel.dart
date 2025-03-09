import 'package:flutter/material.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:provider/provider.dart';

class HistoryModel extends ChangeNotifier {
  List _transactionHistory = [];
  List _orderHistory = [];
  List _portfolio = [];
  bool _isTransactionHistoryEmpty = true;
  bool _isPortfolioEmpty = true;
  bool _isFetching = false;

  List get transactionHistory => _transactionHistory;
  List get orderHistory=> _orderHistory;
  List get portfolio => _portfolio;
  bool get isTransactionHistoryEmpty => _isTransactionHistoryEmpty;
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
    _isTransactionHistoryEmpty = _transactionHistory.isEmpty;
    notifyListeners();
  }

  Future<void> fetchAndUpdateStockNumbers({bool forceUpdate = false}) async {
    if (_isFetching) return;
    _isFetching = true;

    try {
      for (var stock in _portfolio) {
      if (!forceUpdate && stock['regularMarketPrice'] != null) {
        continue;
      }

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


    double getTotalPortfolioValue(BuildContext ctx) {
      return _portfolio.fold(0.0, (total, stock) {
        final etnValue = Provider.of<Walletmodel>(ctx).etnValue;
        double stockValue = ((stock['regularMarketPrice'] ?? 0)/ etnValue) * (stock['noOfStocks'] ?? 0);
        print("From the getTotalPortfolio value This is the current price ${stock['regularMarketPrice']}");
        print("From the getTotalPortfolio value This is the no of stocks ${stock['noOfStocks'] ?? 0}");
        print("From the getTotalPortfolio value This is the stock value $stockValue");
        return total + stockValue;
      });
    }

    double getTotalProfitOrLoss(BuildContext ctx) {
      return _portfolio.fold(0.0, (total, stock) {
        final etnValue = Provider.of<Walletmodel>(ctx).etnValue;
        double quantity = stock['noOfStocks'] ?? 0;
        double pricePerStock = ((stock['pricePerStock'] ?? 0));
        double currentPrice = ((stock['regularMarketPrice'] ?? 0)) / etnValue;
        print("This is current price $currentPrice");
        print("This is price per stock $pricePerStock");
        print("This is quantity $quantity");
        double profitOrLoss = (currentPrice - pricePerStock);
        return total + profitOrLoss;
      });
    }

    int getNumberOfStocks() {
      return _portfolio.length;
    }
}