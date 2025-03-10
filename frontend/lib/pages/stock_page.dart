import 'package:flutter/material.dart';
import 'package:frontend/add_ons/empty_msg.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/add_ons/main_app_bar.dart';
import 'package:frontend/components/currency_badge.dart';
import 'package:frontend/components/search_bar.dart';
import 'package:frontend/components/shares_box.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class StockPage extends StatefulWidget {
  const StockPage({super.key});

  @override
  State<StockPage> createState() => _StockPageState();
}

class _StockPageState extends State<StockPage> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool stockNotFound = false;
  bool isLoading = false;
  int page = 1;
  int limit = 5;
  List _stocks = [];
  List _filteredStocks = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchMoreStocks();
    // _scrollController.addListener(_loadMoreStocks);
    _searchController.addListener(_filterStocks);

    // getStockList(type: "nasdaq");
    // _filteredStocks = _stocks.take(_loadedItemCOunt).toList();
    // _scrollController.addListener(_loadMoreStocks);
  }

  Future<void> fetchMoreStocks() async {
    if (isLoading || _stocks.isNotEmpty || _filteredStocks.isNotEmpty) return;

    setState(() {
      isLoading = true;
    });

    try {
      final result = await getStockList(type: "fetchStocks", page: page, limit: limit);
      setState(() {
        _stocks.addAll(result['assets']);
        _filteredStocks = _stocks;
        stockNotFound = _filteredStocks.isEmpty;
      });
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // void _loadMoreStocks () {
  //   if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
  //     fetchMoreStocks();
  //   }
  // }

  // void _filterStocks() {
  //   final query = _searchController.text.toLowerCase();
  //   if (query.isEmpty) {
  //     setState(() {
  //       _filteredStocks = _stocks;
  //       stockNotFound = false;
  //     });
  //   } else {
  //       setState(() {
  //         _filteredStocks = _stocks.where((stock) {
  //           final stockName = stock['name'].toLowerCase();
  //           final stockSymbol = stock['symbol'].toLowerCase();
  //           return stockName.contains(query) || stockSymbol.contains(query);
  //         }).toList();
  //         stockNotFound = _filteredStocks.isEmpty;
  //       });
  //   }
  // }

  void _filterStocks() {
  final query = _searchController.text.toLowerCase();
  setState(() {
    if (query.isEmpty) {
      _filteredStocks = _stocks;
      stockNotFound = false;
    } else {
      _filteredStocks = _stocks.where((stock) {
        final stockName = stock['name'].toLowerCase();
        final stockSymbol = stock['symbol'].toLowerCase();
        return stockName.contains(query) || stockSymbol.contains(query);
      }).toList();
      stockNotFound = _filteredStocks.isEmpty;
    }
  });
}

  @override
  void dispose() {
    // TODO: implement dispose
    _scrollController.dispose();
    super.dispose();
  }

  void _refreshPage () {
      fetchMoreStocks();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: main_app_bar(context, _refreshPage),
      body: Stack(
        children: [
          Padding(
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
          
                    CurrencyBadge()
                  ],
                ),
          
                SizedBox(height: 28.0,),
          
                StockSearch(
                  controller: _searchController, 
                  placeHolder: "Search for a stock", 
                  onTap: _filterStocks
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
                    controller: _scrollController,
                    itemCount: _filteredStocks.length,
                    itemBuilder: (context, index) {
                      // return StockBox(
                      //   symbol: _filteredStocks[index]['symbol'], 
                      //   name: _filteredStocks[index]['name'], 
                      //   price: _filteredStocks[index]['price'], 
                      //   percent: _filteredStocks[index]['percent'], 
                      //   change: _filteredStocks[index]['change'],
                      //   onTap: () => nextWithData(context, '/stockInfo', _filteredStocks[index]['symbol']),
                      // );
                      
          
                      return SharesBox(
                        symbol: _filteredStocks[index]['symbol'], 
                        name: _filteredStocks[index]['name'], 
                        onTap: () => nextWithData(context, '/stockInfo', _filteredStocks[index]['symbol'])
                      );
                    }
                  )
                )
              ],
            ),
          ),

           if (isLoading)
          loading_spinner()
        ],
      )
    );
  }
}