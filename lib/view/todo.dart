import 'package:expensive_app/controller/todo_controller.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    TextEditingController task = TextEditingController();
    var todoController = Get.find<TodoController>();
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.bottomSheet(
                SingleChildScrollView(
                  child: Container(
                    height: Get.size.height * .50,
                    color: Colors.grey.shade50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        key: key,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Write your notes",
                              style: Theme.of(context).textTheme.headline6,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: task,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) => value!.isEmpty ? 'required' : null,
                              maxLines: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                    onPressed: () {
                                      if (key.currentState!.validate()) {
                                        Map data = {"task": task.text};
                                        RemoteService.postTodo(data).whenComplete(() {
                                          todoController.getTodos();
                                          Navigator.pop(context);
                                        });
                                      }
                                    },
                                    child: const Text("Submit")),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
          appBar: AppBar(
            title: const Text("Todo"),
          ),
          body: Obx(() {
            if (todoController.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return todoController.todos.value.data.isNotEmpty
                  ? SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: todoController.todos.value.data.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var mydata = todoController.todos.value.data[index];
                              return Card(
                                elevation: .2,
                                child: ListTile(
                                  title: Text(mydata.task),
                                  subtitle: Text(mydata.createdAt),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text("No Record Found"),
                    );
            }
          })),
    );
  }
}
