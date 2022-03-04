import 'package:expensive_app/model/transaction_model.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  var transactions = TransactionModel(data: []).obs;
  var isLoading = true.obs;

  Future getTransaction() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchTransaction();
      if (data != null) {
        transactions.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
