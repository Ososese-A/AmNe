import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/add_ons/toast_simulate.dart';

void copy_to_clipboard(BuildContext ctx, String text) {
  Clipboard.setData(ClipboardData(text: text));
  print('Copied to clipboard: $text'); // You can replace this with a toast or another UI indication
  toast_simulate(ctx, 'Wallet address copied!');
}