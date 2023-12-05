import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:flutter/material.dart";

class ElevatedCustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final bool isLoading;
  final VoidCallback onPress;
  const ElevatedCustomButton(
      {Key? key,
      required this.color,
      required this.text,
      required this.isLoading,
      required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: isLoading ? null : onPress,
        child: isLoading
            ? SizedBox(
                height: Dimensions.largeTextSize,
                width: Dimensions.largeTextSize,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: AppColors.officialWhite),
              )
            : Text(text, style: TextStyle(color: Colors.white)));
  }
}
