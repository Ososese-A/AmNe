import 'package:flutter/material.dart';
import 'package:frontend/add_ons/pop_up.dart';
import 'package:frontend/model/accountModel.dart';
import 'package:frontend/model/historyModel.dart';
import 'package:frontend/utilities/authUtility.dart';
import 'package:frontend/utilities/navigatorUtility.dart';

Future<void> getWalletInfo({required Walletmodel walletModel, required HistoryModel historyModel, required BuildContext ctx}) async {
          final backendResponse = await getWallet(type: 'wallet');

          if (backendResponse["isThereError"]) {
            return pop_up(
              ctx: ctx,
              txt: backendResponse["error"],
              primaryBtn: true,
              primaryBtnTxt: "Retry",
              primaryBtnOnTap: () => next(ctx, '/epin'),
            );
          } else {
              if (!(backendResponse["isAccountSetUp"])) {
                final rate = 0.0;
                final etnValue = 0.0;
                final toNaira = rate * etnValue;
                final toDollars = etnValue;

                walletModel.updateWalletInfo(
                  newAddress: "User's Wallet Address", 
                  newBalance: 0, 
                  newBalanceInNaira: toNaira, 
                  newBalanceInDollars: toDollars,
                  newRate: rate,
                  newEtenValue: etnValue
                );

          return pop_up(
            ctx: ctx,
            txt: "Welcome to our platform! 🚀 To unlock all the exciting features and benefits we offer, please take a moment to set up your account. It's quick, easy, and will ensure you get the best experience possible.",
            primaryBtn: true,
            primaryBtnTxt: "Setup Account",
            primaryBtnOnTap: () => next(ctx, "/accountSetup"),
          );
          } else {
            final rate = backendResponse['rate'] + 0.0;
            final etnValue = backendResponse['etnValue'] + 0.0;
            final toNaira = rate * etnValue;
            final toDollars = etnValue;

            walletModel.updateWalletInfo(
              newAddress: backendResponse['address'], 
              newBalance: backendResponse['balance'], 
              newBalanceInNaira: toNaira, 
              newBalanceInDollars: toDollars,
              newRate: rate,
              newEtenValue: etnValue
            );

            historyModel.updateHistoryInfo(
              newTransactionHistory: backendResponse["financialsinfo"]["transactionHistory"],
              newOrderHistory: backendResponse["financialsinfo"]["orderHistory"],
              newPortfolio: backendResponse["financialsinfo"]["portfolio"],
            );

            //pop up for beta version
            pop_up(
              ctx: ctx, 
              txt: "Welcome to our beta mode! 🚀Please note that during this phase, you can only transact with test Electroneum (ETN). Avoid depositing or transacting with real Electroneum as it won't be processed.Thank you for your understanding and participation!",
              primaryBtn: true,
              primaryBtnTxt: "Got it",
              primaryBtnOnTap: () {},
              minor: true
              );
          }
        }
      }
