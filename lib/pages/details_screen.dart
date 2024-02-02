import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/photos.dart';
import '../theme/theme_provider.dart';

class DetailsScreen extends StatefulWidget {
  Photos photos;
  DetailsScreen({required this.photos,super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("D E T A I L S", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Colors.black87 : Colors.deepPurple.shade200,
        centerTitle: true,),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Text("Details Screen"),
      ),
    );
  }
}
