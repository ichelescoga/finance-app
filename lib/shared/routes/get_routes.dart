import 'package:developer_company/views/CDI/cdi_list_page.dart';
import 'package:developer_company/views/CDI/cdi_manage_page.dart';
import 'package:developer_company/views/advisers/pages/create_adviser_page.dart';
import 'package:developer_company/views/analysts/pages/analyst_detail_credit_client.dart';
import 'package:developer_company/views/analysts/pages/analyst_list_credits.dart';
import 'package:developer_company/views/bank_executive/pages/bank_client_detail_page.dart';
import 'package:developer_company/views/bank_executive/pages/bank_executive_client_page.dart';
import 'package:developer_company/views/bank_executive/pages/bank_executive_page.dart';
import 'package:developer_company/views/bank_executive/pages/bank_executive_stats_page.dart';
import 'package:developer_company/views/bank_executive/pages/bank_executive_unit_status_page.dart';
import 'package:developer_company/views/bank_executive/pages/client_detail_page.dart';
import 'package:developer_company/views/bank_executive/pages/client_quote_page.dart';
import 'package:developer_company/views/client/client_contact/quick_client_contact_list_page.dart';
import 'package:developer_company/views/client/pages/client_bank_offers_page.dart';
import 'package:developer_company/views/client/pages/client_credit_advance_page.dart';
import 'package:developer_company/views/client/pages/client_credit_detail_page.dart';
import 'package:developer_company/views/client/pages/client_dashboard_page.dart';
import 'package:developer_company/views/client/pages/client_documents_page.dart';
import 'package:developer_company/views/client/pages/client_offer_detail_page.dart';
import 'package:developer_company/views/credit_request/pages/credit_application_page.dart';
import 'package:developer_company/views/credit_request/pages/credit_detail_page.dart';
import 'package:developer_company/views/credit_request/pages/credit_resolution_detail_page.dart';
import 'package:developer_company/views/credit_request/pages/credit_schedule_payments_page.dart';
import 'package:developer_company/views/credit_request/pages/credit_user_application_page.dart';
import 'package:developer_company/views/credit_request/pages/credits_reserved_approved.dart';
import 'package:developer_company/views/credit_request/pages/unit_quote_detail_page.dart';
import 'package:developer_company/views/credit_request/pages/unit_quote_page.dart';
import 'package:developer_company/views/developer_company/pages/list_companies_page.dart';
import 'package:developer_company/views/developer_company/pages/manage_company_page.dart';
import 'package:developer_company/views/developer_company_projects/pages/create_assign_project_to_company_page.dart';
import 'package:developer_company/views/developer_company_projects/pages/list_companies_to_project_page.dart';
import 'package:developer_company/views/developer_company_projects/pages/list_projects_by_company_page.dart';
import 'package:developer_company/views/discounts/pages/discount_detail_by_quote_maintenance_page.dart';
import 'package:developer_company/views/discounts/pages/discount_detail_by_quote_page.dart';
import 'package:developer_company/views/discounts/pages/discounts_by_quote_maintenance_page.dart';
import 'package:developer_company/views/discounts/pages/discounts_by_quote_page.dart';
import 'package:developer_company/views/financial_entity/pages/financial_entity_creation_page.dart';
import 'package:developer_company/views/home/pages/dashboard_page.dart';
import 'package:developer_company/views/home/pages/home_page.dart';
import 'package:developer_company/views/home/pages/login_page.dart';
import 'package:developer_company/views/home/pages/register_page.dart';
import 'package:developer_company/views/marketing/pages/marketing_album_detail_maintenance_page.dart';
import 'package:developer_company/views/marketing/pages/marketing_album_detail_page.dart';
import 'package:developer_company/views/marketing/pages/marketing_albums_maintenance_page.dart';
import 'package:developer_company/views/marketing/pages/marketing_carrousel_albums_page.dart';
import 'package:developer_company/views/quotes/pages/quote_consult_page.dart';
import 'package:developer_company/views/quotes/pages/quote_stats_page.dart';
import 'package:developer_company/views/quotes/pages/quote_unit_status_page.dart';
import 'package:developer_company/views/quotes/pages/unit_detail_page.dart';
import 'package:developer_company/shared/routes/router_paths.dart';
import 'package:get/get.dart';

