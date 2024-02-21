import 'package:developer_company/controllers/cdi_check_button_controller.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:flutter/material.dart';
 
class CDICheckButton extends StatefulWidget {
  final String text;
  final CDICheckController controller;

  CDICheckButton({Key? key, required this.text, required this.controller}) : super(key: key);

  @override
  _CDICheckButtonState createState() => _CDICheckButtonState();
}

class _CDICheckButtonState extends State<CDICheckButton> {
  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
    title:
        Text(widget.text, style: TextStyle(color: Colors.black)),
    value: widget.controller.isChecked,
    onChanged: (bool value)  {
      widget.controller.isChecked = value;
      setState(() {});
    },
    activeColor: AppColors.secondaryMainColor,
  );
  }
}