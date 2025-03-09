import 'package:flutter/material.dart';
import 'package:frontend/add_ons/badge_btn.dart';
import 'package:frontend/add_ons/borderless_btn.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/add_ons/info_box.dart';
import 'package:frontend/add_ons/loading_spinner.dart';
import 'package:frontend/add_ons/main_app_bar.dart';
import 'package:frontend/components/main_card.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = false;


  void _refreshPage () async {
      setState(() {
        isLoading = true;
      });

      final profileResponse = await getAccount(type: "getProfile");
      final firstName = profileResponse["firstName"];
      final lastName = profileResponse["lastName"];
      final email = profileResponse["email"];
      final mobile = profileResponse["mobile"];
      final address = profileResponse["address"];
      final quest = profileResponse["accountSecurity"][0]["securityQuestion"];
      Provider.of<Accountmodel>(context, listen: false).updateAccountInfo(
        newFirstName: firstName, 
        newLastName: lastName, 
        newEmail: email, 
        newMobile: mobile, 
        newAddress: address,
        newQuest: quest
      );

      setState(() {
        isLoading = false;
      });
    }


  @override
  Widget build(BuildContext context) {
    final firstName = Provider.of<Accountmodel>(context).firstName;
    final lastName = Provider.of<Accountmodel>(context).lastName;
    final email = Provider.of<Accountmodel>(context).email;
    final mobile = Provider.of<Accountmodel>(context).mobile;
    final address = Provider.of<Accountmodel>(context).address;


    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: main_app_bar(context, _refreshPage),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                        Text("$lastName $firstName", style: TextStyle(color: customColors.app_white, fontSize: 16.0),),
                        Text("$mobile", style: TextStyle(color: customColors.app_white, fontSize: 16.0),),
                      ],
                    ), 
                    secondLine: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("$email", style: TextStyle(color: customColors.app_white, fontSize: 16.0),),
            
                            SizedBox(height: 20.0,),
            
                            Container(
                              width: 324.0,
                              child: Text(
                                "$address", 
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
                        badge_btn("Reset pin", () => next(context, '/resetPinOne')),
                        badge_btn("Reset password", () => next(context, '/resetPasswordOne')),
                      ],
                    ),
                  ),
            
                  SizedBox(height: 40.0,),
              
                  Container(
                    child: Column(
                      children: [
                        // info_box("My Stats", () => next(context, '/stats')),
                        info_box("About Amne", () => next(context, '/about')),
                        SizedBox(height: 40.0,),
                        // info_box("Settings", () {}),
                        // SizedBox(height: 40.0,),
                        info_box("Get Help", () => next(context, '/gethelp')),
                        SizedBox(height: 40.0,),
                        // info_box("Refer a Friend", () => next(context, '/referral')),
                      ],
                    ),
                  ),
            
                  SizedBox(height: 40.0,),
            
                  btn("Logout", true, () {
                    setU("");
                    setA("");
                    setJ("");
                    setMainPage(context, "/intro", "/intro");
                  }),
            
                  SizedBox(height: 40.0,),
                ],
              ),
            ),

            if (isLoading)
            Positioned.fill(
              child: Container(
                child: Center(
                  child: loading_spinner(),
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}