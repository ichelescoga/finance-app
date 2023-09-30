import "package:developer_company/controllers/quick_client_contact_dialog_controller.dart";
import "package:developer_company/data/implementations/client_contact_impl.dart";
import "package:developer_company/data/models/client_contact_model.dart";
import "package:developer_company/data/providers/client_contact_provider.dart";
import "package:developer_company/data/repositories/client_contact_repository.dart";
import "package:developer_company/global_state/providers/user_provider_state.dart";
import "package:developer_company/main.dart";
import "package:developer_company/shared/resources/colors.dart";
import "package:developer_company/shared/resources/dimensions.dart";
import "package:developer_company/widgets/add_new_quick_contact.dart";
import "package:developer_company/widgets/app_bar_sidebar.dart";
import "package:developer_company/widgets/data_table.dart";
import "package:developer_company/widgets/layout.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:url_launcher/url_launcher.dart";

class QuickClientContactListPage extends StatefulWidget {
  const QuickClientContactListPage({Key? key}) : super(key: key);

  @override
  _QuickClientContactListPageState createState() =>
      _QuickClientContactListPageState();
}

class _QuickClientContactListPageState
    extends State<QuickClientContactListPage> {
  final QuickClientContactDialogController _quickClientContactDialogController =
      QuickClientContactDialogController();

  final QuickClientContactRepository quickClientContactProvider =
      QuickClientContactRepositoryImpl(QuickClientContactProvider());

  final user = container.read(userProvider);

  List<QuickClientContacts> clientContacts = [];
  final AppColors appColors = AppColors();

  _fetchClientContacts() async {
    EasyLoading.show();
    final projectId = user?.project.projectId;
    clientContacts.clear();
    final contacts =
        await quickClientContactProvider.fetchClientContact(projectId!);
    setState(() => clientContacts.addAll(contacts));
    EasyLoading.dismiss();
  }

  @override
  void initState() {
    _fetchClientContacts();
    super.initState();
  }

  Future<void> openDialer(String phoneNumber) async {
    Uri callUrl = Uri.parse('tel:=$phoneNumber');
    if (await canLaunchUrl(callUrl)) {
      await launchUrl(callUrl);
    } else {
      throw 'Could not open the dialler.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
        sideBarList: const [],
        appBar: CustomAppBarSideBar(
          title: "Lista de Contactos",
          rightActions: [
            IconButton(
                icon: Icon(
                  Icons.add_circle_sharp,
                  color: AppColors.softMainColor,
                  size: Dimensions.topIconSizeH,
                ),
                onPressed: () => _dialogNewEditQuickContact(context, false))
          ],
        ),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: CustomDataTable(
                columns: ["Nombre", "Teléfono", "correo", "dirección", ""],
                elements: clientContacts
                    .asMap()
                    .map((index, element) => MapEntry(
                        index,
                        DataRow(
                          onSelectChanged: (value) {},
                          cells: [
                            DataCell(Text(element.fullName)),
                            DataCell(Text(element.phone)),
                            DataCell(Text(element.email)),
                            DataCell(Text(element.address)),
                            DataCell(Row(
                              children: [
                                if (element.phone.length > 4)
                                  IconButton(
                                      onPressed: () {
                                        openDialer(element.phone);
                                      },
                                      icon: Icon(Icons.phone)),
                                SizedBox(width: 14),
                                IconButton(
                                    onPressed: () {
                                      final projectId = user?.project.projectId;

                                      final QuickClientContacts contactInfo =
                                          QuickClientContacts(
                                              contactId: element.contactId,
                                              projectId: int.parse(projectId!),
                                              state: true,
                                              fullName: element.fullName,
                                              phone: element.phone,
                                              email: element.email,
                                              address: element.address);
                                      ;
                                      _quickClientContactDialogController
                                          .updateContact(contactInfo);
                                      _dialogNewEditQuickContact(context, true);
                                    },
                                    icon: Icon(Icons.edit_square))
                              ],
                            )),
                          ],
                          color: appColors.dataRowColors(index),
                        )))
                    .values
                    .toList(),
              ),
            ),
          ],
        ));
  }

  _dialogNewEditQuickContact(BuildContext context, bool isEditing) {
    return showDialog(
        context: context,
        builder: (context) {
          return WillPopScope(
              onWillPop: () async {
                return false;
              },
              child: AddNewQuickContact(
                isEditing: isEditing,
                quickClientContactController:
                    _quickClientContactDialogController,
              ));
        }).then((result) {
      if (result == true) {
        _fetchClientContacts();
        return;
      }
    });
  }
}
