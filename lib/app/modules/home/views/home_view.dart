import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:remote_kitchen_assessment_app/app/common/components/custom_scaffold.dart';
import 'package:remote_kitchen_assessment_app/app/modules/home/views/components/custom_button.dart';
import 'package:remote_kitchen_assessment_app/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      title: 'Remote Kitchen Assessment',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              page: Routes.MESSAGE,
              buttonText: 'Navigate to A New Screen',
            ),
            SizedBox(height: 15),
            CustomButton(
              page: Routes.COUNTER,
              buttonText: 'Navigate to Counter App',
            ),
            SizedBox(height: 15),
            CustomButton(
              page: Routes.POST,
              buttonText: 'Navigate to RestAPI Data Fetching',
            ),
          ],
        ),
      ),
    );
  }
}
