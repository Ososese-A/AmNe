import 'package:flutter/material.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/notifiers/currency_notifier.dart';
import 'package:frontend/themes/theme.dart';
import 'package:provider/provider.dart';

class CurrencyBadge extends StatefulWidget {

  const CurrencyBadge({
    super.key,
  });

  @override
  State<CurrencyBadge> createState() => _CurrencyBadgeState();
}

class _CurrencyBadgeState extends State<CurrencyBadge> {
  @override
  Widget build(BuildContext context) {
    String currency = Provider.of<CurrencyNotifier>(context).currency;

    void _setCurrency (String newCurrency) {
      Provider.of<CurrencyNotifier>(context, listen: false).setCurrency(newCurrency);
    }


    return GestureDetector(
      onTap: () => pop_up(
        ctx: context,
        txt: 'Which Currency would you like to set as your default fiat currency?',
        minor: false,
        exemption: true,
        primaryBtn: true,
        primaryBtnTxt: 'NGN',
        primaryBtnOnTap: () {
          _setCurrency('NGN');
        },
        secondaryBtn: true,
        secondaryBtnTxt: 'USD',
        secondaryBtnOnTap: () {
          _setCurrency('USD');
        }
      ),
      child: Container(
        decoration: BoxDecoration(
          color: customColors.app_dark_a,
          borderRadius: BorderRadius.circular(8.0)
        ),
        height: 40.0,
        width: 72.0,
        child: Center(
          child: Text(
            currency,
            style: TextStyle(
              color: customColors.app_white,
              fontSize: 16.0
            ),
          ),
        ),
      ),
    );
  }
}