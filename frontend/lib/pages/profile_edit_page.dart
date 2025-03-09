import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/components/input_field.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/themes/theme.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:provider/provider.dart';

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  String lnameErr = "";
  TextEditingController lnameController = TextEditingController();

  String fnameErr = "";
  TextEditingController fnameController = TextEditingController();

  String phoneErr = "";
  TextEditingController phoneController = TextEditingController();

  String addressErr = "";
  TextEditingController addressController = TextEditingController();

  void _editSetUp () async {
    String lData = lnameController.text;
    String fData = fnameController.text;
    String mData = phoneController.text;
    String aData = addressController.text;

    if (lData == '' || fData == '' || mData == '' || aData == ''){
      setState(() {
        fnameController.text = Provider.of<Accountmodel>(context).firstName;
        lnameController.text = Provider.of<Accountmodel>(context).lastName;
        phoneController.text = Provider.of<Accountmodel>(context).mobile;
        addressController.text = Provider.of<Accountmodel>(context).address;
      });
    } else {
      final backendResponse = await accountAuth(firstName: fData, lastName: lData, mobile: mData, address: aData, type: 'setup');
      if  (backendResponse['isThereError']) {
        setState(() {
          fnameErr = backendResponse['fnameErr'];
          lnameErr = backendResponse['lnameErr'];
          phoneErr = backendResponse['phoneErr'];
          addressErr = backendResponse['addressErr'];
        });
      } else {
        Navigator.pop(context);
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    lnameController.dispose();
    fnameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    lnameController.text = Provider.of<Accountmodel>(context).lastName;
    fnameController.text = Provider.of<Accountmodel>(context).firstName;
    phoneController.text = Provider.of<Accountmodel>(context).mobile;
    addressController.text = Provider.of<Accountmodel>(context).address;

    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, "Profile Edit"),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0),
        child: Column(
          children: [
            SizedBox(height: 28.0,),
            InputField(
              placeholder: 'Last Name', 
              iconPath: 'assets/icons/profile_normal.svg', 
              type: 'normal', 
              error: lnameErr, 
              fieldHeight: 140.0, 
              errorHeight: 40.0, 
              controller: lnameController
            ),

            InputField(
              placeholder: 'First Name', 
              iconPath: 'assets/icons/profile_normal.svg', 
              type: 'normal', 
              error: fnameErr, 
              fieldHeight: 140.0, 
              errorHeight: 40.0, 
              controller: fnameController
            ),

            InputField(
              placeholder: 'Mobile', 
              iconPath: 'assets/icons/phone.svg', 
              type: 'normal', 
              error: phoneErr, 
              fieldHeight: 140.0, 
              errorHeight: 40.0, 
              controller: phoneController
            ),

            InputField(
              placeholder: 'Address', 
              iconPath: 'assets/icons/address.svg', 
              type: 'address', 
              error: addressErr, 
              fieldHeight: 180.0, 
              errorHeight: 40.0, 
              controller: addressController
            ),

            SizedBox(height: 40.0,),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                btn("Done", false, _editSetUp),
              ],
            )
          ],
        ),
      ),
    );
  }
}