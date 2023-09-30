import 'package:developer_company/data/models/client_contact_model.dart';
import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:flutter/material.dart';

class QuickClientContactDialogController extends BaseController {
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();

  bool isActive = true;
  int? contactId;

  updateContact(QuickClientContacts contact) {
    contactId = contact.contactId;
    fullName.text = contact.fullName;
    phone.text = contact.phone;
    email.text = contact.email;
    address.text = contact.address;
  }

  clearController() {
    contactId = null;
    fullName.clear();
    phone.clear();
    email.clear();
    address.clear();
  }
}
