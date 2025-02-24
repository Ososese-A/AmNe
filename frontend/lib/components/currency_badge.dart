import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

class CurrencyBadge extends StatefulWidget {
  final String text;

  const CurrencyBadge({
    super.key,
    required this.text
  });

  @override
  State<CurrencyBadge> createState() => _CurrencyBadgeState();
}

class _CurrencyBadgeState extends State<CurrencyBadge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: customColors.app_dark_a,
        borderRadius: BorderRadius.circular(8.0)
      ),
      height: 40.0,
      width: 72.0,
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(
            color: customColors.app_white,
            fontSize: 16.0
          ),
        ),
      ),
    );
  }
}