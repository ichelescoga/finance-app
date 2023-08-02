import 'package:developer_company/advisers/pages/create_adviser_page.dart';
import 'package:developer_company/bank_executive/pages/bank_client_detail_page.dart';
import 'package:developer_company/bank_executive/pages/bank_executive_client_page.dart';
import 'package:developer_company/bank_executive/pages/bank_executive_page.dart';
import 'package:developer_company/bank_executive/pages/bank_executive_stats_page.dart';
import 'package:developer_company/bank_executive/pages/bank_executive_unit_status_page.dart';
import 'package:developer_company/bank_executive/pages/client_detail_page.dart';
import 'package:developer_company/bank_executive/pages/client_quote_page.dart';
import 'package:developer_company/client/pages/client_bank_offers_page.dart';
import 'package:developer_company/client/pages/client_credit_advance_page.dart';
import 'package:developer_company/client/pages/client_credit_detail_page.dart';
import 'package:developer_company/client/pages/client_dashboard_page.dart';
import 'package:developer_company/client/pages/client_documents_page.dart';
import 'package:developer_company/client/pages/client_offer_detail_page.dart';
import 'package:developer_company/credit_request/pages/credit_application_page.dart';
import 'package:developer_company/credit_request/pages/credit_user_application_page.dart';
import 'package:developer_company/credit_request/pages/unit_payment_schedule_page.dart';
import 'package:developer_company/credit_request/pages/unit_quote_detail_page.dart';
import 'package:developer_company/credit_request/pages/unit_quote_page.dart';
import 'package:developer_company/developer_company/pages/create_company_page.dart';
import 'package:developer_company/financial_entity/pages/financial_entity_creation_page.dart';
import 'package:developer_company/home/pages/dashboard_page.dart';
import 'package:developer_company/home/pages/home_page.dart';
import 'package:developer_company/home/pages/login_page.dart';
import 'package:developer_company/home/pages/register_page.dart';
import 'package:developer_company/quotes/pages/quote_consult_page.dart';
import 'package:developer_company/quotes/pages/quote_stats_page.dart';
import 'package:developer_company/quotes/pages/quote_unit_status_page.dart';
import 'package:developer_company/quotes/pages/unit_detail_page.dart';
import 'package:developer_company/shared/routhes/router_paths.dart';
import 'package:get/get.dart';

class GetRoutes{
  static List<GetPage> routes(){
    return[
      GetPage(name: RouterPaths.HOME_PAGE, page: () => const HomePage()),
      GetPage(name: RouterPaths.LOGIN_PAGE, page: () => const LoginPage()),
      GetPage(name: RouterPaths.REGISTER_PAGE, page: () => const RegisterPage()),
      GetPage(name: RouterPaths.DASHBOARD_PAGE, page: () => const DashboardPage()),
      GetPage(name: RouterPaths.CREATE_COMPANY_PAGE, page: () => const CreateCompanyPage()),
      GetPage(name: RouterPaths.CREATE_ADVISER_PAGE, page: () => const CreateAdviserPage()),
      GetPage(name: RouterPaths.QUOTE_CONSULT_PAGE, page: () => const QuoteConsultPage()),
      GetPage(name: RouterPaths.QUOTE_STATS_PAGE, page: () => const QuoteStatsPage()),
      GetPage(name: RouterPaths.QUOTE_UNIT_STATUS_PAGE, page: () => const QuoteUnitStatusPage()),
      GetPage(name: RouterPaths.UNIT_DETAIL_PAGE, page: () => const UnitDetailPage()),
      GetPage(name: RouterPaths.UNIT_QUOTE_PAGE, page: () => const UnitQuotePage()),
      GetPage(name: RouterPaths.UNIT_QUOTE_DETAIL_PAGE, page: () => const UnitQuoteDetailPage()),
      GetPage(name: RouterPaths.UNIT_PAYMENT_SCHEDULE_PAGE, page: () => const UnitPaymentSchedulePage()),
      GetPage(name: RouterPaths.CREDIT_APPLICATION_PAGE, page: () => const CreditApplicationPage()),
      GetPage(name: RouterPaths.CREDIT_USER_APPLICATION_PAGE, page: () => const CreditUserApplicationPage()),
      GetPage(name: RouterPaths.FINANCIAL_ENTITY_CREATION_PAGE, page: () => const FinancialEntityCreationPage()),
      GetPage(name: RouterPaths.BANK_EXECUTIVE_PAGE, page: () => const BankExecutivePage()),
      GetPage(name: RouterPaths.BANK_EXECUTIVE_CLIENT_PAGE, page: () => const BankExecutiveClientPage()),
      GetPage(name: RouterPaths.BANK_CLIENT_DETAIL_PAGE, page: () => const BankClientDetailPage()),
      GetPage(name: RouterPaths.BANK_EXECUTIVE_STATS_PAGE, page: () => const BankExecutiveStatsPage()),
      GetPage(name: RouterPaths.BANK_EXECUTIVE_UNIT_STATUS_PAGE, page: () => const BankExecutiveUnitStatusPage()),
      GetPage(name: RouterPaths.CLIENT_DETAIL_PAGE, page: () => const ClientDetailPage()),
      GetPage(name: RouterPaths.CLIENT_QUOTE_PAGE, page: () => const ClientQuotePage()),
      GetPage(name: RouterPaths.CLIENT_DASHBOARD_PAGE, page: () => const ClientDashboardPage()),
      GetPage(name: RouterPaths.CLIENT_BANK_OFFERS_PAGE, page: () => const ClientBankOffersPage()),
      GetPage(name: RouterPaths.CLIENT_OFFER_DETAIL_PAGE, page: () => const ClientOfferDetailPage()),
      GetPage(name: RouterPaths.CLIENT_DOCUMENTS_PAGE, page: () => const ClientDocumentsPage()),
      GetPage(name: RouterPaths.CLIENT_CREDIT_ADVANCE_PAGE, page: () => const ClientCreditAdvancePage()),
      GetPage(name: RouterPaths.CLIENT_CREDIT_DETAIL_PAGE, page: () => const ClientCreditDetailPage()),
    ];
  }
}