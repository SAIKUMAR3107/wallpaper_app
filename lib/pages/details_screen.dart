import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/photos.dart';


class DetailsScreen extends StatefulWidget {
  Photos photos;
  DetailsScreen({required this.photos,super.key});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool isLoading = false;
  bool liked = false;

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
    Timer(Duration(seconds: 5), () {
      setState(() {
        isLoading = true;
      });
    });
    //print(widget.photos.src.original);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(title: Text("D E T A I L S", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor: Provider.of<ThemeProvider>(context, listen: false).isDarkMode ? Colors.black87 : Colors.orange,
        centerTitle: true,),*/
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: isLoading ? Stack(
            children: [
              Container(
                height: double.infinity,
                width: double.infinity,
                child: Image.network(widget.photos.src.original,fit: BoxFit.fill,),
              ),
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  children: [
                    IconButton(onPressed: (){
                      Navigator.pop(context);
                    }, icon: Icon(Icons.arrow_back_ios,size: 30,color: Colors.white,)),
                    Container(child: Text("Picture details", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 30),))
                  ],
                ),
              ),
              Positioned(
                  bottom: 0,left: 0,
                  child:Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(30)),
                          child: Icon(Icons.person,size: 50,color: Colors.orange,weight: 2.0,)
                        ),
                        SizedBox(width: 10,),
                        Container(child: Text(widget.photos.photographer.toUpperCase(), style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,fontSize: 20,overflow: TextOverflow.ellipsis),))
                      ],
                    ),
                  ) ),
              Positioned(
                right: 5,
                  bottom: 60,
                  child:Container(
                    height: 250,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            download(widget.photos.src.original);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Downloading has started")));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Icon(Icons.download,color: Colors.white,size: 30,),
                                Text("Download",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              if(liked) {
                                liked = false;
                              }
                              else{
                                liked = true;
                              }
                            });
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Container(child: !liked ? Icon(Icons.favorite_border,color: Colors.white,size: 30,) : Icon(Icons.favorite,color: Colors.red,size: 30,)),
                                SizedBox(height: 5,),
                                Text("Like",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            showDialog(context: context, builder: (context) => AlertDialog(title: Text("Update in Progress"),
                              actions: [
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("No")),
                                TextButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text("Exit"))
                              ],),);
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Icon(Icons.more_horiz,color: Colors.white,size: 30,),
                                Text("More",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)
                              ],
                            ),
                          ),
                        ),

                      ],
                    ),
                  )),
            ],
          ) : Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 10,),
              Text("Loading")
            ],
          ),)

        ),
      ),
    );
  }
}
