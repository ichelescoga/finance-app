import 'package:developer_company/data/models/user_model.dart';
import 'package:developer_company/global_state/notifiers/user_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ? USER 
var currentUser = UserNotifier();
final userProvider =
    StateNotifierProvider<UserNotifier, User>((ref) => currentUser);

final userProviderWithoutNotifier = Provider((_) => currentUser);


// ? USER CLIENT
var currentUserClient = UserClientNotifier();

final userClientProvider =
    StateNotifierProvider<UserClientNotifier, UserClient>((ref) => currentUserClient);

final userClientProviderWithoutNotifier = Provider((_) => currentUserClient);
