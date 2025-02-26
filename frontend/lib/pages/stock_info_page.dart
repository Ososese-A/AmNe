import 'package:flutter/material.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/sec_app_bar.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class StockInfoPage extends StatefulWidget {
  const StockInfoPage({super.key});

  @override
  State<StockInfoPage> createState() => _StockInfoPageState();
}

class _StockInfoPageState extends State<StockInfoPage> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final String stockData = ModalRoute.of(context)!.settings.arguments as String? ?? 'SYMB';

    bool isInPortfolio = true;

     void _expansionToggle () {
      setState(() {
        isExpanded = !isExpanded;
      });
     }

    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: sec_app_bar(context, "Stock Info"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:  16.0),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "Apple Inc",
                    style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 40.0
                      ),
                  ),
          
                  SizedBox(height: 12.0,),
          
                  Text(
                    "($stockData)",
                    style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 20.0
                      ),
                  ),
                ],
              ),

              SizedBox(height: 36.0,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "356 USD",
                    style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 20.0
                      ),
                  ),
          
                  Row(
                    children: [
                      Text(
                        "-1.2%",
                        style: TextStyle(
                            color: customColors.app_red,
                            fontSize: 16.0
                          ),
                      ),
          
                      SizedBox(width: 16.0,),
                      
                      Text(
                        "-5.00",
                        style: TextStyle(
                            color: customColors.app_red,
                            fontSize: 16.0
                          ),
                      ),
                    ],
                  ),
                ],
              ),

              isInPortfolio

              ?

              Column(
                children: [
                  SizedBox(height: 36.0,),

                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No of stocks owned:",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 20.0
                              ),
                          ),
                          Text(
                            "24.97",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 16.0
                              ),
                          ),
                        ],
                      ),

                      SizedBox(height: 36.0,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total profit/loss:",
                            style: TextStyle(
                                color: customColors.app_white,
                                fontSize: 20.0
                              ),
                          ),
                          Text(
                            "+ 13 USD",
                            style: TextStyle(
                                color: customColors.app_green,
                                fontSize: 16.0
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 36.0,),
                ],
              )

              :

              SizedBox(height: 36.0,),

              Text(
                'Apple Inc. designs, manufactures and markets smartphones, personal computers, tablets, wearables and accessories, and sells a variety of related services. Its product categories include iPhone, Mac, iPad, and Wearables, Home and Accessories. Its software platforms include iOS, iPadOS, macOS, watchOS, visionOS, and tvOS. Its services include advertising, AppleCare, cloud services, digital content and payment services. The Company operates various platforms, including the App Store, that allow customers to discover and download applications and digital content, such as books, music, video, games and podcasts. It also offers digital content through subscription-based services, including Apple Arcade, Apple Fitness+, Apple Music, Apple News+, and Apple TV+. Its products include iPhone 16 Pro, iPhone 16, iPhone 15, iPhone 14, iPhone SE, MacBook Air, MacBook Pro, iMac, Mac mini, Mac Studio, Mac Pro, iPad Pro, iPad Air, AirPods, AirPods Pro, AirPods Max, Apple TV and Apple Vision Pro.',
                overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                maxLines: isExpanded ? null : 10,
                style: TextStyle(
                  color: customColors.app_white,
                  fontSize: 16.0
                ),
              ),

              GestureDetector(
                onTap: _expansionToggle,
                child: Text(
                  isExpanded ? "Show Less" : "Show More",
                  style: TextStyle(
                    color: customColors.app_light_a,
                    fontSize: 16.0
                ),
                ),
              ),

              SizedBox(height: 36.0,),

              btn('Buy', false, () => next(context, '/buy')),

              isInPortfolio 
              
              ?

              Column(
                children: [
                  SizedBox(height: 36.0,),

                  btn('Sell', true, () => next(context, '/sell')),
                  
                  SizedBox(height: 36.0,),
                ],
              )

              :

              SizedBox(height: 36.0,)
            ],
          ),
        ),
      ),
    );
  }
}