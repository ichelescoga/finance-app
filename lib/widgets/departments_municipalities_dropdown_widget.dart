import 'package:developer_company/data/implementations/CDI/cdi_repository_impl.dart';
import 'package:developer_company/data/providers/CDI/cdi_provider.dart';
import 'package:developer_company/data/repositories/CDI/cdi_repository.dart';
import 'package:flutter/material.dart';
// import 'package:developer_company/utils/cdi_components.dart';
import 'package:developer_company/widgets/autocomplete_dropdown.dart';

class DepartmentsMunicipalitiesDropdownWidget extends StatefulWidget {
  final List<DropDownOption> departments;
  final String selectedDepartment;
  final Function(String) onDepartmentSelected;
  final Function(String) onMunicipalitySelected;

  const DepartmentsMunicipalitiesDropdownWidget({
    required this.departments,
    required this.selectedDepartment,
    required this.onDepartmentSelected,
    required this.onMunicipalitySelected,
  });

  @override
  _DepartmentsMunicipalitiesDropdownWidgetState createState() =>
      _DepartmentsMunicipalitiesDropdownWidgetState();
}

class _DepartmentsMunicipalitiesDropdownWidgetState
    extends State<DepartmentsMunicipalitiesDropdownWidget> {
  String selectedSubDepartment = "";
  late List<DropDownOption> subDepartments;

  CDIRepository cdiRepository = CDIRepositoryImpl(CDIProvider());

  @override
  void initState() {
    super.initState();
    // Initialize subDepartments based on the initially selected department
    updateSubDepartments(widget.selectedDepartment);
  }

  void updateSubDepartments(String selectedDepartment) {
    cdiRepository.fetchDataList("endpoint");
    // Logic to fetch sub-departments based on the selected department
    // For example, you can make an API call or use a predefined map
    // Here, a simple example with a map is used
    subDepartments = subDepartmentsMap[selectedDepartment] ?? [];
    // Ensure that the selectedSubDepartment is a valid option
    if (!subDepartments.contains(selectedSubDepartment)) {
      selectedSubDepartment =
          subDepartments.isNotEmpty ? subDepartments.first.id : "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // First Dropdown for Departments
        AutocompleteDropdownWidget(
          listItems: widget.departments,
          onSelected: (selected) {
            widget.onDepartmentSelected(selected.id);
            updateSubDepartments(selected.id);
            setState(() {
              // Reset the selected sub-department when the department changes
              selectedSubDepartment = "";
            });
          },
          label: "Departments",
          hintText: "Select Department",
          onFocusChange: ((p0) {}),
          onTextChange: (p0) async {
            return widget.departments
                .where((element) =>
                    element.label.toLowerCase().contains(p0.toLowerCase()))
                .toList();
          },
        ),
        // Second Dropdown for Sub-Departments
        AutocompleteDropdownWidget(
          listItems: subDepartments,
          onSelected: (selected) {
            setState(() {
              selectedSubDepartment = selected.id;
            });
            widget.onMunicipalitySelected(selected.id);
          },
          label: "Sub-Departments",
          hintText: "Select Sub-Department",
          onFocusChange: ((p0) {}),
          onTextChange: (p0) async {
            return subDepartments
                .where((element) =>
                    element.label.toLowerCase().contains(p0.toLowerCase()))
                .toList();
          },
        ),
      ],
    );
  }
}

Map<String, List<DropDownOption>> subDepartmentsMap = {
  "IT": [
    DropDownOption(id: "it1", label: "IT Sub-Department 1"),
    DropDownOption(id: "it2", label: "IT Sub-Department 2"),
  ],
  "HR": [
    DropDownOption(id: "hr1", label: "HR Sub-Department 1"),
    DropDownOption(id: "hr2", label: "HR Sub-Department 2"),
  ],
};