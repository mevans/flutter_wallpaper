import 'package:flutter/material.dart';
import 'package:wallpaper/wallpaper.dart';

class DetailedImage extends StatelessWidget {
  final String imageURL;

  const DetailedImage({Key key, this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.network(
            imageURL,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: InkWell(
              onTap: () async {
                int selection = await showDialog(
                    context: context,
                    builder: (ctx) => SetWallpaperDialog());
                if (selection != null) {
                  showDialog(context: context, builder: (ctx) => Text("Loading"));
                  var s = await Wallpaper.bothScreen(imageURL);
                  Navigator.pop(context);
                  print(s);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    "Set Wallpaper",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: Colors.black45,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SetWallpaperDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget rowItem(int id, IconData icon, String text) {
      return InkWell(
        onTap: () => Navigator.pop(context, id),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8),
          child: Row(
            textBaseline: TextBaseline.ideographic,
            children: <Widget>[
              Icon(icon),
              SizedBox(width: 8),
              Text(text)
            ],
          ),
        ),
      );
    }
    return SimpleDialog(
      title: Text("Set Wallpaper"),
      contentPadding: EdgeInsets.zero,
      children: <Widget>[
        SizedBox(height: 8),
        rowItem(0, Icons.home, "Home screen"),
        rowItem(1, Icons.lock, "Lock screen"),
        rowItem(2, Icons.smartphone, "Both"),
        SizedBox(height: 24),
      ],
    );
  }
}

