import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/borderless_btn.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

class GetHelpPage extends StatefulWidget {
  const GetHelpPage({super.key});

  @override
  State<GetHelpPage> createState() => _GetHelpPageState();
}

class _GetHelpPageState extends State<GetHelpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'Get Help'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            SizedBox(height: 28.0,),
            borderless_btn('Frequently Asked Questions (FAQs)', () => next(context, '/faq')),
            SizedBox(height: 40.0,),
            borderless_btn('Contact Us', () => next(context, '/contact')),
          ],
        ),
      ),
    );
  }
}