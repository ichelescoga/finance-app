import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:flutter/material.dart';

class CustomInputWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final bool enabled;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange; // Optional onChange callback
  final VoidCallback? onTap; // Optional onChange callback

  const CustomInputWidget(
      {Key? key,
      required this.controller,
      required this.label,
      required this.hintText,
      required this.prefixIcon,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.enabled = true,
      this.onChange,
      this.onTap
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: Dimensions.heightSize *
              0.5, // You should replace this with the actual value
        ),
        TextFormField(
          onTap: onTap,
          onChanged: onChange,
          enabled: enabled,
          style: CustomStyle
              .textStyle, // Make sure to define CustomStyle.textStyle
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            labelStyle: CustomStyle.textStyle,
            filled: true,
            fillColor: AppColors.lightColor,
            hintStyle: CustomStyle.textStyle,
            focusedBorder: CustomStyle.focusBorder,
            enabledBorder: CustomStyle.focusErrorBorder,
            focusedErrorBorder: CustomStyle.focusErrorBorder,
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
