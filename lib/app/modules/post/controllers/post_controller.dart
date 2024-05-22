import 'package:get/get.dart';
import 'package:remote_kitchen_assessment_app/app/modules/post/post_model.dart';
import 'package:remote_kitchen_assessment_app/app/modules/post/providers/post_provider.dart';

class PostController extends GetxController {
  final isLoading = RxBool(false);
  final PostProvider _postProvider = PostProvider();
  final posts = RxList<Post>([]);
  final isFailed = RxBool(false);
  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    isLoading.value = true;
    try {
      final fetchedPosts = await _postProvider.fetchPosts();
      posts.value = fetchedPosts;
    } catch (error) {
      isFailed.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
