import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

class InputField extends StatefulWidget {
  final String placeholder;
  final String iconPath;
  final String type;
  final String error;
  final double fieldHeight;
  final double errorHeight;
  final TextEditingController controller;
  final bool isItBuy;
  final bool forgotPassword;
  final VoidCallback? forgotPasswordAction;
  final bool isItEnabled;
  final VoidCallback? disabledCallback;
  final VoidCallback? setMaxAmount;
  final FocusNode? focusNode;

  InputField({
    required this.placeholder, 
    required this.iconPath, 
    required this.type, 
    required this.error,
    required this.fieldHeight,
    required this.errorHeight,
    required this.controller,
    this.isItBuy = false,
    this.forgotPassword = false,
    this.forgotPasswordAction,
    this.isItEnabled = false,
    this.disabledCallback,
    this.setMaxAmount,
    this.focusNode
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool obscure = true;


  void _toggle() {
    setState(() {
      obscure = !obscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.fieldHeight,
      child: Column(
        children: [
          _field_selector(
            widget.type, 
            widget.placeholder, 
            widget.iconPath, 
            obscure, 
            _toggle,
            widget.controller,
            widget.isItBuy,
            widget.forgotPassword,
            widget.forgotPasswordAction,
            widget.isItEnabled,
            widget.disabledCallback,
            widget.setMaxAmount,
            widget.focusNode,
            context
          ),

          SizedBox(height: 16.0,),

          Container(
            width: double.infinity,
            height: widget.errorHeight,
            child: Text(
              widget.error,
              textAlign: TextAlign.left,
              style: TextStyle(
                color: customColors.app_red,
                fontSize: 14.0
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _field_selector(
  String type, 
  String placeHolder, 
  String iconPath, 
  bool obscure, 
  _toggle,
  TextEditingController controller,
  bool isItBuy,
  bool forgotPassword,
  VoidCallback? forgotPasswordAction,
  bool isItEnabled,
  VoidCallback? disabledCallback,
  VoidCallback? setMaxAmount,
  FocusNode? _focusNode,
  BuildContext ctx
) {

  switch (type) {
    case "password":
      return 
      forgotPassword 
      ?
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              height: 66.0,
              decoration: BoxDecoration(
                border: Border.all(
                  color: customColors.app_white,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child:
                  Row(
                      children: [
                        svg_box(28.0, 28.0, iconPath),
                        SizedBox(width: 16.0,),
                        Expanded(
                          child: TextField(
                            controller: controller,
                            obscureText: obscure,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: placeHolder,
                              hintStyle: TextStyle(color: customColors.app_white),
                            ),
                            style: TextStyle(color: customColors.app_white),
                            cursorColor: customColors.app_light_a,
                          ),
                        ),
                        SizedBox(width: 16.0,),
                        GestureDetector(
                          child: obscure
                            ? svg_box(28.0, 28.0, "assets/icons/obscure.svg")
                            : svg_box(28.0, 28.0, "assets/icons/unobscure.svg"),
                          onTap: _toggle,
                        ),
                      ],
                    ),
            ),

            SizedBox(height: 12.0,),

            GestureDetector(
              onTap: forgotPasswordAction,
              child: Text(
                'Forgot Password',
                style: TextStyle(
                  color: customColors.app_white,
                  fontSize: 16.0
                ),
              ),
            ),
          ],
        ),
      )
      :
      Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        height: 66.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: customColors.app_white,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child:
            Row(
                children: [
                  svg_box(28.0, 28.0, iconPath),
                  SizedBox(width: 16.0,),
                  Expanded(
                    child: TextField(
                      controller: controller,
                      obscureText: obscure,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: placeHolder,
                        hintStyle: TextStyle(color: customColors.app_white),
                      ),
                      style: TextStyle(color: customColors.app_white),
                      cursorColor: customColors.app_light_a,
                    ),
                  ),
                  SizedBox(width: 16.0,),
                  GestureDetector(
                    child: obscure
                      ? svg_box(28.0, 28.0, "assets/icons/obscure.svg")
                      : svg_box(28.0, 28.0, "assets/icons/unobscure.svg"),
                    onTap: _toggle,
                  ),
                ],
              ),
            )
      ;
    
    case "address":
      return Container(
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
        height: 120.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: customColors.app_white,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              svg_box(28.0, 28.0, iconPath),
              SizedBox(width: 16.0,),
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: placeHolder,
                    hintMaxLines: 3,
                    hintStyle: TextStyle(color: customColors.app_white),
                  ),
                  maxLines: 4,
                  style: TextStyle(color: customColors.app_white),
                  cursorColor: customColors.app_light_a,
                ),
              ),
            ],
          )
      );

    case "stock":
        if  (isItEnabled) {
            FocusScope.of(ctx).requestFocus(_focusNode);
          } else {
            _focusNode!.unfocus();
        }
      return 

      isItBuy

      ?
      
      Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      height: 66.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: customColors.app_light_b,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: Row(
          children: [
            svg_box(28.0, 28.0, iconPath),
            SizedBox(width: 16.0,),
            Expanded(
              child: TextField(
                focusNode: _focusNode,
                enabled: isItEnabled,
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: placeHolder,
                  hintStyle: TextStyle(color: customColors.app_light_b),
                ),
                style: TextStyle(color: customColors.app_light_b),
                cursorColor: customColors.app_light_a,
              ),
            ),
            SizedBox(width: 16.0,),
            GestureDetector(
              child: svg_box(28.0, 28.0, "assets/icons/edit.svg"),
              onTap: disabledCallback,
            ),
          ],
        )
      ),
    )

    :

    Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          height: 66.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: customColors.app_white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
              children: [
                svg_box(28.0, 28.0, iconPath),
                SizedBox(width: 16.0,),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: placeHolder,
                      hintStyle: TextStyle(color: customColors.app_white),
                    ),
                    style: TextStyle(color: customColors.app_white),
                    cursorColor: customColors.app_light_a,
                  ),
                ),
              ],
            )
          ),

          SizedBox(height: 16.0,),

          GestureDetector(
              onTap: setMaxAmount,
              child: Text(
                "Max",
                style: TextStyle(
                    color: customColors.app_light_a,
                    fontSize: 16.0
                ),
              ),
            )
        ],
      );

    case "amount":
      return Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          height: 66.0,
          decoration: BoxDecoration(
            border: Border.all(
              color: customColors.app_white,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Row(
              children: [
                svg_box(28.0, 28.0, iconPath),
                SizedBox(width: 16.0,),
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: placeHolder,
                      hintStyle: TextStyle(color: customColors.app_white),
                    ),
                    style: TextStyle(color: customColors.app_white),
                    cursorColor: customColors.app_light_a,
                  ),
                ),
              ],
            )
          ),

          SizedBox(height: 16.0,),

          GestureDetector(
              onTap: setMaxAmount,
              child: Text(
                "Max",
                style: TextStyle(
                    color: customColors.app_light_a,
                    fontSize: 16.0
                ),
              ),
            )
        ],
      );

    case "normal":
    default:
      return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      height: 66.0,
      decoration: BoxDecoration(
        border: Border.all(
          color: customColors.app_white,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Center(
        child: Row(
          children: [
            svg_box(28.0, 28.0, iconPath),
            SizedBox(width: 16.0,),
            Expanded(
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: placeHolder,
                  hintStyle: TextStyle(color: customColors.app_white),
                ),
                style: TextStyle(color: customColors.app_white),
                cursorColor: customColors.app_light_a,
              ),
            ),
          ],
        )
      ),
    );
  }
}