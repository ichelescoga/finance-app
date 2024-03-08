import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:developer_company/data/implementations/loan_simulation_repository_impl.dart';
import 'package:developer_company/data/implementations/project__repository_impl.dart';
import 'package:developer_company/data/models/loan_simulation_model.dart';
import 'package:developer_company/data/models/unit_quotation_model.dart';
import 'package:developer_company/data/providers/loan_simulation_provider.dart';
import 'package:developer_company/data/providers/project_provider.dart';
import 'package:developer_company/data/repositories/loan_simulation_repository.dart';
import 'package:developer_company/data/repositories/project_repository.dart';
import 'package:developer_company/shared/controllers/base_controller.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:developer_company/shared/services/pdf_download_share.dart';
import 'package:developer_company/shared/utils/http_adapter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ExpressQuoteDetailController extends BaseController {
  ExpressQuoteDetailController(int projectId, Map<String, dynamic> arguments)
      : _projectId = projectId,
        _arguments = arguments;
  final TextEditingController unitController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quoteController = TextEditingController();
  final TextEditingController startMoney = TextEditingController();
  final TextEditingController finalSellPrice = TextEditingController();

  final int _projectId;
  final Map<String, dynamic> _arguments;

  final HttpAdapter httpAdapter = HttpAdapter();
  LoanSimulationRepository loanSimulationRepository =
      LoanSimulationRepositoryImpl(LoanSimulationProvider());
  final ProjectRepository projectRepository =
      ProjectRepositoryImpl(ProjectProvider());

  Quotation? quoteInfo;

  Future<String> getQuoteUrl() async {
    final response =
        await httpAdapter.postApi("orders/v1/cotizacionPdf/", {}, {});

    if (response.statusCode != 200) {
      EasyLoading.showError("Cotización no pudo ser generada.");
      return "";
    }

    final responseBody = json.decode(response.body);
    final url = responseBody['body'];
    return url; //url pdf
  }

  Future<void> getSimulation(double anualPayments, double creditValue) async {
    LoanSimulationRequest loanSimulationRequest = LoanSimulationRequest(
        annualInterest: 16, //load intereset from service
        annualPayments: anualPayments,
        totalCreditValue: creditValue,
        cashPrice: false);

    List<LoanSimulationResponse?> simulation =
        await loanSimulationRepository.simulateLoan(loanSimulationRequest);

    if (simulation.contains(null)) {
      simulation = [];
    }

    final quoteStatus = quoteInfo?.estadoId ?? 2;

    //show quotation in next page;
    await Get.toNamed(RouterPaths.CLIENT_CREDIT_SCHEDULE_PAYMENTS_PAGE,
        arguments: {
          'quoteId': _projectId,
          'simulationSchedule': simulation,
          "quoteState": quoteStatus,
          "unitStatus": _arguments["unitStatus"]
        });
  }

  Future<void> openShareFile() async {
    var quoteUrl = await getQuoteUrl();
    if (quoteUrl == "") {
      return;
    }
    await shareFile(quoteUrl, "cotizacion-${_projectId}.pdf");
  }
}
