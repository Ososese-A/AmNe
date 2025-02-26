import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/kyc_upload_field.dart';
import 'package:frontend/themes/theme.dart';

class KycUploadPage extends StatefulWidget {
  const KycUploadPage({super.key});

  @override
  State<KycUploadPage> createState() => _KycUploadPageState();
}

class _KycUploadPageState extends State<KycUploadPage> {
final TextEditingController uploadController = TextEditingController();
final String uploadError  = "";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Account Setup"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(height: 28.0,),
            KycUploadField(),

            SizedBox(height: 40.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                btn("Done", false, () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}