import "package:flutter/material.dart";

class MarketingAlbum extends StatefulWidget {
  const MarketingAlbum({Key? key}) : super(key: key);

  @override
  _MarketingAlbumState createState() => _MarketingAlbumState();
}

class _MarketingAlbumState extends State<MarketingAlbum> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Albums"),
    );
  }
}
