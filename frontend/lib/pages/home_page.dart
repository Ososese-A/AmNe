import 'package:flutter/material.dart';
import 'package:frontend/add_ons/borderless_btn.dart';
import 'package:frontend/add_ons/main_app_bar.dart';
import 'package:frontend/add_ons/pin_dot.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/components/portfolio_box.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final bool isAccountSetUp = true;
  bool obscure = false;

  void _hiddenToggle () {
    setState(() {
      obscure = !obscure;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: main_app_bar(context),
      body: Column(
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
                Text("0.0000 ETN", style: TextStyle(color: customColors.app_white, fontSize: 24.0),)
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
                
                borderless_btn("View Account",() => setMainPageWithData(context, '/main', '/main', 2)) 
                
                : 
                
                borderless_btn("Set Up Account", () => next(context, "/accountSetup"))
              ],
            ),
          ),

          SizedBox(height: 80.0,),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 12.0),
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

                Container(
                  height: 440.0,
                  child: Column(
                    
                    children: [
                      Expanded(
                        child: PortfolioBox(
                          customize: true,
                          count: 4,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}