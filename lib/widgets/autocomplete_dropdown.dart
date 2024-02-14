import 'package:developer_company/widgets/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

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
  final Function(bool)? resetClean;
  final OnTextChangeCallback onTextChange;
  final TextEditingController? textController;
  final bool clean;

  const AutocompleteDropdownWidget({
    Key? key,
    required this.listItems,
    required this.onSelected,
    required this.label,
    required this.hintText,
    required this.onFocusChange,
    this.resetClean,
    required this.onTextChange,
    this.textController,
    this.clean = true,
  }) : super(key: key);

  @override
  State<AutocompleteDropdownWidget> createState() =>
      _AutocompleteDropdownWidgetState();
}

class _AutocompleteDropdownWidgetState
    extends State<AutocompleteDropdownWidget> {
  DropDownOption? selectedOption;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final widgetController = widget.textController;
    if (widgetController != null) {
      textEditingController = widgetController;
    }
  }

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
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<DropDownOption> onSelected,
          Iterable<DropDownOption> options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 200),
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      widget.onSelected(option);
                      onSelected(option);
                    },
                    child: Builder(builder: (BuildContext context) {
                      final bool highlight =
                          AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      return Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child: Text(option.label),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
