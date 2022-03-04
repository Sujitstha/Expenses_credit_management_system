import 'package:expensive_app/model/sub_category_mode.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class SubCategoryController extends GetxController {
  var subcategories = <SubCategoryModel>[].obs;
  var isLoading = true.obs;

  Future getSubCategoreis(int id) async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchSubCategory(id);
      if (data != null) {
        subcategories.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
