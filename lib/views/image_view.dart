import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper/data/data.dart';
import 'package:path_provider/path_provider.dart';


class ImageView extends StatefulWidget {
  final String imgUrl;
  const ImageView({required this.imgUrl});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView> {
  //  save image to ths path
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
            Hero(
              tag: widget.imgUrl,
              child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.network(widget.imgUrl,fit: BoxFit.cover,)
              ),
            ),
            Container(
                height: double.infinity,
                width: double.infinity,
                alignment: Alignment.bottomCenter,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: (){
                          downloadImage(widget.imgUrl);
                            Navigator.pop(context);
                          },
                        child: Stack(
                          children: [
                            Container(
                              height:50,
                              width: MediaQuery.of(context).size.width/2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xff1C1B1B).withOpacity(0.8),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width/2,
                              padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Color(0x36FFFFFF),Color(0x0FFFFFFF)]
                                  ),
                                  border: Border.all(color: Colors.white60,width: .5),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    'Set Wallpaper',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 20
                                    ),
                                  ),
                                  Text(
                                    'Image will be saved in gallery',
                                    style: TextStyle(
                                      color:Colors.white70,
                                      fontSize: 10,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 15,),
                      InkWell(
                          onTap: (){Navigator.pop(context);},
                          child: Text('Cancel',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w700),)),
                      SizedBox(height: 50,)
                    ],
                ),
            )
        ],
      ),
    );
  }

  void downloadImage(imgUrl) async {
    var time = DateTime.now().millisecondsSinceEpoch;
    var path = "/storage/emulated/0/Download/image-$time.jpg";
    var file = File(path);
    var res = await http.get(
      Uri.parse(imgUrl)
    );
    file.writeAsBytes(res.bodyBytes);
  }
}
