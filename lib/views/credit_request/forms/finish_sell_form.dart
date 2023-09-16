import "package:developer_company/data/implementations/pre_sell_repository_impl.dart";
import "package:developer_company/data/models/pre_sell_model.dart";
import "package:developer_company/data/providers/pre_sell_provider.dart";
import "package:developer_company/data/repositories/pre_sell_respository.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/shared/resources/strings.dart";
import "package:developer_company/shared/services/quetzales_currency.dart";
import "package:developer_company/shared/validations/not_empty.dart";
import "package:developer_company/shared/validations/years_old_validator.dart";
import "package:developer_company/views/credit_request/controllers/finish_sell_form_controller.dart";
import "package:developer_company/views/credit_request/helpers/get_month_name.dart";
import "package:developer_company/views/credit_request/helpers/get_year_name.dart";
import "package:developer_company/widgets/custom_dropdown_widget.dart";
// import "package:developer_company/views/credit_request/helpers/get_month_name.dart";
import "package:developer_company/widgets/custom_input_widget.dart";
import "package:developer_company/widgets/date_picker.dart";
import "package:flutter/material.dart";

class FinishSellForm extends StatefulWidget {
  final String quoteId;
  final FinishSellController finishSellFormController;

  const FinishSellForm(
      {Key? key, required this.quoteId, required this.finishSellFormController})
      : super(key: key);

  @override
  _FinishSellFormState createState() => _FinishSellFormState();
}

