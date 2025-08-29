import 'package:get/get.dart';

import '../data/models/Post_model.dart';
import '../data/repositories/main_repository.dart';

class MainController extends GetxController {
  final MainRepository postRepository;

  MainController({required this.postRepository});

  var posts = <PostModel>[].obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<void> fetchPosts() async {
    isLoading(true);
    errorMessage('');
    try {
      final result = await postRepository.getPosts();
      if (result.isSuccess) {
        posts.assignAll(result.data!);
      } else {
        errorMessage(result.error ?? "Unknown error");
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addPost({required String title, required String body, required int userId}) async {
    isLoading(true);
    errorMessage('');
    try {
      final result = await postRepository.createPost(title: title, body: body, userId: userId);
      if (result.isSuccess) {
        posts.insert(0, result.data!); // add new post at top
      } else {
        errorMessage(result.error ?? "Failed to create post");
      }
    } finally {
      isLoading(false);
    }
  }
}
