import 'package:flutter/material.dart';
import 'package:gallery_app/pages/on_boarding_screen1.dart';
import 'package:gallery_app/pages/on_boarding_screen2.dart';
import 'package:gallery_app/pages/on_boarding_screen3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreens extends StatefulWidget {
  const OnBoardingScreens({super.key});

  @override
  State<OnBoardingScreens> createState() => _OnBoardingScreensState();
}

class _OnBoardingScreensState extends State<OnBoardingScreens> {
  var count = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children:  [
            PageView(controller: count,
              children: [
                OnBoardingScreen1(),
                OnBoardingScreen2(),
                OnBoardingScreen3()
              ],
            ),
            Container(
              alignment: Alignment(0,0.88),
              child: SmoothPageIndicator(controller: count , count: 3,effect: const SlideEffect(
                activeDotColor: Colors.orange,
                dotHeight: 15,
                dotColor: Colors.grey,
                dotWidth: 15,
              ),
                onDotClicked: (index) => count.animateToPage(index, duration: Duration(milliseconds: 300), curve:Curves.easeIn),
              ),
            ),
            Container(
                  alignment: Alignment(0,0.96),
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Swipe right to next ",style: TextStyle(fontSize: 18,color: Colors.white),),
                      Icon(Icons.arrow_forward_outlined,size: 18,color: Colors.white,)
                    ],
            ),)
          ]
      ),
    );
  }
}