class _FinishSellFormState extends State<FinishSellForm> {
  final textStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: Dimensions.extraLargeTextSize,
    overflow: TextOverflow.ellipsis,
  );

  final PreSellRepository preSellRepository =
      PreSellRepositoryImpl(PreSellProvider());

  void retrievePreSellData() async {
    PreSell preSellData =
        await preSellRepository.getInfoClientPreSell(widget.quoteId);
    widget.finishSellFormController.updateControllerPreSell(preSellData);
  }

  void updateRichText() {
    setState(() {});
  }

  int actualYear = DateTime.now().year;

  @override
  void initState() {
    super.initState();
    // Add listeners to controllers to update the Rich Text when the user enters text
    widget.finishSellFormController.city.addListener(updateRichText);
    widget.finishSellFormController.contractDate.addListener(updateRichText);
    widget.finishSellFormController.by.addListener(updateRichText);
    widget.finishSellFormController.nameOfPerson.addListener(updateRichText);
    widget.finishSellFormController.notary.addListener(updateRichText);
    widget.finishSellFormController.numberOfDocument
        .addListener(updateRichText);
    widget.finishSellFormController.typeOfDocument.addListener(updateRichText);
    widget.finishSellFormController.whereExtended.addListener(updateRichText);
    retrievePreSellData();

    // String asdf = getMonthName(DateTime.now());
    // print(asdf);
  }

  @override
  void dispose() {
    widget.finishSellFormController.city.dispose();
    widget.finishSellFormController.contractDate.dispose();
    widget.finishSellFormController.by.dispose();
    widget.finishSellFormController.nameOfPerson.dispose();
    widget.finishSellFormController.notary.dispose();
    widget.finishSellFormController.numberOfDocument.dispose();
    widget.finishSellFormController.typeOfDocument.dispose();
    widget.finishSellFormController.whereExtended.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text("Datos del Adquiriente", style: textStyle),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.fullName,
          label: "Nombre Completo",
          hintText: "Nombre Completo",
          prefixIcon: Icons.person),
      CustomDatePicker(
        controller: widget.finishSellFormController.birthDate,
        label: "Fecha de nacimiento",
        hintText: "Fecha de nacimiento",
        prefixIcon: Icons.date_range_outlined,
        validator: (value) {
          bool isDateValid = yearsOldValidator(value.toString(), 2);
          if (!isDateValid) {
            return "El cliente debe de ser mayor a 18 años";
          }
          if (value != null) return null;
          return "VALIDE CAMPOS";
        },
        initialDate: DateTime(actualYear - 1),
        firstDate: DateTime(actualYear - 90),
        lastDate: DateTime(actualYear),
      ),

      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.nationality,
          label: "Nacionalidad",
          hintText: "Nacionalidad",
          prefixIcon: Icons.person),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.civilStatus,
          label: "Estado Civil",
          hintText: "Estado Civil",
          prefixIcon: Icons.person),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.job,
          label: "Profesión u Oficio",
          hintText: "Profesión u Oficio",
          prefixIcon: Icons.person),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.location,
          label: "Residencia",
          hintText: "Residencia",
          prefixIcon: Icons.person),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.phone,
          label: "Teléfono",
          hintText: "Teléfono",
          keyboardType: TextInputType.phone,
          prefixIcon: Icons.person),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.addressJob,
          label: "Dirección de Trabajo",
          hintText: "Dirección de Trabajo",
          prefixIcon: Icons.person),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.phoneJob,
          keyboardType: TextInputType.phone,
          label: "Teléfono de Trabajo",
          hintText: "Teléfono de Trabajo",
          prefixIcon: Icons.person),
      CustomInputWidget(
          onFocusChangeInput: (hasFocus) {
            if (!hasFocus) {
              widget.finishSellFormController.monthlyIncome.text =
                  quetzalesCurrency(
                      widget.finishSellFormController.monthlyIncome.text);
            }
          },
          keyboardType: TextInputType.number,
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.monthlyIncome,
          label: "Ingreso Mensual",
          hintText: "Ingreso Mensual",
          prefixIcon: Icons.person),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.email,
          label: "Correo Electrónico",
          hintText: "Correo Electrónico",
          keyboardType: TextInputType.emailAddress,
          prefixIcon: Icons.person),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.identificationDocument,
          keyboardType: TextInputType.number,
          label: "Documento de Identificación",
          hintText: "Documento de Identificación",
          prefixIcon: Icons.person),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.whereGetDocument,
          label: "Extendido por",
          hintText: "Extendido por",
          prefixIcon: Icons.person),
      Text("Actúa en Representación Legal", style: textStyle),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.businessName,
          label: "Nombre, Razón social o Denominación Social",
          hintText: "Nombre, Razón social o Denominación Social",
          prefixIcon: Icons.abc),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.copyBusinessName,
          label: "Adjuntar Fotocopia de la Representación",
          hintText: "Adjuntar Fotocopia de la Representación",
          prefixIcon: Icons.abc),
      Text("Referencias", style: textStyle),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.referenceOneFullName,
          label: "Nombres Y apellidos",
          hintText: "Nombres Y apellidos",
          prefixIcon: Icons.abc),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.referenceOneFullContact,
          label: "Residencia y Teléfono",
          hintText: "Residencia y Teléfono",
          prefixIcon: Icons.abc),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.referenceTwoFullName,
          label: "Nombres Y apellidos",
          hintText: "Nombres Y apellidos",
          prefixIcon: Icons.abc),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.referenceTwoFullContact,
          label: "Residencia y Teléfono",
          hintText: "Residencia y Teléfono",
          prefixIcon: Icons.abc),
      Text("Datos del Lote Conforme al Plano", style: textStyle),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.loteNumber,
          label: "Lote Numero",
          hintText: "Lote Numero",
          prefixIcon: Icons.house),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.sector,
          label: "Sector",
          hintText: "Sector",
          prefixIcon: Icons.house),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.area,
          label: "Area",
          hintText: "Area",
          prefixIcon: Icons.house),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.squareMeters,
          label: "M^2",
          hintText: "M^2",
          prefixIcon: Icons.house),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.equivalencyMeters,
          label: "Equivalente A",
          hintText: "Equivalente A",
          prefixIcon: Icons.house),
      Text("Datos de Negociación", style: textStyle),
      CustomInputWidget(
          onFocusChangeInput: (hasFocus) {
            if (!hasFocus) {
              widget.finishSellFormController.totalOfLote.text =
                  quetzalesCurrency(
                      widget.finishSellFormController.totalOfLote.text);
            }
          },
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.totalOfLote,
          keyboardType: TextInputType.number,
          label: "Valor Total del Lote",
          hintText: "Valor Total del Lote",
          prefixIcon: Icons.monetization_on),
      CustomInputWidget(
          onFocusChangeInput: (hasFocus) {
            if (!hasFocus) {
              widget.finishSellFormController.totalOfEnhancesLote.text =
                  quetzalesCurrency(
                      widget.finishSellFormController.totalOfEnhancesLote.text);
            }
          },
          keyboardType: TextInputType.number,
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.totalOfEnhancesLote,
          label: "Valor de las mejoras",
          hintText: "Valor de las mejoras",
          prefixIcon: Icons.monetization_on),
      Text("Forma de pago", style: textStyle),

      SwitchListTile(
        inactiveThumbColor: AppColors.greenColor,
        title: Text(
          widget.finishSellFormController.cashPriceOrCredit
              ? "Reserva al Crédito"
              : "Reserva Al Contado",
          style: TextStyle(color: Colors.black),
        ),
        value: widget.finishSellFormController.cashPriceOrCredit,
        onChanged: (bool value) {
          setState(() {
            widget.finishSellFormController.cashPriceOrCredit = value;
          });
        },
        activeColor: AppColors.softMainColor,
      ),

      CustomInputWidget(
          onFocusChangeInput: (hasFocus) {
            if (!hasFocus) {
              widget.finishSellFormController.reserveCashPrice.text =
                  quetzalesCurrency(
                      widget.finishSellFormController.reserveCashPrice.text);
            }
          },
          keyboardType: TextInputType.number,
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.reserveCashPrice,
          label: "Reserva al Contado",
          hintText: "Reserva al Contado",
          prefixIcon: Icons.attach_money_sharp),

      //TODO SWITCH TO MARK CASH PRICE
      CustomInputWidget(
          onFocusChangeInput: (hasFocus) {
            if (!hasFocus) {
              widget.finishSellFormController.reserveCredit.text =
                  quetzalesCurrency(
                      widget.finishSellFormController.reserveCredit.text);
            }
          },
          keyboardType: TextInputType.number,
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.reserveCredit,
          label: "Reserva al Crédito",
          hintText: "Reserva al Crédito",
          prefixIcon: Icons.attach_money_sharp),
      CustomInputWidget(
          onFocusChangeInput: (hasFocus) {
            if (!hasFocus) {
              widget.finishSellFormController.enganche.text = quetzalesCurrency(
                  widget.finishSellFormController.enganche.text);
            }
          },
          keyboardType: TextInputType.number,
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.enganche,
          label: "Enganche",
          hintText: "Enganche",
          prefixIcon: Icons.attach_money_sharp),
      CustomInputWidget(
          onFocusChangeInput: (hasFocus) {
            if (!hasFocus) {
              widget.finishSellFormController.monthlyBalance.text =
                  quetzalesCurrency(
                      widget.finishSellFormController.monthlyBalance.text);
            }
          },
          keyboardType: TextInputType.number,
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.monthlyBalance,
          label: "Saldo: Cuotas Fijas",
          hintText: "Saldo: Cuotas Fijas",
          prefixIcon: Icons.attach_money_sharp),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.numberOfPayments,
          label: "Numero de Cuotas",
          hintText: "Numero de Cuotas",
          keyboardType: TextInputType.number,
          prefixIcon: Icons.attach_money_sharp),
      CustomInputWidget(
          onFocusChangeInput: (hasFocus) {
            if (!hasFocus) {
              widget.finishSellFormController.valueOfEachPayment.text =
                  quetzalesCurrency(
                      widget.finishSellFormController.valueOfEachPayment.text);
            }
          },
          keyboardType: TextInputType.number,
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.valueOfEachPayment,
          label: "Valor de Cada Cuota",
          hintText: "Valor de Cada Cuota",
          prefixIcon: Icons.attach_money_sharp),
      Text("Suscripción y Aceptación ", style: textStyle),

      // FINAL
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.city,
          label: "Ciudad",
          hintText: "Ciudad",
          prefixIcon: Icons.file_present_rounded),
      CustomDatePicker(
          controller: widget.finishSellFormController.contractDate,
          label: "Fecha de Contrato",
          hintText: "Fecha de Contrato",
          validator: (value) => null,
          prefixIcon: Icons.date_range_outlined,
          initialDate: DateTime.now(),
          firstDate: DateTime(actualYear - 90),
          lastDate: DateTime(actualYear)),

      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.by,
          label: "Representante Legal de Inmobiliaria",
          hintText: "Representante Legal de Inmobiliaria",
          prefixIcon: Icons.file_present_rounded),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.nameOfPerson,
          label: "Nuevo Dueño",
          hintText: "Nuevo Dueño",
          prefixIcon: Icons.file_present_rounded),

      CustomDropdownWidget(
          labelText: "Tipo de documento",
          hintText: "Tipo de documento",
          selectedValue: widget.finishSellFormController.typeOfDocument.text,
          items: widget.finishSellFormController.typeOfDocumentList
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onValueChanged: (String? newValue) {
            widget.finishSellFormController.typeOfDocument.text = newValue!;
          },
          validator: (String? value) {
            if (value == null || value.isEmpty) {
              return Strings.pleaseFillOutTheField;
            }
            return null;
          },
          prefixIcon: const Icon(Icons.person_outline)),

      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.numberOfDocument,
          label: "Numero de Documento",
          hintText: "Numero de Documento",
          prefixIcon: Icons.file_present_rounded),
      CustomInputWidget(
          validator: (value) => notEmptyFieldValidator(value),
          controller: widget.finishSellFormController.whereExtended,
          label: "Extendido En",
          hintText: "Extendido En",
          prefixIcon: Icons.file_present_rounded),

      RichText(
          text: TextSpan(
              text:
                  "Suscripción y aceptación del contenido íntegro del presente documento:",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.extraLargeTextSize,
                  overflow: TextOverflow.ellipsis,
                  color: Colors.black))),
      SizedBox(height: 30),

      RichText(
          text: TextSpan(
        style: TextStyle(fontSize: 16, color: Colors.black),
        children: [
          TextSpan(text: 'En la ciudad de '),
          TextSpan(
            text: widget.finishSellFormController.city.text.isNotEmpty
                ? widget.finishSellFormController.city.text
                : '___',
            style: TextStyle(
              color: widget.finishSellFormController.city.text.isNotEmpty
                  ? Colors.black
                  : Colors.blue,
            ),
          ),
          TextSpan(text: ' el día '),
          TextSpan(
            text: widget.finishSellFormController.contractDate.text.isNotEmpty
                ? widget.finishSellFormController.contractDate.text
                : '___',
            style: TextStyle(
              color:
                  widget.finishSellFormController.contractDate.text.isNotEmpty
                      ? Colors.black
                      : Colors.blue,
            ),
          ),
          TextSpan(text: ' del mes de '),
          TextSpan(
            text: widget.finishSellFormController.contractDate.text.isNotEmpty
                ? getMonthSpanishName(
                    widget.finishSellFormController.contractDate.text)
                : '___',
            style: TextStyle(
              color:
                  widget.finishSellFormController.contractDate.text.isNotEmpty
                      ? Colors.black
                      : Colors.blue,
            ),
          ),
          TextSpan(text: ' del año dos mil '),
          TextSpan(
            text: widget.finishSellFormController.contractDate.text.isNotEmpty
                ? getYearName(widget.finishSellFormController.contractDate.text)
                : '___',
            style: TextStyle(
              color:
                  widget.finishSellFormController.contractDate.text.isNotEmpty
                      ? Colors.black
                      : Colors.blue,
            ),
          ),
          TextSpan(
              text:
                  ' , como Notario DOY FE: que las firmas que anteceden son auténticas por haber sido reconocidas a mi presencia, el día de hoy, por '),
          TextSpan(
            text: widget.finishSellFormController.by.text.isNotEmpty
                ? widget.finishSellFormController.by.text
                : '___',
            style: TextStyle(
              color: widget.finishSellFormController.by.text.isNotEmpty
                  ? Colors.black
                  : Colors.blue,
            ),
          ),
          TextSpan(
              text:
                  ' , representante legal de GRUPO CORPORATIVO DE INVERSIONES INMOBILIARIAS PARA EL DESARROLLO, SOCIEDAD ANONIMA (GRUCIDESA), de mi conocimiento, y '),
          TextSpan(
            text: widget.finishSellFormController.nameOfPerson.text.isNotEmpty
                ? widget.finishSellFormController.nameOfPerson.text
                : '___',
            style: TextStyle(
              color:
                  widget.finishSellFormController.nameOfPerson.text.isNotEmpty
                      ? Colors.black
                      : Colors.blue,
            ),
          ),
          TextSpan(text: '  identificado con '),
          TextSpan(
            text: widget.finishSellFormController.typeOfDocument.text.isNotEmpty
                ? widget.finishSellFormController.typeOfDocument.text
                : '___',
            style: TextStyle(
              color:
                  widget.finishSellFormController.typeOfDocument.text.isNotEmpty
                      ? Colors.black
                      : Colors.blue,
            ),
          ),
          TextSpan(text: ' numero '),
          TextSpan(
            text:
                widget.finishSellFormController.numberOfDocument.text.isNotEmpty
                    ? widget.finishSellFormController.numberOfDocument.text
                    : '___',
            style: TextStyle(
              color: widget
                      .finishSellFormController.numberOfDocument.text.isNotEmpty
                  ? Colors.black
                  : Colors.blue,
            ),
          ),
          TextSpan(text: ' extendido por '),
          TextSpan(
            text: widget.finishSellFormController.whereExtended.text.isNotEmpty
                ? widget.finishSellFormController.whereExtended.text
                : '___',
            style: TextStyle(
              color:
                  widget.finishSellFormController.whereExtended.text.isNotEmpty
                      ? Colors.black
                      : Colors.blue,
            ),
          ),
          TextSpan(text: ', quienes firman la presente.'),
        ],
      )),
    ]);
  }
}
