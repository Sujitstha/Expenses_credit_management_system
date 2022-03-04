import 'package:expensive_app/model/expense_model.dart';
import 'package:expensive_app/model/todo_model.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  var todos = TodoModel(data: []).obs;
  var isLoading = true.obs;

  Future getTodos() async {
    try {
      isLoading(true);
      var data = await RemoteService.fetchTodos();
      if (data != null) {
        todos.value = data;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading(false);
    }
  }
}
