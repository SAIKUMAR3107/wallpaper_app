import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/pages/details_screen.dart';
import 'package:gallery_app/services/favorite_service.dart';
import 'package:provider/provider.dart';

import '../model/photos.dart';
import '../theme/theme_provider.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  Stream? userStream;
  List<Photos> totalImageList = [];

  void getData() async {
    userStream = await FavoriteService().getAllFavoriteImages();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Screen"),
        backgroundColor:
            Provider.of<ThemeProvider>(context, listen: false).isDarkMode
                ? Colors.black87
                : Colors.orange,
        centerTitle: true,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: StreamBuilder(
          stream: userStream,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            snapshot.data?.docs
                .map((e) => totalImageList
                    .add(Photos.fromJson(e.data() as Map<String, dynamic>)))
                .toList();
            if (!snapshot.hasData) {
              return Center(
                  child: Text("Loading...",
                      style:
                          TextStyle(color: Color(0xffF67952), fontSize: 30)));
            }
            return snapshot.data!.docs.isEmpty
                ? Center(
                    child: Text("No Favorites to Display",
                        style:
                            TextStyle(color: Color(0xffF67952), fontSize: 30)))
                : GridView.builder(
                    itemCount: totalImageList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.6),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          //snapshot.data?.docs.map((e) => totalImageList.add(Photos.fromJson(e.data() as Map<String, dynamic>))).toList();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailsScreen(
                                    photos: totalImageList[index]),
                              ));
                        },
                        child: Column(children: [
                          Expanded(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: totalImageList[index].src.medium,
                                  fit: BoxFit.fill,
                                )),
                          ),
                        ]),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
