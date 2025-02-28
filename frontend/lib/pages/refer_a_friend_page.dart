import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

class ReferAFriendPage extends StatefulWidget {
  const ReferAFriendPage({super.key});

  @override
  State<ReferAFriendPage> createState() => _ReferAFriendPageState();
}

class _ReferAFriendPageState extends State<ReferAFriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'Refer a Friend'),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 28.0,),
          Container(
            child: Column(
              children: [
                Text(
                  '0',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36.0, 
                    color:  customColors.app_white
                  ),
                ),

                SizedBox(height: 16.0,),

                Text(
                  'Completed Invites',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0, 
                    color:  customColors.app_white
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 40.0,),

          Container(
            width: 316.0,
            child: Text(
              'Refer a friend and get 2 transactions without any transaction fees.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0, 
                color:  customColors.app_white
              ),
            ),
          ),

          SizedBox(height: 40.0,),

          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Your referral code is: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0, 
                    color:  customColors.app_white
                  ),
                ),

                SizedBox(height: 24.0,),

                Text(
                  'contz9ZHBahg7qKXxgthu8eP3ABP7k3ra5WH',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12.0, 
                    color:  customColors.app_white
                  ),
                ),

                SizedBox(height: 24.0,),

                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Copy Referral Code",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: customColors.app_white,
                            fontSize: 16.0
                          ),
                        ),
      
                        SizedBox(width: 8.0,),
      
                        svg_box(24.0, 24.0, "assets/icons/copy.svg")
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(height: 50.0,),
          
          btn('Done', false, () {
            Navigator.pop(context);
          })
        ],
      ),
    );
  }
}