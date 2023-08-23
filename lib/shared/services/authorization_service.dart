import 'package:developer_company/shared/utils/permission_level.dart';

class AuthorizationService {
  final String userRole;

  AuthorizationService(this.userRole);

  bool hasRole(String requiredRole) {
    return userRole == requiredRole;
  }

  bool canPerformAction(String action) {
    final allowedActionsByRole = {
      'admin': ['all'],
      // 'ejecutivo': [
      //   PermissionLevel.dashboardQueryQuoteButton,
      //   PermissionLevel.dashboardAddQuoteButton,
      // ],
      'ejecutivo': [PermissionLevel.analystCreditByClient, PermissionLevel.dashboardQueryQuoteButton],// Temp until the post of login returns the role;
      'analista': [PermissionLevel.analystCreditByClient]
    };

    final allowedActions = allowedActionsByRole[userRole];
    return allowedActions != null && allowedActions.contains(action);
  }
}
