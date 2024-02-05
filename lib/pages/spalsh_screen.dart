import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gallery_app/on_boarding_screens.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => OnBoardingScreens(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Center(
          child: Text("_Wall",style: TextStyle(fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,color: Colors.orange,fontSize: 60),),
        ),
      ),
    );
  }
}
