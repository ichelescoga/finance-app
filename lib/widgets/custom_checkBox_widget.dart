// import 'package:developer_company/shared/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color selectedColor;
  final Color unSelectedColor;
  final Color checkColor;

  const CustomCheckbox(
      {Key? key,
      required this.value,
      required this.onChanged,
      required this.selectedColor,
      required this.unSelectedColor,
      required this.checkColor})
      : super(key: key);

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  // bool? _value;

  @override
  void initState() {
    super.initState();
    // _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          widget.onChanged!(widget.value);
          // _value = !_value!;
        });
      },
      child: Container(
        width: 20.0,
        height: 20.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.value ? widget.selectedColor : widget.unSelectedColor,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: widget.value
            ? Icon(
                Icons.check,
                size: 16.0,
                color: widget.checkColor,
              )
            : null,
      ),
    );
  }
}
