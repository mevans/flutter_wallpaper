import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_pagewise/flutter_pagewise.dart';
import 'package:flutter_wallpaper/screens/detailed_image/detailed_image.dart';
import 'package:http/http.dart' as http;

class WallpaperGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(slivers: <Widget>[
          PagewiseSliverGrid<Map<String, dynamic>>.count(
            crossAxisCount: 2,
            loadingBuilder: (c) => CircularProgressIndicator(),
            childAspectRatio: MediaQuery.of(context).size.aspectRatio,
            pageLoadController: PagewiseLoadController(
                pageSize: 15,
                pageFuture: (i) async {
                  List<Map<String, dynamic>> urls = [];
                  var r = await http.get(
                      "https://api.pexels.com/v1/search?query=landscape&per_page=15&page=${i + 1}",
                      headers: {
                        "Authorization":
                            "563492ad6f91700001000001787140a0f94a472bbb1c1a0986a6222c"
                      });
                  Map<String, dynamic> jso = json.decode(r.body);
                  for (var p in jso["photos"]) {
                    urls.add(p["src"]);
                  }
                  return urls;
                }),
            itemBuilder: (BuildContext context, entry, int index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (ctx) => DetailedImage(
                            imageURL:
                                "${entry["original"]}?fit=crop&h=${MediaQuery.of(context).size.height * 2}&w=${MediaQuery.of(context).size.width * 2}",
                          ),
                    ),
                  );
                },
                child: Image.network(
                  entry["large"],
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ]));
  }
}