class GetRoutes{
  static List<GetPage> routes(){
    return[
      GetPage(name: RouterPaths.HOME_PAGE, page: () => const HomePage()),
      GetPage(name: RouterPaths.LOGIN_PAGE, page: () => const LoginPage()),
      GetPage(name: RouterPaths.REGISTER_PAGE, page: () => const RegisterPage()),
      GetPage(name: RouterPaths.DASHBOARD_PAGE, page: () => const DashboardPage()),
      

      GetPage(name: RouterPaths.CREATE_ADVISER_PAGE, page: () => const CreateAdviserPage()),
      GetPage(name: RouterPaths.QUOTE_CONSULT_PAGE, page: () => const QuoteConsultPage()),
      GetPage(name: RouterPaths.QUOTE_STATS_PAGE, page: () => const QuoteStatsPage()),
      GetPage(name: RouterPaths.QUOTE_UNIT_STATUS_PAGE, page: () => const QuoteUnitStatusPage()),
      GetPage(name: RouterPaths.UNIT_DETAIL_PAGE, page: () => const UnitDetailPage()),
      GetPage(name: RouterPaths.UNIT_QUOTE_PAGE, page: () => const UnitQuotePage()),
      GetPage(name: RouterPaths.UNIT_QUOTE_DETAIL_PAGE, page: () => const UnitQuoteDetailPage()),
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
      GetPage(name: RouterPaths.CLIENT_CREDIT_SCHEDULE_PAYMENTS_PAGE, page: () => const CreditSchedulePaymentsPage()),
      GetPage(name: RouterPaths.CLIENT_CREDIT_DETAIL_PAGE, page: () => const ClientCreditDetailPage()),
      GetPage(name: RouterPaths.ANALYST_CREDITS_BY_CLIENT_PAGE, page: () => const AnalystListCredits()),
      GetPage(name: RouterPaths.ANALYST_DETAIL_CREDIT_PAGE, page: () => const AnalystDetailCreditClient()), //equal to CREDIT_RESOLUTION_DETAIL_PAGE change the buttons posible refactor
      GetPage(name: RouterPaths.CREDIT_DETAIL_PAGE, page: () => const CreditDetailPage()),
      GetPage(name: RouterPaths.CREDIT_RESOLUTION_DETAIL_PAGE, page: () => const CreditResolutionDetailPage()),
      GetPage(name: RouterPaths.ADVISER_CREDITS_RESERVED_APPROVED, page: () => const CreditsReservedApproved()),
      

      // MARKETING 🖼️🖼️🎞️🎞️
      GetPage(name: RouterPaths.MARKETING_MAINTENANCE_ALBUMS, page: () => const MarketingAlbumsMaintenancePage()),
      GetPage(name: RouterPaths.MARKETING_MAINTENANCE_DETAIL_ALBUM, page: () => const MarketingAlbumDetailMaintenancePage()),
      GetPage(name: RouterPaths.MARKETING_CARROUSEL_ALBUMS, page: () => const MarketingCarrouselAlbumsPage(), transition: Transition.upToDown),
      GetPage(name: RouterPaths.MARKETING_DETAIL_ALBUM, page: () => const MarketingAlbumDetailPage()),

      // QUICK CONTACTS 🧑‍🦰🧑‍🦰
      GetPage(name: RouterPaths.QUICK_CONTACT_LIST_PAGE, page: () => const QuickClientContactListPage()),

      // DISCOUNTS
      GetPage(name: RouterPaths.DISCOUNT_DETAIL_BY_QUOTE_MAINTENANCE_PAGE, page: () => const DiscountDetailByQuoteMaintenancePage()),
      GetPage(name: RouterPaths.DISCOUNTS_BY_QUOTE_PAGE, page: () => const DiscountsByQuotePage()),
      GetPage(name: RouterPaths.DISCOUNT_DETAIL_BY_QUOTE_PAGE, page: () => const DiscountDetailByQuotePage()),
      GetPage(name: RouterPaths.DISCOUNTS_BY_QUOTE_MAINTENANCE_PAGE, page: () => const DiscountsByQuoteMaintenancePage()),

      // COMPANIES 🏢🏢

      GetPage(name: RouterPaths.MANAGE_COMPANY_PAGE, page: () => const CreateCompanyPage()),
      GetPage(name: RouterPaths.LIST_COMPANIES_PAGE, page: () => const ListCompanies()),

      // PROJECTS 📐📐
      GetPage(name: RouterPaths.LIST_COMPANY_PROJECTS_PAGE, page: () => const listCompaniesToProjectsPage()),
      GetPage(name: RouterPaths.LIST_PROJECTS_BY_COMPANY_PAGE, page: () => const ListProjectsByCompanyState()),
      GetPage(name: RouterPaths.ASSIGN_PROJECT_TO_COMPANY_PAGE, page: () => const createAssignProjectToCompanyPage()),

      //CDI
      GetPage(name: RouterPaths.LIST_CDI_PAGE, page: () => const CDIListPage()),
      GetPage(name: RouterPaths.MANAGE_CDI_PAGE, page: () => const CDIManagePage()),

    ];
  }
}