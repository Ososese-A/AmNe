import 'package:flutter/material.dart';
import 'package:frontend/add_ons/app_bar.dart';
import 'package:frontend/components/faq_box.dart';
import 'package:frontend/themes/theme.dart';

class FaqPage extends StatefulWidget {
  const FaqPage({super.key});

  @override
  State<FaqPage> createState() => _FaqPageState();
}

class _FaqPageState extends State<FaqPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      appBar: app_bar(context, 'FAQs'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 28.0,),
              FaqBox(
                faqTitle: 'How to fund/add money to my account?',
                faqTxt: 'To fund your account you need to copy your wallet address from the wallet page and deposit or buy some Electroneum (ETN) into your account',
              ),
              SizedBox(height: 40.0,),
              FaqBox(
                faqTitle: 'Can I use fiat to fund my account?',
                faqTxt: 'At the moment you can not use fiat to fund your account, you need to fund your account with Electroneum (ETN)',
              ),
              SizedBox(height: 40.0,),
              FaqBox(
                faqTitle: 'Keeping your account safe',
                faqTxt: 'There are authentication mechanisms such as your pin and your password which have been set in place along with some other mechanisms in order to keep your account safe.',
              ),
              SizedBox(height: 40.0,),
              FaqBox(
                faqTitle: 'What happens if I fund my account with a crypto currency other than Electreoneum',
                faqTxt: 'Please do not do this. If you send a currency other than Electroneum (ETN) to your account it may be impossible to recover it. In the case this does happen reach out to us at contact.amne@gmail.com and we would do what we can to help you retrieve your funds.',
              ),
              SizedBox(height: 40.0,),
            ],
          ),
        ),
      ),
    );
  }
}