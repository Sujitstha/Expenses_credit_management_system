import 'package:expensive_app/model/condition_model.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class ConditionController extends GetxController {
  var condition = ConditionModel(id: 0, title: "", description: "").obs;
  var isLoading = true.obs;

  Future getCondition() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchTermsAndCondition();
      if (data != null) {
        condition.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    getCondition();
  }
}
