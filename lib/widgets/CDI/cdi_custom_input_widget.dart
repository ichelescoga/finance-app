import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:flutter/material.dart';

class CustomInputWidget extends StatefulWidget {
  // final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChange; // Optional onChange callback
  final VoidCallback? onTap; // Optional onChange callback
  final Function(PointerDownEvent)? onTapOutside; // Optional onChange callback
  final Function(bool)? onFocusChangeInput;
  final FocusNode? focusNode;
  final Function(String)? onFieldSubmitted ;

  const CustomInputWidget(
      {Key? key,
      // required this.controller,
      required this.label,
      required this.hintText,
      required this.prefixIcon,
      this.onFocusChangeInput,
      this.keyboardType = TextInputType.text,
      this.validator,
      this.readOnly = false,
      this.enabled = true,
      this.obscureText = false,
      this.onChange,
      this.onTap,
      this.onTapOutside,
      this.suffixIcon,
      this.focusNode,
      this.onFieldSubmitted
      })
      : super(key: key);

  @override
  State<CustomInputWidget> createState() => _CustomInputWidgetState();
}

class _CustomInputWidgetState extends State<CustomInputWidget> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: Dimensions.heightSize *
              0.5, // You should replace this with the actual value
        ),
        Focus(
          onFocusChange: widget.onFocusChangeInput != null
              ? (hasFocus) => widget.onFocusChangeInput!(hasFocus)
              : null,
          child: TextFormField(
            focusNode: widget.focusNode,
            onFieldSubmitted: widget.onFieldSubmitted,
            readOnly: widget.readOnly,
            onTapOutside: widget.onTapOutside,
            obscureText: widget.obscureText,
            onTap: widget.onTap,
            onChanged: widget.onChange,
            enabled: widget.enabled,
            style: CustomStyle
                .textStyle, // Make sure to define CustomStyle.textStyle
            controller: _textEditingController,
            keyboardType: widget.keyboardType,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.hintText,
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
              prefixIcon: Icon(widget.prefixIcon),
              suffixIcon: widget.suffixIcon,
            ),
          ),
        ),
        const SizedBox(
          height: Dimensions.heightSize,
        ),
      ],
    );
  }
}
