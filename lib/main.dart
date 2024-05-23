import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remote_kitchen_assessment_app/app/modules/user/models/address_model.dart';
import 'package:remote_kitchen_assessment_app/app/modules/user/models/user_model.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AddressAdapter());
  Hive.registerAdapter(UserAdapter());

  runApp(
    GetMaterialApp(
      title: "Remote Kitchen Assessment",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
