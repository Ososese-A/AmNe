import 'package:flutter/material.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:hive/hive.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String j = "";
  String u = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    j = getJ();
    u = getU();

    print(j.runtimeType);
    print(u.runtimeType);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(j),
            Text(u),
          ],
        ),
      ),
    );
  }
}