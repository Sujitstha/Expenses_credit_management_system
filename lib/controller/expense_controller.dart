import 'package:expensive_app/model/expense_model.dart';
import 'package:expensive_app/model/total_expanses_model.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class ExpenseController extends GetxController {
  var expenses = ExpensesModel(data: []).obs;
  var totalExpanses = TotalExpensesModel(totalExpenses: 0).obs;
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

  Future getTotalExpanses() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchTotalExpanses();
      if (data != null) {
        totalExpanses.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
