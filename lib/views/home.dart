import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:wallpaper/views/categories.dart';
import 'package:wallpaper/views/image_view.dart';
import 'package:wallpaper/views/search.dart';
import 'package:wallpaper/widgets/widget.dart';
import '../model/categories_model.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //lists
  List<CategoriesModel> categories = [];
  List<WallpaperModel> wallpapers = [];

  //controllers
  var searchController = TextEditingController();

  //fetching wallpaper from api
  getTrendingWallpapers() async {

    var random = randomNumber();
    var response = await http.get(
      Uri.parse("https://api.pexels.com/v1/curated?per_page=15&page=$random"),
      headers: {
        "Authorization": apiKey,
      },
    );

    var parsedData = jsonDecode(response.body);
    List<WallpaperModel> newWallpapers = []; // Create a new list to hold the updated wallpapers

    parsedData["photos"].forEach((element) {
      WallpaperModel wallpaperModel = WallpaperModel(
        photographer: element["photographer"],
        photographer_url: element["photographer_url"],
        photographer_id: element["photographer_id"],
        portrait: element["src"]["portrait"],
      );
      newWallpapers.add(wallpaperModel);
      // print(element["src"]["portrait"]);
    });

    setState(() {
      wallpapers = newWallpapers; // Update the wallpapers list with the new data
    });
  }

  @override
  void initState() {//initState is called when application starts(initState is only called once when
    // the widget is first inserted into the widget tree, )
    super.initState();
    getTrendingWallpapers();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: brandName(),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: Column(
          children: [
            Container(
            decoration: BoxDecoration(
            color: Color(0xfff5f8fd),
              borderRadius: BorderRadius.circular(30)
          ),
            margin: EdgeInsets.symmetric(horizontal: 24),
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Wallpapers'
                  ),
                ),
              ),
                InkWell(
                  child: Icon(Icons.search),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                        builder: (context) =>Search(
                          searchQuery: searchController.text,
                        )
                    ));
                  }
                )
              ],
            ),
         ),
            SizedBox(height: 16),
            Container(
              height: 60,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder:(context,index){
                    return CategoriesTile(
                        imgUrl: categories[index].imgUrl,
                        title: categories[index].categoriesName,
                    );
                  },
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: wallPapersList(
                context: context,
                wallpapers: wallpapers
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {
  final String imgUrl,title;
  CategoriesTile({required this.imgUrl,required this.title}); // created constructor of CategoriesTile

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder:(context)=> Categorie(categorieName: title.toLowerCase()))
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 5),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(imgUrl,height: 50,width: 100,fit: BoxFit.cover),
            ),
            Container(
              height: 50,width: 100,
              decoration:BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.black26,
              ),
              child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 16
                    ),
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}

