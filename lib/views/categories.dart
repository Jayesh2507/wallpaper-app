import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/widgets/widget.dart';

class Categorie extends StatefulWidget {
  final String categorieName;
  Categorie({required this.categorieName});

  @override
  State<Categorie> createState() => _CategorieState();
}

class _CategorieState extends State<Categorie> {
  //controller
  var searchController = TextEditingController();

  //lists
  List<WallpaperModel> wallpapers = [];

  getSearchWallpapers(String query) async {
    //random number
    var random = randomNumber();

    //api request
    var response = await http.get(
      Uri.parse("https://api.pexels.com/v1/search?query=$query&per_page=15&page=$random"),
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
  void initState() {
    super.initState();
    getSearchWallpapers(widget.categorieName);
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
