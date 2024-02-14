import 'package:developer_company/controllers/quick_client_contact_dialog_controller.dart';
import 'package:developer_company/data/implementations/client_contact_impl.dart';
import 'package:developer_company/data/models/client_contact_model.dart';
import 'package:developer_company/data/providers/client_contact_provider.dart';
import 'package:developer_company/data/repositories/client_contact_repository.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/validations/email_validator.dart';
import 'package:developer_company/shared/validations/not_empty.dart';
import 'package:developer_company/shared/validations/string_length_validator.dart';
import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:developer_company/widgets/elevated_custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class AddNewQuickContact extends StatefulWidget {
  final QuickClientContactDialogController quickClientContactController;
  final bool isEditing;

  const AddNewQuickContact(
      {Key? key,
      required this.quickClientContactController,
      required this.isEditing})
      : super(key: key);

  @override
  _AddNewQuickContactState createState() => _AddNewQuickContactState();
}

class _AddNewQuickContactState extends State<AddNewQuickContact> {
  final _formKeyQuickClientContact = GlobalKey<FormState>();
  bool isLoading = false;
  final user = container.read(userProvider);

  final QuickClientContactRepository quickContactProvider =
      QuickClientContactRepositoryImpl(QuickClientContactProvider());

  _handleAddNewAlbum() async {
    final projectId = user.project.projectId;

    if (_formKeyQuickClientContact.currentState!.validate()) {
      setState(() => isLoading = true);
      try {
        final QuickClientContacts contactInfo = QuickClientContacts(
            contactId: widget.quickClientContactController.contactId,
            projectId: int.parse(projectId),
            state: widget.quickClientContactController.isActive,
            fullName: widget.quickClientContactController.fullName.text,
            phone: widget.quickClientContactController.phone.text,
            email: widget.quickClientContactController.email.text,
            address: widget.quickClientContactController.address.text);

        if (widget.isEditing) {
          await quickContactProvider.editClientContact(contactInfo);
        } else {
          await quickContactProvider.addNewClientContact(contactInfo);
        }

        setState(() => isLoading = false);
        Navigator.pop(context, true);
        widget.quickClientContactController.clearController();
      } catch (e) {
        EasyLoading.showError("Algo salio mal. Intente Mas Tarde");
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.officialWhite,
      title: Text("Agregar Nuevo Contacto"),
      content: SingleChildScrollView(
        child: SizedBox(
          width: Get.width,
          child: Form(
            key: _formKeyQuickClientContact,
            child: Column(children: [
              CustomInputWidget(
                  controller: widget.quickClientContactController.fullName,
                  validator: (value) => notEmptyFieldValidator(value),
                  label: "Nombre Completo",
                  hintText: "Nombre Completo",
                  prefixIcon: Icons.person),
              CustomInputWidget(
                  controller: widget.quickClientContactController.phone,
                  validator: (value) {
                    final emailValue = emailValidator(
                        widget.quickClientContactController.email.text);

                    if (value!.length < 7 && widget.quickClientContactController.email.text.length == 0) {
                      return "Este campo es obligatorio";
                    }

                    if (emailValue != null) {
                      return null;
                    }
               
                    if (value.length > 1) {
                      return stringLengthValidator(value, 8, 20)
                          ? null
                          : "Por favor verifique el numero telefónico";
                    }
                    return null;
                  },
                  label: "Teléfono",
                  hintText: "Teléfono",
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone),
              CustomInputWidget(
                  controller: widget.quickClientContactController.email,
                  validator: (value) {
                    final phoneValue = stringLengthValidator(value, 8, 20);
                    if (phoneValue) {
                      return null;
                    }
                    if (value == null) return null;

                    return emailValidator(value);
                  },
                  label: "Correo Electrónico",
                  hintText: "Correo Electrónico",
                  keyboardType: TextInputType.emailAddress,
                  prefixIcon: Icons.email),
              CustomInputWidget(
                  controller: widget.quickClientContactController.address,
                  label: "Dirección",
                  hintText: "Dirección",
                  prefixIcon: Icons.location_on),
            ]),
          ),
        ),
      ),
      actions: [
        ElevatedCustomButton(
          color: AppColors.softMainColor,
          text: "Guardar",
          isLoading: isLoading,
          onPress: () => _handleAddNewAlbum(),
        ),
        ElevatedCustomButton(
          color: AppColors.secondaryMainColor,
          text: "Regresar",
          isLoading: isLoading,
          onPress: () => Navigator.pop(context, false),
        )
      ],
    );
  }
}
