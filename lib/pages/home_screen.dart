import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/pages/category_screen.dart';
import 'package:gallery_app/pages/main_screen.dart';
import 'package:gallery_app/pages/search_screen.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var my_index = 0;
  List<Widget> pages = [MainScreen(), SearchScreen(), CategoryScreen()];
  List<Widget> titles = [
    Text("W A L L P A P E R S", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
    Text("S E A R C H", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
    Text("C A T E G O R Y", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                ? Container(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      Provider.of<ThemeProvider>(context,
                          listen: false)
                          .toggleTheme();
                    });
                  },
                  icon: Icon(Icons.dark_mode)),
            )
                : Container(
              child: IconButton(
                  onPressed: () {
                    setState(() {
                      Provider.of<ThemeProvider>(context,
                          listen: false)
                          .toggleTheme();
                    });
                  },
                  icon: Icon(Icons.sunny)),
            ),
          )
        ],
        title: titles[my_index],
        backgroundColor: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Colors.black87 : Colors.deepPurple.shade200,
        centerTitle: true,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        onTap: (value) {
          setState(() {
            my_index = value;
          });
        },
        color: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Colors.black87 : Colors.deepPurple.shade200,
        backgroundColor: Colors.white,
        height: 60,
        items: [
          CurvedNavigationBarItem(
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
              label: "Home",
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "sans-serif-condensed-light")),
          CurvedNavigationBarItem(
              child: Icon(
                Icons.search,
                color: Colors.white,
              ),
              label: "Search",
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "sans-serif-condensed-light")),
          CurvedNavigationBarItem(
              child: Icon(
                Icons.category,
                color: Colors.white,
              ),
              label: "Category",
              labelStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: "sans-serif-condensed-light")),
        ],
      ),
      body: pages[my_index],
    );
  }
}
