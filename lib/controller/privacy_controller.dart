import 'package:expensive_app/model/condition_model.dart';
import 'package:expensive_app/model/privacy_model.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class PrivacyController extends GetxController {
  var privacy = PrivacyModel(id: 0, title: "", description: "").obs;
  var isLoading = true.obs;

  Future getPrivacy() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchPrivacy();
      if (data != null) {
        privacy.value = data;
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
    getPrivacy();
  }
}
