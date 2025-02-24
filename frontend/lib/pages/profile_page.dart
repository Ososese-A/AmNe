import 'package:flutter/material.dart';
import 'package:frontend/add_ons/badge_btn.dart';
import 'package:frontend/add_ons/borderless_btn.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/info_box.dart';
import 'package:frontend/add_ons/main_app_bar.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: main_app_bar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Column(
                  children: [
                    Image.asset("assets/images/profile_circle_a.png"),
          
                    SizedBox(height: 24.0,),
          
                    Text(
                      "Profile",
                      style: TextStyle(
                        color: customColors.app_white,
                        fontSize: 20.0
                      ),
                    ),

                    SizedBox(height: 28.0,),
                  ],
                ),
              ),
          
              MainCard(
                firstLine: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Akhideno Ososese", style: TextStyle(color: customColors.app_white, fontSize: 16.0),),
                    Text("08060808724", style: TextStyle(color: customColors.app_white, fontSize: 16.0),),
                  ],
                ), 
                secondLine: Row(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("akhidenoososese@gmail.com", style: TextStyle(color: customColors.app_white, fontSize: 16.0),),

                        SizedBox(height: 20.0,),

                        Container(
                          width: 324.0,
                          child: Text(
                            "3 Dodo street Off Challawa Crescent Kaduna", 
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: customColors.app_white, fontSize: 16.0),),
                        ),
                      ],
                    )
                  ],
                ), 
                thirdLine: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    borderless_btn("Edit", () => next(context, "/profileEdit"))
                  ],
                ), 
              ),

              SizedBox(height: 40.0,),
          
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    badge_btn("Reset pin"),
                    badge_btn("Reset password"),
                  ],
                ),
              ),

              SizedBox(height: 40.0,),
          
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    info_box("My Stats"),
                    SizedBox(height: 40.0,),
                    info_box("Settings"),
                    SizedBox(height: 40.0,),
                    info_box("Help"),
                    SizedBox(height: 40.0,),
                    info_box("Refer a Friend"),
                  ],
                ),
              ),

              SizedBox(height: 40.0,),

              btn("Logout", true, () {}),

              SizedBox(height: 40.0,),
            ],
          ),
        ),
      )
    );
  }
}