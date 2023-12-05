import 'package:developer_company/shared/utils/permission_level.dart';

class AuthorizationService {
  final String userRole;

  AuthorizationService(this.userRole);

  bool hasRole(String requiredRole) {
    return userRole == requiredRole;
  }

  bool canPerformAction(String action) {
    final allowedActionsByRole = {
      'Admin': ['all'],
      'Ejecutivo': [
        PermissionLevel.dashboardQueryQuoteButton,
        PermissionLevel.dashboardAddQuoteButton,
        PermissionLevel.adviserCreditsApprovedAndReserved,
        PermissionLevel.discountsByQuote,
      ],
      'Analista': [
        PermissionLevel.analystCreditByClient,
        PermissionLevel.discountsByQuote,
      ],
      "AdminPruebas": [
        PermissionLevel.marketingMaintenance,
        PermissionLevel.dashboardQueryQuoteButton,
        PermissionLevel.dashboardAddQuoteButton,
        PermissionLevel.adviserCreditsApprovedAndReserved,
        PermissionLevel.analystCreditByClient,
        PermissionLevel.sideBarContacts,
        PermissionLevel.sideBarMarketing,
        PermissionLevel.marketingInitial,
        // DISCOUNTS
        PermissionLevel.discountsByQuote,
        PermissionLevel.discountsByQuoteMaintenance,
      ],
      "Mercadeo": [
        PermissionLevel.marketingInitial,
        PermissionLevel.marketingMaintenance,
        PermissionLevel.sideBarMarketing,
      ]
    };

    // TODO: remove Ejecutivo.
    if (userRole == "Ejecutivo") return true;
    if (userRole == "Admin") return true;

    final allowedActions = allowedActionsByRole[userRole];
    return allowedActions != null && allowedActions.contains(action);
  }
}
