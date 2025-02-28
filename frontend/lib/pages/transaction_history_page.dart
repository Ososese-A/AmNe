import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/components/transaction_box.dart';
import 'package:frontend/themes/theme.dart';

class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'Transaction History'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TransactionBox()
          ],
        ),
      ),
    );
  }
}