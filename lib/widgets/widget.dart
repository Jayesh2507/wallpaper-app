import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wallpaper/data/data.dart';
import 'package:wallpaper/model/wallpaper_model.dart';
import 'package:wallpaper/views/image_view.dart';
import 'package:wallpaper/views/search.dart';
import 'package:http/http.dart' as http;

Widget  brandName(){
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      children: [
        TextSpan(
          text: 'Wallpaper',
          style: TextStyle(color: Colors.black, fontSize: 24,fontWeight: FontWeight.w500),
        ),
        TextSpan(
          text: 'App',
          style: TextStyle(color: Colors.blue, fontSize: 24,fontWeight: FontWeight.w500),
        ),
      ],
    ),
  );
}

Widget wallPapersList({required List<WallpaperModel> wallpapers,required context}){
  return Container(
    margin: EdgeInsets.only(left: 24,right: 24),
    child: GridView.builder(
      gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        childAspectRatio: 0.6,
      ),
      shrinkWrap: true, //Usually, a ListView, as well as GridView, PageView, and CustomScrollView try to fill all
      // the available space given by the parent element,even when the list items would require less space.
      // With shrinkWrap: true,you can change this behavior so that the ListView only occupies the space it needs.
      itemCount: wallpapers.length,
      itemBuilder: (context,index){
        return GridTile(
          child: InkWell(
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=> ImageView(imgUrl: wallpapers[index].portrait)));},
            child: Hero(
              tag: wallpapers[index].portrait,
              child: Container(
                height: 500,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(wallpapers[index].portrait,fit: BoxFit.cover,)
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}

int randomNumber(){
  var random = Random();
  int randomNumber = random.nextInt(15) + 1; // 1 to 9

  return randomNumber;
}
