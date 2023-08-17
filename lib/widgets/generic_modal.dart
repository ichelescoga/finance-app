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
