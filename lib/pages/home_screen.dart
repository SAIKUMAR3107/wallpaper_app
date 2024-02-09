import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:gallery_app/pages/category_screen.dart';
import 'package:gallery_app/pages/favorite_screen.dart';
import 'package:gallery_app/pages/login_screen.dart';
import 'package:gallery_app/pages/main_screen.dart';
import 'package:gallery_app/pages/search_screen.dart';
import 'package:gallery_app/services/auth_service.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../theme/theme_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var my_index = 0;
  final AuthServices authService = AuthServices();
  var advancedDrawerController = AdvancedDrawerController();
  List<Widget> pages = [MainScreen(), SearchScreen(), CategoryScreen()];
  List<Widget> titles = [
    Text(
      "W A L L P A P E R S",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    Text(
      "S E A R C H",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    Text(
      "C A T E G O R Y",
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
    ),
  ];

  void drawerController() {
    advancedDrawerController.toggleDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return AdvancedDrawer(
      controller: advancedDrawerController,
      backdropColor:
          Provider.of<ThemeProvider>(context, listen: false).isDarkMode
              ? Colors.black87
              : Colors.grey.shade100,
      animationCurve: Curves.easeOutQuart,
      openScale: 0.75,
      openRatio: 0.55,
      disabledGestures: true,
      animationDuration: Duration(milliseconds: 700),
      drawer: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Icon(
              Icons.person,
              color:
                  Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                      ? Colors.white
                      : Colors.orange,
              size: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Email : " + authService.getCurrentUser()!.email!),
            SizedBox(
              height: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoriteScreen(),
                    ));
              },
              leading: Icon(
                Icons.favorite,
                color: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode
                    ? Colors.white
                    : Colors.orange,
              ),
              title: Text("Favorites"),
            ),
            Spacer(),
            ListTile(
              onTap: () async {
                FirebaseAuth.instance.signOut();
                SharedPreferences shared =
                    await SharedPreferences.getInstance();
                setState(() {
                  shared.setBool("isLogin", false);
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                });
              },
              leading: Icon(
                Icons.logout,
                color: Provider.of<ThemeProvider>(context, listen: false)
                        .isDarkMode
                    ? Colors.white
                    : Colors.orange,
              ),
              title: Text("Logout"),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              child: Provider.of<ThemeProvider>(context, listen: false)
                      .isDarkMode
                  ? Container(
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .toggleTheme();
                            });
                          },
                          icon: Icon(Icons.dark_mode)),
                    )
                  : Container(
                      child: IconButton(
                          onPressed: () {
                            setState(() {
                              Provider.of<ThemeProvider>(context, listen: false)
                                  .toggleTheme();
                            });
                          },
                          icon: Icon(Icons.sunny)),
                    ),
            )
          ],
          title: titles[my_index],
          backgroundColor:
              Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                  ? Colors.black87
                  : Colors.orange,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                drawerController();
              },
              icon: Icon(
                Icons.menu,
                color: Colors.white,
              )),
        ),
        bottomNavigationBar: CurvedNavigationBar(
          onTap: (value) {
            setState(() {
              my_index = value;
            });
          },
          color: Provider.of<ThemeProvider>(context, listen: false).isDarkMode
              ? Colors.black87
              : Colors.orange,
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
      ),
    );
  }
}
