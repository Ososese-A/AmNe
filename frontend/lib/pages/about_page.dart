import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/themes/theme.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'About Amne'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 28.0,),
              Text(
                "Amne is more than just an app—it's a vision brought to life by 19-year-old Akhideno Ososese, who set out to tackle the barriers that have kept countless Nigerians from realizing their financial potential. With a deep passion for financial securities and an unwavering desire to empower others, Akhideno saw an opportunity to revolutionize how Nigerians access stocks and other financial investments.",
                style: TextStyle(
                  color: customColors.app_white,
                  fontSize: 16.0
                ),
              ),

              SizedBox(height: 64.0,),

              Text(
                "Born out of frustration with the bureaucracy, high capital requirements, and countless constraints of traditional methods, Amne reimagines financial accessibility. Built on the robust Electroneum blockchain, this innovative platform bridges the gap between traditional financial securities and the transformative power of cryptocurrency. Amne is designed to make investments simple, inclusive, and free from the challenges of currency devaluation and limited banking access.",
                style: TextStyle(
                  color: customColors.app_white,
                  fontSize: 16.0
                ),
              ),

              SizedBox(height: 64.0,),

              Text(
                "At its core, Amne is dedicated to creating opportunities for Nigerians to secure their savings and grow their wealth without the red tape. With this app, Akhideno aspires to provide a seamless and user-friendly financial management tool that empowers individuals to take control of their futures. Amne represents a bold step forward, proving that age is no barrier to innovation, and barriers to progress are meant to be broken. Join the movement. Take control of your financial journey. Experience Amne.",
                style: TextStyle(
                  color: customColors.app_white,
                  fontSize: 16.0
                ),
              ),
              SizedBox(height: 28.0,),
            ],
          ),
        ),
      ),
    );
  }
}