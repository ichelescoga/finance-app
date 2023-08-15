import 'package:flutter/material.dart';

class GenericModal extends StatelessWidget {
  final String title;
  final Widget child;
  final Widget actions; // New parameter

  GenericModal(
      {required this.title, required this.child, required this.actions});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: child,
      actions: [actions], // Display the actions child widget
    );
  }
}
