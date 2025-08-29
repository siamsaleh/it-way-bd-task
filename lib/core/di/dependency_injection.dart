import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:it_way_bd_task/data/repositories/main_repository.dart';

import '../../controller/main_controller.dart';
import '../network/api_service.dart';
import '../network/dio_client.dart';

class DependencyInjection {
  static void init() {
    final dio = DioClient.create();
    Get.put<Dio>(dio);

    // Service
    Get.put<ApiService>(ApiService(Get.find<Dio>()), permanent: true);

    // Repositories
    Get.put<MainRepository>(
      MainRepository(apiService: Get.find<ApiService>()),
      permanent: true,
    );

    // Controller
    Get.put<MainController>(
      MainController(postRepository: Get.find<MainRepository>()),
      permanent: true,
    );
  }
}
