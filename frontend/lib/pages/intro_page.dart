import 'package:flutter/material.dart';
import 'package:frontend/components/intro_slide_1.dart';
import 'package:frontend/components/intro_slide_2.dart';
import 'package:frontend/components/intro_slide_3.dart';
import 'package:frontend/themes/theme.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  //controller to keep track of the pages 
  PageController _controller = PageController();

  //checker to see of the current page is the last page or not
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: customColors.app_black,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },

            children: [
              IntroSlide1(),
              IntroSlide2(),
              IntroSlide3()
            ],
          ),

          Container(
            alignment: Alignment(0, 0.6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  child: Text(
                    "skip",
                    style: TextStyle(
                        fontSize: 16, 
                        color: customColors.app_white
                      ),
                  ),
                  onTap: () {
                    _controller.jumpToPage(2);
                  },
                ),

                SmoothPageIndicator(
                  controller: _controller, 
                  count: 3,
                  effect: ExpandingDotsEffect(    
                    spacing:  8.0,    
                    radius:  24.0,    
                    dotWidth:  16.0,    
                    dotHeight:  16.0,    
                    // paintStyle:  PaintingStyle.stroke,    
                    strokeWidth:  1.5,    
                    dotColor:  customColors.app_dark_b,    
                    activeDotColor: customColors.app_dark_a    
                  ), 
                ),

                onLastPage
                ?  GestureDetector(
                    child: Text(
                      "Done",
                      style: TextStyle(
                        fontSize: 16, 
                        color: customColors.app_white
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/auth');
                    },
                  ) 
                : GestureDetector(
                  child: Text(
                    "Next",
                    style: TextStyle(
                        fontSize: 16, 
                        color: customColors.app_white
                      ),
                  ),
                  onTap: () {
                    _controller.nextPage(
                      duration: Duration(milliseconds: 500), 
                      curve: Curves.easeIn
                    );
                  },
                )
              ],
            ),
          )
        ],
      )
    );
  }
}