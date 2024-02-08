import 'package:flutter/material.dart';
import 'package:gallery_app/pages/home_screen.dart';
import 'package:gallery_app/pages/spalsh_screen.dart';
import 'package:gallery_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyD8eHak8XXJ3cLWs1iAZEC-RlG0vnk3nng", //current key in google-services.json file
        appId: "1:872875774158:android:6c9f59077bb972618b409f", // mobilesdk_app_id in google-services.json file
        messagingSenderId:"872875774158", // project_number in google-services.json file
        projectId: "wallpaper-14d51"   // project_id in google-services.json file),
      )); // project_id in google-services.json file
  runApp(ChangeNotifierProvider(
      create : (context) => ThemeProvider(),
      child : MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: SplashScreen()
    );
  }
}

