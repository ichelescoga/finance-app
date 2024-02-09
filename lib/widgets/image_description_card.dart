import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/utils/responsive.dart";
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

  final List<RightIcon>? rightIcons;

  const ImageFavoriteDescriptionCard(
      {Key? key,
      required this.onFavoriteChanged,
      required this.initialFavorite,
      required this.imageUrl,
      required this.description,
      this.showFavorite = true,
      this.rightIcons})
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
    Responsive responsive = Responsive(context);
    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Card(
        margin: EdgeInsets.only(bottom: 20),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10), // No border radius for the card itself
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
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.paddingCard, right: responsive.wp(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: responsive.hp(1.20),
                        ),
                      ),
                      if (widget.rightIcons != null)
                        Row(
                          children: [
                            if (widget.rightIcons != null)
                              for (final rightIcon in widget.rightIcons!)
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    IconButton(
                                        iconSize: responsive.hp(2.10),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: rightIcon.onPressRightIcon,
                                        icon: Icon(rightIcon.rightIcon))
                                  ],
                                )
                          ],
                        ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

class ImageDescriptionCard extends StatefulWidget {
  final String? imageUrl;
  final String description;
  final List<RightIcon>? rightIcons;
  final bool showChecked;
  final Function(bool) handleCheckedImageCard;
  final bool resetCheckImageCard;
  final Function(bool)? updateResetCheckCard;

  const ImageDescriptionCard({
    Key? key,
    required this.imageUrl,
    required this.handleCheckedImageCard,
    this.showChecked = false,
    required this.description,
    this.rightIcons,
    this.resetCheckImageCard = false,
    this.updateResetCheckCard,
  }) : super(key: key);

  @override
  _ImageDescriptionCardState createState() => _ImageDescriptionCardState();
}

class _ImageDescriptionCardState extends State<ImageDescriptionCard> {
  bool isCheckedCard = false;

  @override
  void didUpdateWidget(ImageDescriptionCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (isCheckedCard == true && widget.resetCheckImageCard == true) {
      setState(() => isCheckedCard = false);
      widget.updateResetCheckCard!(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive(context);

    return AspectRatio(
      aspectRatio: 4 / 3,
      child: Card(
        // color: AppColors.officialWhite,
        margin: EdgeInsets.only(bottom: 20),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(10),
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
                  AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Image.asset(
                        "assets/no-image.png",
                        width: double.infinity,
                        fit: BoxFit.contain,
                      )),
                if (widget.showChecked)
                  Container(
                      width: 40,
                      height: 40,
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: Checkbox(
                          value: isCheckedCard,
                          onChanged: (p0) {
                            setState(() {
                              isCheckedCard = p0!;
                            });
                            widget.handleCheckedImageCard(p0!);
                          })),
              ],
            ),
            Expanded(
              child: Padding(
                  padding: EdgeInsets.only(
                      left: Dimensions.paddingCard, right: responsive.wp(2)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.description,
                        style: TextStyle(
                          fontSize: responsive.hp(1.20),
                        ),
                      ),
                      if (widget.rightIcons != null)
                        Row(
                          children: [
                            if (widget.rightIcons != null)
                              for (final rightIcon in widget.rightIcons!)
                                Row(
                                  children: [
                                    SizedBox(width: 10),
                                    IconButton(
                                        iconSize: responsive.hp(2.10),
                                        padding: EdgeInsets.zero,
                                        constraints: BoxConstraints(),
                                        onPressed: rightIcon.onPressRightIcon,
                                        icon: Icon(rightIcon.rightIcon))
                                  ],
                                )
                          ],
                        ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
