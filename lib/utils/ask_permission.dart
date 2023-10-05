import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/main.dart';
import 'package:developer_company/shared/services/authorization_service.dart';

bool AskPermission(String requestAction) {
  final user = container.read(userProviderWithoutNotifier);

  final authorizationService = AuthorizationService(user.role);

  final canPerformAction = authorizationService.canPerformAction(requestAction);
  if (!canPerformAction) return false;

  return true;
}
