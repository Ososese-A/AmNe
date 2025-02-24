import 'package:flutter/material.dart';
import 'package:frontend/add_ons/svg_box.dart';
import 'package:frontend/themes/theme.dart';

class StockSearch extends StatefulWidget {
  final TextEditingController controller;
  final String placeHolder;
  final onTap;

  const StockSearch({
    super.key,
    required this.controller,
    required this.placeHolder,
    required this.onTap,
  });

  @override
  State<StockSearch> createState() => _StockSearchState();
}

class _StockSearchState extends State<StockSearch> {
  @override
  Widget build(BuildContext context) {
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
            Expanded(
              child: TextField(
                controller: widget.controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.placeHolder,
                  hintStyle: TextStyle(color: customColors.app_white),
                ),
                style: TextStyle(color: customColors.app_white),
                cursorColor: customColors.app_light_a,
              ),
            ),
            SizedBox(width: 16.0,),
            GestureDetector(
              child: svg_box(24.0, 24.0, 'assets/icons/search.svg'),
              onTap: widget.onTap,
            ),
          ],
        )
      ),
    );
  }
}