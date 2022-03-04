import 'package:expensive_app/model/expense_model.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  var expenses = ExpensesModel(data: []).obs;
  var isLoading = true.obs;

  Future getExpensesList() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchExpenses();
      if (data != null) {
        expenses.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
