import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remote_kitchen_assessment_app/app/common/components/custom_scaffold.dart';
import 'package:remote_kitchen_assessment_app/app/modules/user/views/components/icon_text.dart';

import '../controllers/user_controller.dart';

class UserView extends GetView<UserController> {
  const UserView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Data From LocalDB',
      body: Obx(
        () {
          if (controller.isLoading.isTrue) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (controller.isFailed.isTrue) {
            return const Center(
              child: Text(
                  'Failed to fetch data. Please try again after some time.'),
            );
          }
          return ListView.builder(
              itemCount: controller.users.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final user = controller.users[index];
                final tilePrimaryColor = (index % 2 == 0)
                    ? Colors.blueGrey.shade900
                    : Colors.blueGrey.shade100;
                final tileSecondaryColor = (index % 2 == 1)
                    ? Colors.blueGrey.shade900
                    : Colors.blueGrey.shade100;

                return Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                  elevation: 8.0,
                  child: ListTile(
                    tileColor: tilePrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name.toString(),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: tileSecondaryColor,
                                  ),
                        ),
                        Text(
                          '@${user.username.toString()}',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: tileSecondaryColor,
                                  ),
                        ),
                        Divider(
                          thickness: 1,
                          color: tileSecondaryColor,
                        ),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        IconText(
                          icon: Icons.email,
                          color: tileSecondaryColor,
                          text: user.email,
                        ),
                        const SizedBox(height: 6),
                        IconText(
                          icon: Icons.phone,
                          color: tileSecondaryColor,
                          text: user.phone,
                        ),
                        const SizedBox(height: 6),
                        IconText(
                          icon: Icons.location_on,
                          color: tileSecondaryColor,
                          text: controller.makeAddress(index),
                        ),
                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
