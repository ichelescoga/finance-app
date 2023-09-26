import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final EdgeInsetsGeometry padding;
  final Color color;
  final bool isLoading;

  const CustomButtonWidget(
      {required this.text,
      required this.onTap,
      this.padding = const EdgeInsets.only(left: 16.0, right: 16.0),
      this.color = AppColors.mainColor,
      this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child: Container(
          height: 50.0,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                const BorderRadius.all(Radius.circular(Dimensions.radius)),
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                  height: Dimensions.largeTextSize,
                  width: Dimensions.largeTextSize,
                  child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.officialWhite),
                )
                : Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Dimensions.largeTextSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
