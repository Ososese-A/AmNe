import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

class KycUploadField extends StatefulWidget {
  const KycUploadField({super.key});

  @override
  State<KycUploadField> createState() => _KycUploadFieldState();
}

class _KycUploadFieldState extends State<KycUploadField> {
  final bool uploaded = false;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      height: 200.0,
      width: 370,
      decoration: BoxDecoration(
        border: Border.all(
          color: customColors.app_white,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
        child: uploaded

        ?

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            svg_box(28.0, 28.0, 'assets/icons/checked.svg'),

            SizedBox(height: 16.0,),

            Text(
              "Uploaded",
              style: TextStyle(color: customColors.app_white, fontSize: 16.0),
            ),
          ],
        )

        :

        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            svg_box(28.0, 28.0, 'assets/icons/upload.svg'),
            SizedBox(height: 16.0,),
            Text(
              "Upload a valid ID",
              style: TextStyle(color: customColors.app_white, fontSize: 16.0),
            ),
            SizedBox(height: 16.0,),
            Text(
              "(International Passport, ID Card, Driver’s license)",
              textAlign: TextAlign.center,
              style: TextStyle(color: customColors.app_white, fontSize: 12.0),
            ),
            SizedBox(height: 16.0,),
            Text(
              "Maximum size of 2MB",
              style: TextStyle(color: customColors.app_white, fontSize: 12.0),
            ),
          ],
        )
    );
  }
}