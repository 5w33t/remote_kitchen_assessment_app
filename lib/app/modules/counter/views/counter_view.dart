import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remote_kitchen_assessment_app/app/common/components/custom_scaffold.dart';

import '../controllers/counter_controller.dart';

class CounterView extends GetView<CounterController> {
  const CounterView({super.key});
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Counter App',
      body: Obx(
        () => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${controller.count}',
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: Colors.blueGrey.shade800),
              ),
              const SizedBox(height: 16),
              OutlinedButton.icon(
                onPressed: controller.increment,
                label: const Text(
                  'Increment',
                ),
                icon: const Icon(Icons.add),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blueGrey.shade600,
                  foregroundColor: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
