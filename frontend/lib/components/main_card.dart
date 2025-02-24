import 'package:flutter/material.dart';
import 'package:frontend/themes/theme.dart';

class MainCard extends StatefulWidget {
  final Row firstLine;
  final Row secondLine;
  final Row thirdLine;

  const MainCard({
    super.key,
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine
  });

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 32.0
      ),
      decoration: BoxDecoration(
        color: customColors.app_neutral,
        borderRadius: BorderRadius.circular(16.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.firstLine,
          SizedBox(height: 20.0,),
          widget.secondLine,
          SizedBox(height: 20.0,),
          widget.thirdLine,
        ],
      ),
    );
  }
}