import "package:flutter/material.dart";

class MarketingCarrouselAlbums extends StatefulWidget {
  const MarketingCarrouselAlbums({Key? key}) : super(key: key);

  @override
  _MarketingCarrouselAlbumsState createState() =>
      _MarketingCarrouselAlbumsState();
}

class _MarketingCarrouselAlbumsState extends State<MarketingCarrouselAlbums> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [Text("Carrousel"), Text("Albums")],
    ));
  }
}
