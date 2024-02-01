import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../model/photos.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Photos> photo = [];
  List<String> imageUrls = [];
  int activeIndex = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    var client = http.Client();
    var response = await client.get(
        Uri.parse(
            "https://api.pexels.com/v1/search?query=nature&per_page=10000"),
        headers: {
          "Authorization":
              "DwLf2ksrvZhsOSlQByzXmfymr6dS8YSBQgil35N8IKEHSJs74UuRI3kE"
        });
    setState(() {
      var data = jsonDecode(response.body);
      data["photos"].map((e) => photo.add(Photos.fromJson(e))).toList();
      for (int i = 0; i <= 7; i++) {
        imageUrls.add(photo[i].src.original);
      }
      isLoading = true;
    });
  }

  void download(String original) async {
    var time = DateTime.now().microsecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/image-$time.jpg";
    var file = File(path);
    var res = await http.Client().get(Uri.parse(original));
    file.writeAsBytes(res.bodyBytes);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Visibility(
                visible: isLoading,
                replacement: Center(child: CircularProgressIndicator(),),
                child: CarouselSlider.builder(
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index, realIndex) {
                      final res = imageUrls[index];
                      return Container(
                        height: MediaQuery.of(context).size.height / 1.5,
                        width: MediaQuery.of(context).size.width,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: CachedNetworkImage(
                            imageUrl: res,
                            fit: BoxFit.fill,
                          ),
                        ),
                      );
                    },
                    options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            activeIndex = index;
                          });
                        },
                        autoPlay: true,
                        height: MediaQuery.of(context).size.height / 1.7,
                        //viewportFraction: 1,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height)),
              ),
              SizedBox(
                height: 10,
              ),
              AnimatedSmoothIndicator(
                activeIndex: activeIndex,
                count: imageUrls.length,
                effect: JumpingDotEffect(
                    jumpScale: 1.6,
                    dotWidth: 15,
                    dotHeight: 15,
                    dotColor: Colors.black45,
                    activeDotColor: Colors.orange),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                alignment: Alignment.topLeft,
                child: Text(
                  "Explore More..",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.orange.shade300),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 700,
                child: GridView.builder(
                  itemCount: photo.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.6),
                  itemBuilder: (context, index) {
                    return Stack(children: [
                      Container(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: CachedNetworkImage(
                              imageUrl: photo[index].src.small,
                              fit: BoxFit.fill,
                              height: 500,
                              width: MediaQuery.of(context).size.width,
                            )),
                      ),
                      Positioned(
                          right: 10,
                          bottom: 5,
                          child: ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.white.withOpacity(0.5))),
                              onPressed: () {
                                download(photo[index].src.original);
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            "Image downloaded successfully")));
                              },
                              child: Row(
                                children: [
                                  Text(
                                    "Download",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Icon(
                                    Icons.download,
                                    color: Colors.white,
                                  )
                                ],
                              )))
                    ]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
