import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:flutter/material.dart';

class CustomLabelWidget extends StatelessWidget {
  final String title;
  final String label;
  final IconData prefixIcon;
  final TextEditingController controller;

  CustomLabelWidget({
    Key? key,
    required this.title,
    required this.label,
    required this.prefixIcon,
  })  : controller = TextEditingController(text: label),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: Dimensions.heightSize *
              0.5, // You should replace this with the actual value
        ),
        TextField(
          readOnly: true,
          controller: controller,
          style: CustomStyle
              .textStyle, // Make sure to define CustomStyle.textStyle
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            labelStyle: CustomStyle.textStyle,
            filled: true,
            fillColor: AppColors.lightColor,
            hintStyle: CustomStyle.textStyle,
            focusedBorder: CustomStyle.focusBorder,
            enabledBorder: CustomStyle.focusErrorBorder,
            errorBorder: CustomStyle.focusErrorBorder,
            prefixIcon: Icon(prefixIcon),
          ),
        ),
        const SizedBox(
          height: Dimensions.heightSize,
        ),
      ],
    );
  }
}
