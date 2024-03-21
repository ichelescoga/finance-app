import 'package:developer_company/shared/routes/router_client_paths.dart';
import 'package:developer_company/views-client/home/dashboard_client_page.dart';
import 'package:developer_company/views-client/payments/pages/payments_page.dart';
import 'package:developer_company/views-client/units/pages/units_page.dart';
import 'package:get/get.dart';

class GetUserClientRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(
          name: RouterClientPaths.DASHBOARD,
          page: () => const DashboardClientPage()),
      GetPage(name: RouterClientPaths.UNITS, page: () => const UnitsPage()),
      GetPage(
          name: RouterClientPaths.PAYMENTS, page: () => const PaymentsPage()),
    ];
  }
}
