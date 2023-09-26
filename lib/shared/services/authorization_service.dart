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
        PermissionLevel.marketingMaintenance //! TEMP another role should be assigned
      ],
      'Analista': [PermissionLevel.analystCreditByClient]
    };

    if(userRole == "Admin") return true;
    
    final allowedActions = allowedActionsByRole[userRole];
    return allowedActions != null && allowedActions.contains(action);
  }
}
