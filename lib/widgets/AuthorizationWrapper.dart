import 'package:developer_company/data/models/user_model.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/shared/services/authorization_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthorizationWrapper extends ConsumerWidget {
  final String requestAction;
  final Widget child;

  const AuthorizationWrapper(
      {Key? key, required this.requestAction, required this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = ref.watch(userProvider);
    if (user == null) return Container();

    final authorizationService = AuthorizationService(user.role);

    final canPerformAction =
        authorizationService.canPerformAction(requestAction);
    if (!canPerformAction) return Container();

    return child;
  }
}
