import 'package:developer_company/shared/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomTwoPartsCard extends StatefulWidget {
  final double height;
  final Widget title;
  final String bodyText;

  CustomTwoPartsCard({
    Key? key,
    required this.height,
    required this.title,
    required this.bodyText,
  }) : super(key: key);

  @override
  _CustomTwoPartsCardState createState() => _CustomTwoPartsCardState();
}

class _CustomTwoPartsCardState extends State<CustomTwoPartsCard> {
  @override
  Widget build(BuildContext context) {
    double titleHeight = widget.height * 0.6;
    double bottomHeight = widget.height * 0.4;

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 5,
      shadowColor: Colors.grey,
      child: Container(
        height: widget.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.greyColor90,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
              ), 
              height: titleHeight, // 70% for the title part
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: widget.title,
              ),
            ),
            Container(
              height: bottomHeight,
              decoration: BoxDecoration(
                color: AppColors.softMainColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15.0),
                  bottomRight: Radius.circular(15.0),
                ),
              ),
              width: double.infinity,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.bodyText,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
