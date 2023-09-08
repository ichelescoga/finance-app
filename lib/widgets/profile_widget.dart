import 'package:developer_company/data/models/user_model.dart';
import 'package:developer_company/global_state/providers/user_provider_state.dart';
import 'package:developer_company/shared/resources/colors.dart';
import 'package:developer_company/shared/resources/strings.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileWidget extends ConsumerWidget {
  final Function onPressedProfile;
  // final Function onPressed;

  const ProfileWidget({Key? key, required this.onPressedProfile})
      : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User? user = ref.watch(userProvider);
    print("🚀🚀🥊  ${user?.company.companyName}");
    print("🚀🚀🥊  ${user?.project.projectName}");

    return DrawerHeader(
      decoration: const BoxDecoration(
        color: AppColors.mainColor,
      ),
      child: InkWell(
        onTap: () {
          onPressedProfile();
          // actionToAccount(x, member);
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 5 * 3,
          ),
          child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(60.0),
                child: Image.asset(
                  'assets/icondef.png',
                ),
              ),
              title: Text(
                user == null ? "Usuario" : user.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    height: 1.1),
              ),
              subtitle: Column(
                children: [
                  Text(
                    Strings.appName,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    user == null ? "Usuario" : user.company.companyName,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
