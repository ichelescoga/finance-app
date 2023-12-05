import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/widgets/elevated_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImproveContactToClientDialog extends StatefulWidget {
  
  final bool isLoading;
  final Function() onPressSave;

  const ImproveContactToClientDialog(
      {Key? key,

      required this.isLoading,
      required this.onPressSave
      })
      : super(key: key);

  @override
  _ImproveContactToClientDialogState createState() => _ImproveContactToClientDialogState();
}

class _ImproveContactToClientDialogState extends State<ImproveContactToClientDialog> {
  final user = container.read(userProvider);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.officialWhite,
      title: Text("Convertir contacto a cliente"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Text("¿Desea convertir este contacto a un nuevo cliente para cotización?")
        ),
      ),
      actions: [
        ElevatedCustomButton(
          color: AppColors.softMainColor,
          text: "Aceptar",
          isLoading: widget.isLoading,
          onPress: widget.onPressSave,
        ),
        ElevatedCustomButton(
          color: AppColors.secondaryMainColor,
          text: "Regresar",
          isLoading: widget.isLoading,
          onPress: () => Navigator.pop(context, false),
        )
      ],
    );
  }
}
