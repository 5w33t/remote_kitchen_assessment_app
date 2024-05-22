import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remote_kitchen_assessment_app/app/common/components/custom_scaffold.dart';

import '../controllers/post_controller.dart';

class PostView extends GetView<PostController> {
  const PostView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Public API Data Fetch',
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
              itemCount: controller.posts.length,
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final tilePrimaryColor = (index % 2 == 0)
                    ? Colors.blueGrey.shade900
                    : Colors.blueGrey.shade100;
                final tileSecondaryColor = (index % 2 == 1)
                    ? Colors.blueGrey.shade700
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
                          controller.posts[index].title.toString(),
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: tileSecondaryColor,
                                  ),
                        ),
                        Divider(
                          thickness: 1,
                          color: tileSecondaryColor,
                        ),
                      ],
                    ),
                    subtitle: Text(
                      controller.posts[index].body.toString(),
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            color: tileSecondaryColor,
                          ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
