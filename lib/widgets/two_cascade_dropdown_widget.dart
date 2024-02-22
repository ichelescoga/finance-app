import 'package:developer_company/data/implementations/CDI/cdi_repository_impl.dart';
import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';
import 'package:developer_company/utils/cdi_functions.dart';
import 'package:developer_company/widgets/CDI/autoComplete_with_controller.dart';
import 'package:flutter/material.dart';
// import 'package:developer_company/utils/cdi_components.dart';
import 'package:developer_company/widgets/autocomplete_dropdown.dart';

class TwoDropdownCascade extends StatefulWidget {
  final List<DropDownOption> fatherOptions;
  final String onSelectedFather;
  final Function(String) onFatherSelectedId;
  final Function(String) onChildrenSelected;
  final String childrenDropdownEndpoint;
  final String childrenDropdownKeys;
  final String defaultSelectedFather;
  final TextEditingController childrenController;
  final dynamic childrenWidgetEP;
  final dynamic fatherWidgetEP;

  const TwoDropdownCascade(
      {required this.fatherOptions,
      required this.onSelectedFather,
      required this.onFatherSelectedId,
      required this.onChildrenSelected,
      required this.childrenDropdownEndpoint,
      required this.childrenDropdownKeys,
      required this.defaultSelectedFather,
      required this.childrenController,
      required this.childrenWidgetEP,
      required this.fatherWidgetEP,
      });

  @override
  _TwoDropdownCascadeState createState() => _TwoDropdownCascadeState();
}

class _TwoDropdownCascadeState extends State<TwoDropdownCascade> {
  String selectedChildren = "";
  List<DropDownOption> childrenOptions = [];

  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());
  String fatherId = "";
  bool childrenClean = true;
  bool isLoadingChildren = true;

  resetValueChildren(p0) {
    setState(
      () {
        childrenClean = true;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    // Initialize subDepartments based on the initially selected department
    updateChildrenDropdownOptions(widget.onSelectedFather);
  }

  Future updateChildrenDropdownOptions(String fatherSelected) async {
    setState(() {
      isLoadingChildren = true;
    });
    List<DropDownOption> childrenOpts = await getDropdownOptions(
        "${widget.childrenDropdownEndpoint}/${fatherId}",
        widget.childrenDropdownKeys);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isLoadingChildren = false;
      childrenOptions = childrenOpts;
      // childrenOptions.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Dropdown for Father Dropdown
        AutocompleteDropdownWidget(
          key: Key("fatherDropdown"),
          listItems: widget.fatherOptions,
          onSelected: (selected) async {
            widget.onFatherSelectedId(selected.id);
            setState(() {
              // Reset the selected children when the father changes
              selectedChildren = "";
              childrenOptions.clear();
              childrenClean = false;
              widget.childrenController.clear();
            });
            fatherId = selected.id;
            await updateChildrenDropdownOptions(selected.id);
          },
          label: widget.fatherWidgetEP["Place_holder"]!,
          hintText: widget.fatherWidgetEP["Place_holder"]!,
          onFocusChange: ((p0) {}),
          onTextChange: (p0) async {
            setState(() {
              widget.childrenController.clear();
            });
            return widget.fatherOptions
                .where((element) =>
                    element.label.toLowerCase().contains(p0.toLowerCase()))
                .toList();
          },
        ),
        // Second Dropdown for Sub-Departments
        if (!isLoadingChildren)
          AutocompleteDropdownWithController(
            key: Key("childrenDropdown"),
            textEditingController: widget.childrenController,
            listItems: childrenOptions,
            onSelected: (selected) {
              setState(() {
                selectedChildren = selected.id;
              });
              widget.onChildrenSelected(selected.id);
            },
            label: widget.childrenWidgetEP["Place_holder"]!,
            hintText: widget.childrenWidgetEP["Place_holder"]!,
            onFocusChange: ((p0) {}),
            onTextChange: (p0) async {
              return childrenOptions
                  .where((element) =>
                      element.label.toLowerCase().contains(p0.toLowerCase()))
                  .toList();
            },
          ),
      ],
    );
  }
}
