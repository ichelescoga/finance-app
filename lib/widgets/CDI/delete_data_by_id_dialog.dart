import 'package:developer_company/data/implementations/company_repository_impl.dart';
import 'package:developer_company/data/providers/company_provider.dart';
import 'package:developer_company/data/repositories/company_repository.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/widgets/elevated_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeleteCompanyDialog extends StatefulWidget {
  final int companyId;
  final String companyName;

  const DeleteCompanyDialog({
    Key? key,
    required this.companyId,
    required this.companyName,
  }) : super(key: key);

  @override
  State<DeleteCompanyDialog> createState() => _DeleteCompanyDialogState();
}

class _DeleteCompanyDialogState extends State<DeleteCompanyDialog> {
  bool isLoading = false;
  CompanyRepository companyProvider = CompanyRepositoryImpl(CompanyProvider());

  _handleDelete() async {
    setState(() => isLoading = true);
    try {
      await companyProvider.deleteCompany(widget.companyId);
    } finally {
      setState(() => isLoading = false);
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.officialWhite,
      title: Text("Desactivar Empresa"),
      content: SingleChildScrollView(
        child: SizedBox(
            width: Get.width,
            child: Text(
                "¿Esta seguro de Desactivar la empresa ${widget.companyName}?")),
      ),
      actions: [
        ElevatedCustomButton(
          color: AppColors.softMainColor,
          text: "Aceptar",
          isLoading: isLoading,
          onPress: () async => _handleDelete(),
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
