import 'package:get/get.dart';

import '../models/post_model.dart';

class PostProvider extends GetConnect {
  Future<List<Post>> fetchPosts() async {
    final response = await get('https://jsonplaceholder.typicode.com/posts');
    if (response.status.code == 200) {
      return List<Post>.from(response.body.map((item) => Post.fromJson(item)));
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
