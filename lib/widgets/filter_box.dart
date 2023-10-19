import "dart:convert";

import "package:developer_company/widgets/custom_input_widget.dart";
import "package:flutter/material.dart";

// typedef HandleFilter<T> = Function(List<T>);

class FilterBox<T> extends StatefulWidget {
  // final TextEditingController filterBoxController;
  final List<T> elements;
  final Function(List<T>) handleFilteredData;
  final bool isLoading;
  final String hint;
  final String label;

  const FilterBox({
    Key? key,
    required this.elements,
    required this.handleFilteredData,
    required this.isLoading,
    required this.hint,
    required this.label,
  }) : super(key: key);

  @override
  State<FilterBox<T>> createState() => _FilterBoxState<T>();
}

class _FilterBoxState<T> extends State<FilterBox<T>> {
  final TextEditingController filterBoxController = TextEditingController();

  List<T> data = [];
  List<T> filteredData = [];
  bool hasUpdate = false;

  @override
  void didUpdateWidget(FilterBox<T> oldWidget) {
    if (widget.elements.length > 0 && !hasUpdate) {
      data = widget.elements;
      hasUpdate = true;
    }
    super.didUpdateWidget(oldWidget);
  }

  filterByText() {
    List<T> suggestions = data.where((element) {
      // encode depends on toJson method in each model, be aware of field do you want to include in the search,
      // enhanced should be included in json.encode(element, functionToEncodable) to search another method to handle de values passed.
      final quote = json.encode(element).toLowerCase();
      return quote.contains(filterBoxController.text.toLowerCase());
    }).toList();

    widget.handleFilteredData(suggestions);
  }

  @override
  Widget build(BuildContext context) {
    filterBoxController.addListener(() => filterByText());

    return CustomInputWidget(
      controller: filterBoxController,
      label: widget.label,
      hintText: widget.hint,
      prefixIcon: Icons.search,
      readOnly: widget.isLoading,
      suffixIcon: IconButton(
        onPressed: () => filterBoxController.clear(),
        icon: const Icon(
          Icons.close,
          color: Colors.black,
        ),
      ),
    );
  }
}

// abstract class DataToFilter {
//   Map<String, dynamic> toJson();
// }
