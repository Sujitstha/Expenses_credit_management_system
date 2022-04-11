import 'package:expensive_app/model/about_mode.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class AboutController extends GetxController {
  var about = AboutModel(id: 0, title: "", description: "").obs;
  var isLoading = true.obs;

  Future getAbout() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchAbout();
      if (data != null) {
        about.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getAbout();
  }
}
