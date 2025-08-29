import '../../core/network/api_result.dart';
import '../../core/network/api_service.dart';
import '../models/Post_model.dart';
import '../models/api_error.dart';

class MainRepository {
  final ApiService apiService;

  MainRepository({required this.apiService});

  Future<ApiResult<List<PostModel>>> getPosts() async {
    try {
      final response = await apiService.get("posts");

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is List) {
          final posts = data.map((e) => PostModel.fromJson(e)).toList();
          return ApiResult.success(posts);
        }
        return ApiResult.failure("Unexpected response format");
      } else {
        final error = ApiError.fromJson(response.data);
        return ApiResult.failure(error.message ?? "Unknown error");
      }
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }

  Future<ApiResult<PostModel>> createPost({required String title, required String body, required int userId}) async {
    try {
      final response = await apiService.post("/posts", data: {
        "title": title,
        "body": body,
        "userId": userId,
      });

      if (response.statusCode == 201 || response.statusCode == 200) {
        final post = PostModel.fromJson(response.data);
        return ApiResult.success(post);
      } else {
        final error = ApiError.fromJson(response.data);
        return ApiResult.failure(error.message ?? "Unknown error");
      }
    } catch (e) {
      return ApiResult.failure(e.toString());
    }
  }
}
