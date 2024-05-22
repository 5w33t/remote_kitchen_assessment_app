import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remote_kitchen_assessment_app/app/common/components/custom_scaffold.dart';

import '../controllers/message_controller.dart';

class MessageView extends GetView<MessageController> {
  const MessageView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'New Screen',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Congrats!\nYou have navigated to a new screen!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
      ),
    );
  }
}
