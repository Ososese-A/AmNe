import 'package:flutter/material.dart';
import 'package:frontend/add_ons/borderless_btn.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/add_ons/main_app_bar.dart';
import 'package:frontend/add_ons/pin_dot.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/add_ons/value_to_decimal.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/components/portfolio_box.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/model/historyModel.dart';
import 'package:frontend/notifiers/account_setup_notifier.dart';
import 'package:frontend/notifiers/currency_notifier.dart';
import 'package:frontend/notifiers/obscure_notifier.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/helperUtilities.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {

  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool? obscure;
  bool isLoading = false;

  void _hiddenToggle () {
    Provider.of<ObscureNotifier>(context, listen: false).setObscureValue(!obscure!);
  }


  void _refreshPage () async {
      setState(() {
        isLoading = true;
      });

      Provider.of<HistoryModel>(context, listen: false).fetchAndUpdateStockNumbers(forceUpdate: true);
      print("Step 1 done");
      final wallet = Provider.of<Walletmodel>(context, listen: false);
      print("Step 2 done");
      final history = Provider.of<HistoryModel>(context, listen: false);
      print("Step 3 done");
      await getWalletInfo(walletModel: wallet, historyModel: history, ctx: context);

      setState(() {
        isLoading = false;
      });
    }

    


  @override
  Widget build(BuildContext context) {
    final wallet = Provider.of<Walletmodel>(context);
    final currency = Provider.of<CurrencyNotifier>(context).currency;
    final isAccountSetUp = Provider.of<isAccountSetUpNotifier>(context).isAccountSetUp;
    final portfolioCOunt = Provider.of<HistoryModel>(context).portfolio;
    obscure = Provider.of<ObscureNotifier>(context).obscure;

        
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: main_app_bar(context, _refreshPage),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                MainCard(
                  firstLine: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Account", style: TextStyle(color: customColors.app_white, fontSize: 16.0),),
                      GestureDetector(
                        onTap: _hiddenToggle,
                        child: obscure!
            
                        ?
            
                        svg_box(24.0, 24.0, 'assets/icons/unobscure.svg')
            
                        :
            
                        svg_box(24.0, 24.0, 'assets/icons/obscure.svg')
                      ),
                    ],
                  ),
                  secondLine: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      obscure!
                      ?
                      Row(
                        children: [
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                          SizedBox(width: 8,),
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                          SizedBox(width: 8,),
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                          SizedBox(width: 8,),
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                          SizedBox(width: 8,),
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                          SizedBox(width: 8,),
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                          SizedBox(width: 8,),
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                          SizedBox(width: 8,),
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                        ],
                      )
                      :
                      Text(
                        "${value_to_delimal(value: wallet.balance, type: true)} ETN", 
                        style: TextStyle(color: customColors.app_white, fontSize: 24.0),
                      )
                    ],
                  ),
                  thirdLine: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      obscure!
                      ?
                      Row(
                        children: [
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                          SizedBox(width: 8,),
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                          SizedBox(width: 8,),
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                          SizedBox(width: 8,),
                          pin_dot(active: true,  dotColor: true, height: 12.0, width: 12.0),
                        ],
                      )
                      :
                      Text(
                        currency == "USD"
                        ?
                        "\$${value_to_delimal(value: wallet.balanceInDollars, type: false)}"
                        :
                        "₦${value_to_delimal(value: wallet.balanceInNaira, type: false)}",
                        style: TextStyle(fontSize: 16.0, color:  customColors.app_white),
                      ),
                      
                      isAccountSetUp 
                      
                      ? 
                      
                      borderless_btn("View Account",() => setMainAsMainPageWithData(context, 1)) 
                      
                      : 
                      
                      borderless_btn("Set Up Account", () => next(context, "/accountSetup"))
                    ],
                  ),
                ),
            
                SizedBox(height: 40.0,),
            
                Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Portfolio",
                            style: TextStyle(
                              color: customColors.app_white,
                              fontSize: 20.0
                            ),
                          ),
            
                          SizedBox(height: 20.0,),
            
                          borderless_btn("View Portfolio", () => next(context, "/portfolio"))
                        ],
                      ),
            
                      SizedBox(height: 20.0,),
            
                      SizedBox(
                        height: 440.0,
                        child: Column(
                          
                          children: [
                            PortfolioBox(
                                customize: true,
                                count: portfolioCOunt.length >= 4 ? 4 : portfolioCOunt.length,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
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