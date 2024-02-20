import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/widgets/elevated_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogAcceptSell extends StatefulWidget {
  final String title;
  final String text;
  final String extraData;
  final Future Function() onPress;

  const DialogAcceptSell({
    Key? key,
    required this.title,
    required this.text,
    required this.extraData,
    required this.onPress
  }) : super(key: key);

  @override
  State<DialogAcceptSell> createState() => _DialogAcceptSellState();
}

class _DialogAcceptSellState extends State<DialogAcceptSell> {
  bool isLoading = false;

  process  () async{ 
    setState(() {
      isLoading = true;
    });
    await widget.onPress();
     setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.officialWhite,
      title: Text(widget.title),
      content: SingleChildScrollView(
        child: SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.text,
                  style: TextStyle(color: Colors.black),
                ),
                Text(widget.extraData.length > 0 ? "Su pago es de ${widget.extraData}": "")
              ],
            )),
      ),
      actions: [
              ElevatedCustomButton(
                color: AppColors.softMainColor,
                text: "Aceptar",
                isLoading: isLoading,
                onPress: () async => process(),
              ),
              ElevatedCustomButton(
                color: AppColors.secondaryMainColor,
                text: "Cerrar",
                isLoading: isLoading,
                onPress: () => Navigator.pop(context, false),
              )
            ],
    );
  }
}
