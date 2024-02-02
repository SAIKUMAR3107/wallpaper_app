import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/pages/details_screen.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../model/photos.dart';
import '../theme/theme_provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchResult = TextEditingController();
  List<Photos> photo = [];
  bool noImage = false;

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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        controller: searchResult,
                        onChanged: (text) {

                        },
                        decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Provider.of<ThemeProvider>(context,
                                              listen: false)
                                          .isDarkMode
                                      ? Colors.black87
                                      : Colors.deepPurple.shade200)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Provider.of<ThemeProvider>(context,
                                              listen: false)
                                          .isDarkMode
                                      ? Colors.black87
                                      : Colors.deepPurple.shade200)),
                          labelText: "Search",
                          floatingLabelBehavior: FloatingLabelBehavior.auto,
                          floatingLabelStyle: TextStyle(
                              color: Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .isDarkMode
                                  ? Colors.black87
                                  : Colors.deepPurple.shade200,
                              fontFamily: "sans-serif-condensed-light",
                              fontWeight: FontWeight.bold),
                          hintStyle: TextStyle(
                              color: Provider.of<ThemeProvider>(context,
                                          listen: false)
                                      .isDarkMode
                                  ? Colors.black87
                                  : Colors.deepPurple.shade200,
                              fontSize: 18,
                              fontFamily: "sans-serif-condensed-light",
                              fontWeight: FontWeight.bold),
                          prefixIcon: Icon(Icons.search),
                          prefixIconColor:
                              Provider.of<ThemeProvider>(context, listen: false)
                                      .isDarkMode
                                  ? Colors.black87
                                  : Colors.deepPurple.shade200,
                          suffixIconColor:
                              Provider.of<ThemeProvider>(context, listen: false)
                                      .isDarkMode
                                  ? Colors.black87
                                  : Colors.deepPurple.shade200,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              backgroundColor: Provider.of<ThemeProvider>(
                                          context,
                                          listen: false)
                                      .isDarkMode
                                  ? Colors.black87
                                  : Colors.deepPurple.shade200),
                          onPressed: () {
                            setState(() {
                              var text = searchResult.text;
                              if (text == "") {
                                photo = [];
                                noImage = false;
                              } else {
                                searchResponse(text);
                                noImage = true;
                              }
                            });
                          },
                          child: Text(
                            "Search",
                            style: TextStyle(color: Colors.white),
                          )))
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                  child: !noImage
                      ? Center(
                          child: Text("Search For Image"),
                        )
                      : GridView.builder(
                          itemCount: photo.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                  childAspectRatio: 0.6),
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          DetailsScreen(photos: photo[index]),
                                    ));
                              },
                              child: Stack(children: [
                                Container(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                        imageUrl: photo[index].src.small,
                                        fit: BoxFit.fill,
                                        height: 500,
                                        width:
                                            MediaQuery.of(context).size.width,
                                      )),
                                ),
                                Positioned(
                                    right: 10,
                                    bottom: 5,
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(Colors
                                                    .white
                                                    .withOpacity(0.5))),
                                        onPressed: () {
                                          download(photo[index].src.original);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      "Image downloaded successfully")));
                                        },
                                        child: Row(
                                          children: [
                                            Text(
                                              "Download",
                                              style: TextStyle(
                                                  color: Colors.white),
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
                        ))
            ],
          )),
    );
  }
}
