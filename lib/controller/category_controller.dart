import 'package:expensive_app/model/category_mode.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  var categories = CategoryModel(data: []).obs;
  var isLoading = true.obs;

  Future getCategories() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchCategory();
      if (data != null) {
        categories.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
