import 'package:flutter/material.dart';

class OnBoardingScreen1 extends StatefulWidget {
  const OnBoardingScreen1({super.key});

  @override
  State<OnBoardingScreen1> createState() => _OnBoardingScreen1State();
}

class _OnBoardingScreen1State extends State<OnBoardingScreen1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset("assets/on_boarding1.jpg",fit: BoxFit.fitHeight,height: double.infinity,),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: 280,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.only(topLeft: Radius.circular(70),topRight: Radius.circular(70))),
                child: Column(
                  children: [
                    Container(alignment: Alignment.topLeft,child: Text("Space wonders",style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),)),
                    SizedBox(height: 10,),
                    Container(alignment: Alignment.topLeft,child: Text("From our little perch inside the Milky Way, the image shows the universe stretching out for about a billion light years.",style: TextStyle(fontSize:20,color: Colors.white),),)
                  ],
                ) ,
              ),
            )
          ],
        )
      ),
    );
  }
}
