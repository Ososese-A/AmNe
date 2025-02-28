import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

class FaqBox extends StatefulWidget {
  final String faqTitle;
  final String faqTxt;
  const FaqBox({
    super.key,
    required this.faqTitle,
    required this.faqTxt,
  });

  @override
  State<FaqBox> createState() => _FaqBoxState();
}

class _FaqBoxState extends State<FaqBox> {
  bool hidden = true;

  _toggle () {
    setState(() {
      hidden = !hidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 370.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 300.0,
                child: Text(
                  widget.faqTitle,
                  style: TextStyle(
                    fontSize: 20.0, 
                    color:  customColors.app_white
                  ),
                ),
              ),

              GestureDetector(
                onTap: _toggle,
                child: hidden ? svg_box(24.0, 24.0, 'assets/icons/down_arrow.svg') : svg_box(24.0, 24.0, 'assets/icons/up_arrow.svg'),
              )
            ],
          ),

          SizedBox(height: 20.0,),

          hidden
          ?
          SizedBox.shrink()
          :
          Text(
            widget.faqTxt,
            style: TextStyle(
              fontSize: 16.0, 
              color:  customColors.app_white
            ),
          )
        ],
      ),
    );
  }
}