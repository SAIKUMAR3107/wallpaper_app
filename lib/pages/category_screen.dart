import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/pages/each_category.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  List<String> images = ["assets/abstract.jpg","assets/animals.jpg","assets/bikes.jpg","assets/birds.jpg","assets/bycycles.jpg","assets/cars.jpg","assets/cartoon.jpg","assets/cltynight.jpg","assets/coding.jpg","assets/electronics.jpg","assets/laptop.jpg","assets/mobile.jpg","assets/mountain.jpg","assets/nature.jpg","assets/puppy.jpg","assets/space.jpg"];
  List<String> titles = ["abstract","animals","bikes","birds","bycycles","cars","cartoon","citynight","coding","electronics","laptop","mobile","mountain","nature","puppy","space"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.all(10),
        child:GridView.builder(itemCount:images.length,gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisSpacing: 10,crossAxisSpacing: 10), itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) => EachCategoryScreen(categoty: titles[index]),));
            },
            child: Stack(
              children:[
                ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.fill,
                          height: 200,
                          width: 200,
                        )),
                Center(child: Text(titles[index],style: TextStyle(color: Colors.white,fontSize: 40,fontWeight: FontWeight.bold),))
              ]
            ),
          );
        },)
      ),
    );
  }
}
