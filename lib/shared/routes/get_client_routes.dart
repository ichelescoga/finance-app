import 'package:developer_company/shared/routes/router_client_paths.dart';
import 'package:developer_company/views/home/pages/dashboard_client_page.dart';
import 'package:get/get.dart';

class GetUserClientRoutes {
  static List<GetPage> routes() {
    return [
      GetPage(
          name: RouterClientPaths.DASHBOARD,
          page: () => const DashboardClientPage()),
    ];
  }
}
