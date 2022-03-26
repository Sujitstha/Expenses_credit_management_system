import 'package:expensive_app/model/category_mode.dart';
import 'package:expensive_app/model/income_model.dart';
import 'package:expensive_app/model/total_income_model.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class IncomeController extends GetxController {
  var incomes = IncomeModel(data: []).obs;
  var totalIncome = TotalIncomeModel(totalIncome: 0).obs;
  var isLoading = true.obs;

  Future getIncomeList() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchIncome();
      if (data != null) {
        incomes.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }

  Future getTotalIncome() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchTotalIncome();
      if (data != null) {
        totalIncome.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
