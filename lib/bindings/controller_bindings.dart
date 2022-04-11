import 'package:expensive_app/controller/about_controller.dart';
import 'package:expensive_app/controller/category_controller.dart';
import 'package:expensive_app/controller/condition_controller.dart';
import 'package:expensive_app/controller/expense_controller.dart';
import 'package:expensive_app/controller/income_controller.dart';
import 'package:expensive_app/controller/loan_controller.dart';
import 'package:expensive_app/controller/privacy_controller.dart';
import 'package:expensive_app/controller/sub_category_controller.dart';
import 'package:expensive_app/controller/todo_controller.dart';
import 'package:expensive_app/controller/transaction_controller.dart';
import 'package:get/get.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(CategoryController());
    Get.put(SubCategoryController());
    Get.put(TransactionController());
    Get.put(IncomeController());
    Get.put(ExpenseController());
    Get.put(TodoController());
    Get.put(LoanController());
    Get.put(AboutController());
    Get.put(PrivacyController());
    Get.put(ConditionController());
  }
}
