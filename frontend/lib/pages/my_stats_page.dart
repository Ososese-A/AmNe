import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/themes/theme.dart';

class MyStatsPage extends StatefulWidget {
  const MyStatsPage({super.key});

  @override
  State<MyStatsPage> createState() => _MyStatsPageState();
}

class _MyStatsPageState extends State<MyStatsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'My Stats'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 28.0,),
              Column(
                children: [
                  Text(
                    'Your App Stats',
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 36.0
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Container(
                    width: 380.0,
                    child: Text(
                      'You’re one of the most valued users of Amne.Thank you for investing with us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 72.0,),
          
              Column(
                children: [
                  Text(
                    'Number of Stocks Purchased',
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 20.0
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Container(
                    width: 380.0,
                    child: Text(
                      '126700.87',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 56.0,),
          
              Column(
                children: [
                  Text(
                    'Number of Stocks Sold',
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 20.0
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Container(
                    width: 380.0,
                    child: Text(
                      '126100.23',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 56.0,),
          
              Column(
                children: [
                  Text(
                    'Total amount invested',
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 20.0
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Container(
                    width: 380.0,
                    child: Text(
                      '22,413,568.79 NGN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 56.0,),
          
              Column(
                children: [
                  Text(
                    'Total amount withdrawn',
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 20.0
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Container(
                    width: 380.0,
                    child: Text(
                      '27,533,789.62 NGN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                ],
              ),
          
              SizedBox(height: 56.0,),
          
              Column(
                children: [
                  Text(
                    'Overall Cashflow',
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 20.0
                    ),
                  ),
                  SizedBox(height: 16.0,),
                  Container(
                    width: 380.0,
                    child: Text(
                      '32,433,588.72 NGN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 16.0
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 56.0,),
            ],
          ),
        ),
      ),
    );
  }
}