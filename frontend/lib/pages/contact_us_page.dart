import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'Contact Us'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(height: 28.0,),
            Container(
              width: 370.0,
              child: Text(
                'If you need help or you have a question for us that was not answered in the FAQs section feel free to reach out to us via:',
                style: TextStyle(
                  fontSize: 16.0, 
                  color:  customColors.app_white
                ),
              ),
            ),
            SizedBox(height: 40.0,),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      Text(
                        'Email:',
                        style: TextStyle(
                          color: customColors.app_white,
                          fontSize: 16.0
                        ),
                      ),
                      SizedBox(width: 32.0,),
                      Text(
                        'contact.amne@gmail.com',
                        style: TextStyle(
                          color: customColors.app_white,
                          fontSize: 16.0
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 16.0,),

                  GestureDetector(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Copy Email",
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
              )
            )
          ],
        ),
      ),
    );
  }
}