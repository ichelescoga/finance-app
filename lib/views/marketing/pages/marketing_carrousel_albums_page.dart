import "package:flutter/material.dart";

class MarketingCarrouselAlbumsPage extends StatefulWidget {
  const MarketingCarrouselAlbumsPage({Key? key}) : super(key: key);

  @override
  _MarketingCarrouselAlbumsPageState createState() =>
      _MarketingCarrouselAlbumsPageState();
}

class _MarketingCarrouselAlbumsPageState extends State<MarketingCarrouselAlbumsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [Text("Carrousel"), Text("Albums")],
    ));
  }
}
