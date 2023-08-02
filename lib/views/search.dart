import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:wallpaper/widgets/widget.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
  final String searchQuery;
  Search({required this.searchQuery});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  //list
  List<WallpaperModel> wallpapers = [];

  //controllers
  var searchController = TextEditingController();

  //fetching query
  getSearchWallpapers(String query) async {
    //random  umber
    var random = randomNumber();

    //api request
    var response = await http.get(
        Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=15&page=$random"),
        headers: {
          "Authorization": apiKey
        }
    );
    // print(response.body.toString());
    var parsedData = jsonDecode(response.body); //Map<String,dynamic> parsedData = jsonDecode();
    //map is object/dicionary, <> ->it defines the type of key and value
    parsedData["photos"].forEach((element){
      WallpaperModel wallpaperModel = WallpaperModel(
          photographer: element["photographer"],
          photographer_url: element["photographer_url"],
          photographer_id: element["photographer_id"],
          portrait: element["src"]["portrait"]
      );
      wallpapers.add(wallpaperModel);
      // print(element["src"]["portrait"]);
    });

    setState(() {
      wallpapers;
    });
  }

  @override
  void initState() {
    super.initState();
    getSearchWallpapers(widget.searchQuery);
    searchController.text = widget.searchQuery;
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
                      getSearchWallpapers(searchController.text);
                    }
                )
            ],
          ),
      ),
            SizedBox(height: 16,),
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