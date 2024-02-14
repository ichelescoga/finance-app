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

  const TwoDropdownCascade(
      {required this.fatherOptions,
      required this.onSelectedFather,
      required this.onFatherSelectedId,
      required this.onChildrenSelected,
      required this.childrenDropdownEndpoint,
      required this.childrenDropdownKeys,
      required this.defaultSelectedFather,
      required this.childrenController});

  @override
  _TwoDropdownCascadeState createState() => _TwoDropdownCascadeState();
}

class _TwoDropdownCascadeState extends State<TwoDropdownCascade> {
  String selectedSubDepartment = "";
  List<DropDownOption> childrenOptions = [];

  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());
  String fatherId = "";
  bool childrenClean = true;

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
    List<DropDownOption> childrenOpts = await getDropdownOptions(
        "${widget.childrenDropdownEndpoint}/${fatherId}",
        widget.childrenDropdownKeys);
    setState(() {
      childrenOptions = childrenOpts;
      // childrenOptions.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Dropdown for Departments
        AutocompleteDropdownWidget(
          key: Key("fatherDropdown"),
          listItems: widget.fatherOptions,
          onSelected: (selected) async {
            widget.onFatherSelectedId(selected.id);
            setState(() {
              // Reset the selected sub-department when the department changes
              selectedSubDepartment = "";
              childrenOptions.clear();
              childrenClean = false;
              
              widget.childrenController.clear();
            });
            fatherId = selected.id;
            await updateChildrenDropdownOptions(selected.id);
          },
          label: "Departments",
          hintText: "Select Department",
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
        AutocompleteDropdownWithController(
          key: Key("childrenDropdown"),
          textEditingController: widget.childrenController,
          listItems: childrenOptions,
          onSelected: (selected) {
            setState(() {
              selectedSubDepartment = selected.id;
            });
            widget.onChildrenSelected(selected.id);
          },
          label: "Sub-Departments",
          hintText: "Select Sub-Department",
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
