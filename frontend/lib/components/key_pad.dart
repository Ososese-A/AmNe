import 'package:flutter/material.dart';
import 'package:frontend/add_ons/key_btn.dart';

class KeyPad extends StatefulWidget {
  final ValueChanged<int> set;
  final ValueChanged<int> reset;
  final ValueChanged<String> get;
  final bool forgot;

  const KeyPad({
    super.key,
    required this.set,
    required this.reset,
    required this.get,
    this.forgot = false
});
  

  @override
  State<KeyPad> createState() => _KeyPadState();
}

class _KeyPadState extends State<KeyPad> {
    String dot_string = "";

    void _dot (number) {
        //check if the character passed is x
            //if it is x remove the last character from the string
            //if it is not x then add it to dot_string
                //if dot_string length is 4 then end this whole thing

        if (number == "x") {
            print("It was just x");
            if (dot_string.isNotEmpty) {
                dot_string = dot_string.substring(0, dot_string.length - 1);
                print(dot_string);
                widget.reset(dot_string.length);
            }
        } else {
            print(number);
            dot_string += number;
            print(dot_string);
            widget.set(dot_string.length);
            if (dot_string.length == 4) {
                print("Max length reached");
                widget.get(dot_string);
                dot_string = "";
            }
        }
    }

    void _forgot_dot (number) {
        //check if the character passed is x
            //if it is x remove the last character from the string
            //if it is not x then add it to dot_string
                //if dot_string length is 4 then end this whole thing

        if (number == "x") {
            print("It was just x");
            if (dot_string.isNotEmpty) {
                dot_string = dot_string.substring(0, dot_string.length - 1);
                print(dot_string);
                widget.reset(dot_string.length);
            }
        } else {
            print(number);
            dot_string += number;
            print(dot_string);
            widget.set(dot_string.length);
            if (dot_string.length == 6) {
                print("Max length reached");
                widget.get(dot_string);
                dot_string = "";
            }
        }
    }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 370.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      key_btn("1", false, "", () => widget.forgot ? _forgot_dot("1") : _dot("1")),
                      key_btn("2", false, "", () => widget.forgot ? _forgot_dot("2") : _dot("2")),
                      key_btn("3", false, "", () => widget.forgot ? _forgot_dot("3") : _dot("3"))
                  ],
              ),

              SizedBox(height: 32.0,),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      key_btn("4", false, "", () => widget.forgot ? _forgot_dot("4") : _dot("4")),
                      key_btn("5", false, "", () => widget.forgot ? _forgot_dot("5") : _dot("5")),
                      key_btn("6", false, "", () => widget.forgot ? _forgot_dot("6") : _dot("6"))
                  ],
              ),

              SizedBox(height: 32.0,),

              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                      key_btn("7", false, "", () => widget.forgot ? _forgot_dot("7") : _dot("7")),
                      key_btn("8", false, "", () => widget.forgot ? _forgot_dot("8") : _dot("8")),
                      key_btn("9", false, "", () => widget.forgot ? _forgot_dot("9") : _dot("9"))
                  ],
              ),

              SizedBox(height: 32.0,),

              Container(
                // width: 232.0,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                        Container(
                            width: 232.0,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                  key_btn("0", false, "", () => widget.forgot ? _forgot_dot("0") : _dot("0")),
                                  key_btn("", true, "assets/icons/x.svg", () => widget.forgot ? _forgot_dot("x") : _dot("x")),
                              ],
                          ),
                        )
                    ],
                ),
              ),
          ],
      ),
    );
  }
}