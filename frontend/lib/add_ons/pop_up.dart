import 'package:flutter/material.dart';
import 'package:frontend/add_ons/btn.dart';
import 'package:frontend/themes/theme.dart';

//'To Fund your account copy your wallet address and; \n\nDeposit Electroneum (ETN) from a different wallet \n\nOR \n\nBuy some from our recommended market place'

Future<void> pop_up ({
  required BuildContext ctx, 
  String txt = 'Sample message',
  bool minor = true,
  bool exemption = false,
  bool primaryBtn = false,
  String primaryBtnTxt = 'primary btn',
  VoidCallback? primaryBtnOnTap,
  bool secondaryBtn = false,
  String secondaryBtnTxt = 'seondary btn',
  VoidCallback? secondaryBtnOnTap
}) async {
  return showDialog(
    barrierColor: customColors.app_black,
    context: ctx, 
    barrierDismissible: minor,
    builder: (BuildContext ctx) {
      return AlertDialog(
        backgroundColor: customColors.app_dark_b,
        content: Container(
          width: 380.0,
          padding: EdgeInsets.symmetric(
            horizontal: 12.0,
            vertical: 28.0
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  txt,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0, 
                    color:  customColors.app_white
                  ),
                ),
                SizedBox(height: 32.0,),
                Container(
                  width: 246.0,
                  child: Column(
                    children: [
                      primaryBtn 
                      ?
                      btn(primaryBtnTxt, exemption ? true : false, () {
                        // if (primaryBtnOnTap != null) primaryBtnOnTap!();
                        Navigator.of(ctx).pop();
                        Future.delayed(Duration(milliseconds: 300), () {
                          if (primaryBtnOnTap != null) primaryBtnOnTap();
                        });
                      })
                      :
                      SizedBox.shrink(),

                      SizedBox(height: 16.0,),

                      secondaryBtn
                      ?
                      btn(secondaryBtnTxt, true, () {
                        // if (secondaryBtnOnTap != null) secondaryBtnOnTap!();
                        Navigator.of(ctx).pop();
                        Future.delayed(Duration(milliseconds: 300), () {
                          if (secondaryBtnOnTap != null) secondaryBtnOnTap();
                        });
                      })
                      :
                      SizedBox.shrink(),
                    ],
                  ),
                ),
              ],
            ),
        ),
      );
    }
  );
}

// Future<void> pop_up ({
//   required BuildContext ctx, 
//   String txt = '',
// }) async {
//   return showDialog(
//     // barrierColor: customColors.app_black,
//     context: ctx, 
//     barrierDismissible: false,
//     builder: (BuildContext ctx) {
//       return Dialog(
//         backgroundColor: Colors.transparent,
//         child: Container(
//           width: 380.0,
//           height: 600.0,
//           padding: EdgeInsets.symmetric(horizontal: 16.0),
//           decoration: BoxDecoration(
//             color: customColors.app_dark_b,
//             borderRadius: BorderRadius.circular(8.0)
//           ),
//           child: AlertDialog(
//             backgroundColor: ,
//             // title: Text('data'),
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: [
//                   Text('To Fund your account copy your wallet address and;'),
//                   Text('Deposit Electroneum (ETN) from a different wallet'),
//                   Text('OR'),
//                   Text('Buy some from our recommended market place'),
//                 ],
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop();
//                 }, 
//                 child: Text('OK')
//               )
//             ],
//           ),
//         ),
//       );
//     }
//   );
// }