import 'package:developer_company/shared/resources/colors.dart';
import 'package:flutter/material.dart';

class GenericModal extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget actions;
  final double alertHeight;
  final double alertWidth;

  GenericModal(
      {required this.title, required this.child, required this.actions, required this.alertHeight, required this.alertWidth});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.officialWhite,
      title: Text(title),
      content: SizedBox(
        height: alertHeight,
        width: alertWidth,
        child: child,
      ),
      actions: [actions],
    );
  }
}
