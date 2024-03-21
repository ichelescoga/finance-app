import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/custom_style.dart';
import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:developer_company/widgets/autocomplete_dropdown.dart';
import 'package:flutter/material.dart';

class CustomDropdownV2Widget extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List<DropDownOption> items;
  final String? Function(DropDownOption?)? validator;
  final Icon prefixIcon;
  final TextEditingController textEditingController;
  final ValueChanged<DropDownOption?> onValueChanged;

  CustomDropdownV2Widget({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.validator,
    required this.prefixIcon,
    required this.textEditingController,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  State<CustomDropdownV2Widget> createState() => _CustomDropdownV2WidgetState();
}

class _CustomDropdownV2WidgetState extends State<CustomDropdownV2Widget> {
  DropDownOption? _selectedValue; // Internal selected value

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: Dimensions.heightSize * 0.5,
        ),
        DropdownButtonFormField<DropDownOption>(
          style: CustomStyle.textStyle,
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            widget.onValueChanged(value);
            widget.textEditingController.text = value?.id ?? '';
          },
          value: _selectedValue,
          items: widget.items.map((DropDownOption option) {
            return DropdownMenuItem<DropDownOption>(
              value: option,
              child: Text(option.label),
            );
          }).toList(),
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
            prefixIcon: widget.prefixIcon,
          ),
        ),
        const SizedBox(
          height: Dimensions.heightSize,
        ),
      ],
    );
  }
}
