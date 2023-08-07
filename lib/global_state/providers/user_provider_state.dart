import 'package:developer_company/data/models/user_model.dart';
import 'package:developer_company/global_state/notifiers/user_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

var currentUser = UserNotifier(null);
final userProvider =
    StateNotifierProvider<UserNotifier, User?>((ref) => currentUser);
