import 'package:flutter/material.dart';

class MainCard extends StatefulWidget {
  final Row firstLine;
  final Row secondLine;
  final Row thirdLine;
  final Row forthLine;
  final Row fifthLine;
  final bool extend;
  final Color backgroundColor;

  const MainCard({
    super.key,
    required this.firstLine,
    required this.secondLine,
    required this.thirdLine,
    this.backgroundColor = const Color(0xff3A506B),
    this.extend = false,
    this.forthLine = const Row(children: [],),
    this.fifthLine = const Row(children: [],)
  });

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 32.0
      ),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(16.0)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.extend ? SizedBox(height: 24.0,) : SizedBox(height: 0,),
          widget.firstLine,
          SizedBox(height: 20.0,),
          widget.secondLine,
          SizedBox(height: 20.0,),
          widget.thirdLine,
          widget.extend 

          ?

          Column(
            children: [
              SizedBox(height: 20.0,),
              widget.forthLine,
              SizedBox(height: 20.0,),
              widget.fifthLine,
            ],
          )

          :

          Column(
            children: [
            ],
          )
        ],
      ),
    );
  }
}