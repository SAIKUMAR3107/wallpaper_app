import 'package:flutter/material.dart';

class OnBoardingScreen2 extends StatefulWidget {
  const OnBoardingScreen2({super.key});

  @override
  State<OnBoardingScreen2> createState() => _OnBoardingScreen2State();
}

class _OnBoardingScreen2State extends State<OnBoardingScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            Image.asset("assets/on_boarding2.jpg",fit: BoxFit.fitHeight,height: double.infinity,),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(10),
                height: 280,
                decoration: BoxDecoration(color: Colors.transparent,borderRadius: BorderRadius.only(topLeft: Radius.circular(70),topRight: Radius.circular(70))),
                child: Column(
                  children: [
                    Container(alignment: Alignment.topLeft,child: Text("Abstarct things",style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),)),
                    SizedBox(height: 10,),
                    Container(alignment: Alignment.topLeft,child: Text("Art that is based on an object, figure or landscape, where forms have been simplified or schematised.",style: TextStyle(fontSize:20,color: Colors.white),),)
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
