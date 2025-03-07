import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

class SharesBox extends StatefulWidget {
  final String symbol;
  final String name;
  final onTap;

  const SharesBox({
    super.key,
    required this.symbol,
    required this.name,
    required this.onTap,
  });

  @override
  State<SharesBox> createState() => _SharesBoxState();
}

class _SharesBoxState extends State<SharesBox> {
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
                  width: 300.0,
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
          ],
        ),
      ),
    );
  }
}