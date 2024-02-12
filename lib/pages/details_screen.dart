import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/photos.dart';
import '../services/favorite_service.dart';
import '../theme/theme_provider.dart';
import 'download_dialog_screen.dart';

class DetailsScreen extends StatefulWidget {
  Photos photos;

  DetailsScreen({required this.photos, super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool liked = false;


  void getAllImages() async {
    await FavoriteService().getAllFavoriteImages().then((value) {
      value.forEach((element) {
        element.docs.map((e) {
          setState(() {
            if (e['id'] == widget.photos.id) {
              liked = true;
            }
          });
        }).toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getAllImages();
    //print(widget.photos.src.original);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "D E T A I L S",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor:
            Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                ? Colors.black87
                : Colors.orange,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.black,
            child: Stack(
                    children: [
                      Container(
                        height: double.infinity,
                        width: double.infinity,
                        child: Image.network(
                          widget.photos.src.original,
                          fit: BoxFit.fill,
                        ),
                      ),

                      Positioned(
                          bottom: 10,
                          left: 0,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            child: Row(
                              children: [
                                Container(
                                    padding: EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Icon(
                                      Icons.person,
                                      size: 50,
                                      color: Colors.orange,
                                      weight: 2.0,
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                    child: Text(
                                  widget.photos.photographer.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20,
                                      overflow: TextOverflow.ellipsis),
                                ))
                              ],
                            ),
                          )),
                      Positioned(
                          right: 5,
                          bottom: 60,
                          child: Container(
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      showDialog(context: context, builder: (context) => DownloadDialogScreen(original: widget.photos.src.original,),);
                                    });
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.download,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        Text(
                                          "Download",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (liked) {
                                        liked = false;
                                        FavoriteService().deleteFavoriteImage(
                                            widget.photos.id);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Items removes from Favorites")));
                                      } else {
                                        liked = true;
                                        FavoriteService().addFavoriteImage(
                                            widget.photos, widget.photos.id);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "Items added to Favorites")));
                                      }
                                    });
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Container(
                                            child: !liked
                                                ? Icon(
                                                    Icons.favorite_border,
                                                    color: Colors.white,
                                                    size: 30,
                                                  )
                                                : Icon(
                                                    Icons.favorite,
                                                    color: Colors.red,
                                                    size: 30,
                                                  )),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                          "Favorites",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: Text("Update in Progress"),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("No")),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("Exit"))
                                        ],
                                      ),
                                    );
                                  },
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.more_horiz,
                                          color: Colors.white,
                                          size: 30,
                                        ),
                                        Text(
                                          "More",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )),
                    ],
                  )
                ),
      ),
    );
  }
}
