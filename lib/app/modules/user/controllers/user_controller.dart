import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:remote_kitchen_assessment_app/app/modules/user/providers/user_provider.dart';
import 'package:remote_kitchen_assessment_app/app/modules/user/models/user_model.dart';

class UserController extends GetxController {
  final isLoading = RxBool(false);
  final UserProvider _userProvider = UserProvider();
  //var _userBox = Hive.box<User>('users');

  final users = RxList<User>([]);
  final isFailed = RxBool(false);
  var _userBox;
  @override
  void onInit() async {
    initialize();
    fetchUsers();
    super.onInit();
  }

  Future<void> initialize() async {
    try {
      _userBox = await Hive.openBox<User>('users'); // Open box here
    } catch (error) {
      // Handle error opening the box (optional)
      print('Error opening Hive box: $error');
    }
  }

  Future<void> saveUsers(List<User> users) async {
    await _userBox.clear(); // Clear previous data (optional)
    _userBox.addAll(users);
    print('User Saved : $_userBox');
  }

  List<User> getUsers() {
    return _userBox.values.toList();
  }

  bool hasCachedData() {
    return _userBox.isNotEmpty;
  }

  String makeAddress(int index) {
    final address = users[index].address;
    String result = "";

    if (address != null) {
      if (address.suite!.isNotEmpty) {
        result += address.suite!;
        result += ', ';
      }
      if (address.street!.isNotEmpty) {
        result += address.street!;
        result += ', ';
      }
      if (address.city!.isNotEmpty) {
        result += address.city!;
        result += ' - ';
      }
      if (address.zipcode!.isNotEmpty) {
        result += address.zipcode!;
      }
    }
    return result;
  }

  Future<void> fetchUsers() async {
    isLoading.value = true;
    try {
      final fetchedUsers = await _userProvider.fetchUsers();
      await saveUsers(fetchedUsers);
      users.value = fetchedUsers;
    } catch (error) {
      if (hasCachedData()) {
        users.value = getUsers();
        Get.snackbar(
            'You\'re Offline.', 'Please check your internet connection',
            backgroundColor: Colors.red.shade900,
            colorText: Colors.blueGrey.shade100,
            snackPosition: SnackPosition.BOTTOM,
            icon: const Icon(
              Icons.wifi_off,
              color: Colors.white,
            ));
      } else {
        isFailed.value = true;
      }
    } finally {
      isLoading.value = false;
    }
  }
}
