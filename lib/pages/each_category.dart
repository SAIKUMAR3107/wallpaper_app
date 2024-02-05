import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../model/photos.dart';
import '../theme/theme_provider.dart';
import 'details_screen.dart';

class EachCategoryScreen extends StatefulWidget {
  String categoty;
  EachCategoryScreen({required this.categoty,super.key});

  @override
  State<EachCategoryScreen> createState() => _EachCategoryScreenState();
}

class _EachCategoryScreenState extends State<EachCategoryScreen> {
  List<Photos> photo = [];
  bool isLoading = false;

  void searchResponse(String text) async {
    var client = http.Client();
    var response = await client.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$text&per_page=80"),
        headers: {
          "Authorization":
          "DwLf2ksrvZhsOSlQByzXmfymr6dS8YSBQgil35N8IKEHSJs74UuRI3kE"
        });

    if (response.statusCode == 200) {
      setState(() {
        var data = jsonDecode(response.body);
        data["photos"].map((e) => photo.add(Photos.fromJson(e))).toList();
        isLoading = true;
      });
    } else {
      print("Saikumar");
    }
  }

  void download(String original) async {
    var time = DateTime.now().microsecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/image-$time.jpg";
    var file = File(path);
    var res = await http.Client().get(Uri.parse(original));
    file.writeAsBytes(res.bodyBytes);
  }

  @override
  void initState() {
    super.initState();
    searchResponse(widget.categoty);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.categoty.toUpperCase()),
        backgroundColor: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Colors.black87 : Colors.orange,
        centerTitle: true,),
      body :Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child: isLoading ? GridView.builder(
          itemCount: photo.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.6),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(photos: photo[index]),));
              },
              child: Stack(children: [
                Container(
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: photo[index].src.medium,
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
              ]),
            );
          },
        ) : Center(child: CircularProgressIndicator()),
      )

    );
  }
}
