import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:flutter/material.dart';

class DropDownOption {
  final String id;
  final String label;

  DropDownOption({required this.id, required this.label});
}
typedef OnTextChangeCallback = Future<List<DropDownOption>> Function(String);

class AutocompleteDropdownWidget extends StatefulWidget {
  final List<DropDownOption> listItems;
  final Function(DropDownOption) onSelected;
  final String label;
  final String hintText;
  final Function(bool) onFocusChange;
  final List<DropDownOption> Function(String) onTextChange;

  const AutocompleteDropdownWidget(
      {required this.listItems,
      required this.onSelected,
      required this.label,
      required this.hintText,
      required this.onFocusChange,
      required this.onTextChange});

  @override
  State<AutocompleteDropdownWidget> createState() =>
      _AutocompleteDropdownWidgetState();
}

class _AutocompleteDropdownWidgetState
    extends State<AutocompleteDropdownWidget> {
  late DropDownOption selectedOption;
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Autocomplete<DropDownOption>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        return widget.onTextChange(textEditingValue.text);
      },
      onSelected: (DropDownOption option) {
        setState(() {
          selectedOption = option;
        });
        widget.onSelected(option);
      },
      displayStringForOption: (DropDownOption option) => option.label,
      fieldViewBuilder: (
        BuildContext context,
        textEditingController,
        FocusNode focusNode,
        VoidCallback onFieldSubmitted,
      ) {
        return CustomInputWidget(
          onFocusChangeInput: (p0) => widget.onFocusChange(p0),
          focusNode: focusNode,
          onFieldSubmitted: (String value) {
            onFieldSubmitted();
          },
          controller: textEditingController,
          label: widget.label,
          hintText: widget.hintText,
          prefixIcon: Icons.person_outline,
        );
      },
    );
  }
}
