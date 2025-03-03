import 'package:flutter/material.dart';
import 'package:frontend/add_ons/borderless_btn.dart';
import 'package:frontend/add_ons/main_app_bar.dart';
import 'package:frontend/add_ons/pin_dot.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/add_ons/value_to_decimal.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/components/portfolio_box.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class HomePage extends StatefulWidget {
  final accountBalance;

  const HomePage({
    super.key,
    this.accountBalance = '0'
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool isAccountSetUp = getAS();
  bool obscure = false;

  void _hiddenToggle () {
    setState(() {
      obscure = !obscure;
    });
  }


  @override
  Widget build(BuildContext context) {
    print("This is the getAS value from home $isAccountSetUp");
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: main_app_bar(context),
      body: Padding(
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
                    child: obscure 
        
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
                  obscure
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
                    widget.accountBalance.runtimeType == String 
                    ? 
                    "${value_to_delimal(value: double.parse(widget.accountBalance), type: false)} ETN" 
                    : 
                    "${value_to_delimal(value: widget.accountBalance, type: true)} ETN", 
                    style: TextStyle(color: customColors.app_white, fontSize: 24.0),
                  )
                ],
              ),
              thirdLine: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  obscure
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
                    "₦0.00",
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
        
            SizedBox(height: 80.0,),
        
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
                            count: 4,
                          ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}