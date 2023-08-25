import 'package:developer_company/shared/resources/colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;

  const CustomCard({Key? key, required this.onTap, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
          color: AppColors.secondaryMainColor, // Blue background color
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: child),
    );
  }
}
