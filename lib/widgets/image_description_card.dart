import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/widgets/video_card.dart";
import "package:flutter/material.dart";

// PLEASE BE AWARE, THERE ARE TWO WIDGETS HERE, if you need to change styles, please change BOTH in order to keep the styles equal.
// 1- with hearth icon, and all necessary methods for handle it
// 2- without heart icon only basic data

class ImageFavoriteDescriptionCard extends StatefulWidget {
  final Function(bool) onFavoriteChanged;
  final bool initialFavorite;
  final String? imageUrl;
  final String description;
  final bool showFavorite;
  final RightIcon? rightIcon;

  const ImageFavoriteDescriptionCard(
      {Key? key,
      required this.onFavoriteChanged,
      required this.initialFavorite,
      required this.imageUrl,
      required this.description,
      this.showFavorite = true,
      this.rightIcon})
      : super(key: key);

  @override
  _ImageFavoriteDescriptionCardState createState() =>
      _ImageFavoriteDescriptionCardState();
}

class _ImageFavoriteDescriptionCardState
    extends State<ImageFavoriteDescriptionCard> {
  final favoriteColor = AppColors.secondaryMainColor;
  bool isMarkAsFavorite = false;

  @override
  void initState() {
    super.initState();
    isMarkAsFavorite = widget.initialFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15), // No border radius for the card itself
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              if (widget.imageUrl != null)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    widget.imageUrl!,
                    width: double.infinity,
                    height: 160.0,
                    fit: BoxFit.cover,
                  ),
                )
              else
                AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.asset("assets/no-image.png", height: 160)),
              if (widget.showFavorite)
                Container(
                  width: 40,
                  height: 40,
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: Colors.white),
                  child: IconButton(
                    icon: Icon(
                      isMarkAsFavorite
                          ? Icons.favorite
                          : Icons.favorite_outline,
                      color: favoriteColor,
                    ),
                    onPressed: () {
                      setState(() {
                        isMarkAsFavorite = !isMarkAsFavorite;
                      });
                      widget.onFavoriteChanged(isMarkAsFavorite);
                    },
                  ),
                ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: widget.rightIcon == null
                    ? EdgeInsets.all(Dimensions.paddingCard)
                    : EdgeInsets.only(left: Dimensions.paddingCard),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: Dimensions.defaultTextSize,
                      ),
                    ),
                    if (widget.rightIcon != null)
                      IconButton(
                          onPressed: widget.rightIcon!.onPressRightIcon,
                          icon: Icon(widget.rightIcon!.rightIcon))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

class ImageDescriptionCard extends StatefulWidget {
  final String? imageUrl;
  final String description;
  final RightIcon? rightIcon;

  const ImageDescriptionCard(
      {Key? key,
      required this.imageUrl,
      required this.description,
      this.rightIcon})
      : super(key: key);

  @override
  _ImageDescriptionCardState createState() => _ImageDescriptionCardState();
}

class _ImageDescriptionCardState extends State<ImageDescriptionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 15),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(15), // No border radius for the card itself
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topRight,
            children: <Widget>[
              if (widget.imageUrl != null)
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    widget.imageUrl!,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Image.asset("assets/no-image.png", height: 160),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: widget.rightIcon == null
                    ? EdgeInsets.all(Dimensions.paddingCard)
                    : EdgeInsets.only(left: Dimensions.paddingCard),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.description,
                      style: TextStyle(
                        fontSize: Dimensions.defaultTextSize,
                      ),
                    ),
                    if (widget.rightIcon != null)
                      IconButton(
                          onPressed: widget.rightIcon!.onPressRightIcon,
                          icon: Icon(widget.rightIcon!.rightIcon))
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
