import 'package:flutter/material.dart';
import 'package:gallery_app/pages/home_screen.dart';

class OnBoardingScreen3 extends StatefulWidget {
  const OnBoardingScreen3({super.key});

  @override
  State<OnBoardingScreen3> createState() => _OnBoardingScreen3State();
}

class _OnBoardingScreen3State extends State<OnBoardingScreen3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Stack(
            children: [
              Image.asset("assets/on_boarding3.jpg",fit: BoxFit.fitHeight,height: double.infinity,),
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
                      Container(alignment: Alignment.topLeft,child: Text("Nature",style: TextStyle(fontSize: 40,color: Colors.white,fontWeight: FontWeight.bold),)),
                      SizedBox(height: 10,),
                      Container(alignment: Alignment.topLeft,child: Text("Look deep into nature, and then you will understand everything better.",style: TextStyle(fontSize:20,color: Colors.white),),),
                      SizedBox(height: 40,),
                      SizedBox(
                          width: 180,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
                            },
                            child: Text("Get Started",style: TextStyle(fontSize: 18),),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40)),
                              backgroundColor: Colors.orange,
                            ),
                          ))
                    ],
                  ) ,
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}
