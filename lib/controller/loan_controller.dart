import 'package:expensive_app/model/loan_model.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class LoanController extends GetxController {
  var loans = <LoanModel>[].obs;
  var isLoading = true.obs;

  Future getLoans() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchLoan();
      if (data != null) {
        loans.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
