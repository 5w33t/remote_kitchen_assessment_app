import 'package:get/get.dart';

import '../models/user_model.dart';

class UserProvider extends GetConnect {
  Future<List<User>> fetchUsers() async {
    final response = await get('https://jsonplaceholder.typicode.com/users');
    if (response.status.code == 200) {
      return List<User>.from(response.body.map((item) => User.fromJson(item)));
    } else {
      throw Exception('Failed to load users');
    }
  }
}
