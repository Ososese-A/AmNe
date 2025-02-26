import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

class StockBox extends StatefulWidget {
  final String symbol;
  final String name;
  final String price;
  final String percent;
  final String change;
  final onTap;

  const StockBox({
    super.key,
    required this.symbol,
    required this.name,
    required this.price,
    required this.percent,
    required this.change,
    required this.onTap,
  });

  @override
  State<StockBox> createState() => _StockBoxState();
}

class _StockBoxState extends State<StockBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 40.0),
        decoration: BoxDecoration(
          color: customColors.app_dark_a,
          borderRadius: BorderRadius.circular(16.0)
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.symbol,
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 16.0
                  ),
                ),
                Container(
                  width: 200.0,
                  child: Text(
                    widget.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: customColors.app_white,
                      fontSize: 16.0
                    ),
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  widget.price,
                  style: TextStyle(
                    color: customColors.app_white,
                    fontSize: 16.0
                  ),
                ),
                Row(
                  children: [
                    Text(
                      widget.percent,
                      style: TextStyle(
                        color: double.parse(widget.percent) < 0 ? customColors.app_red : customColors.app_green,
                        fontSize: 16.0
                      ),
                    ),
      
                    SizedBox(width: 24.0,),
      
                    Text(
                      widget.change,
                      style: TextStyle(
                        color: double.parse(widget.percent) < 0 ? customColors.app_red : customColors.app_green,
                        fontSize: 16.0
                      ),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}