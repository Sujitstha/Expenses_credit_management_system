import 'package:expensive_app/controller/expense_controller.dart';
import 'package:expensive_app/controller/income_controller.dart';
import 'package:expensive_app/controller/todo_controller.dart';
import 'package:expensive_app/view/expenses_list.dart';
import 'package:expensive_app/view/income_list.dart';
import 'package:expensive_app/view/todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var incomeController = Get.find<IncomeController>();
    var expensesController = Get.find<ExpenseController>();
    var todoController = Get.find<TodoController>();
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text(
              "Expensive Management",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(Icons.home),
            title: const Text("Home"),
          ),
          ListTile(
            title: Text(
              "Daily",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListTile(
            onTap: () {
              todoController.getTodos();
              Navigator.pop(context);
              Get.to(() => const TodoView());
            },
            leading: const Icon(
              Icons.task_rounded,
              color: Colors.green,
            ),
            title: const Text("Todo"),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.attach_money_outlined,
              color: Colors.green,
            ),
            title: const Text("Loan"),
          ),
          ListTile(
            title: Text(
              "Report",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListTile(
            onTap: () {
              incomeController.getIncomeList();
              Navigator.pop(context);
              Get.to(() => const IncomListView());
            },
            leading: const Icon(
              Icons.arrow_circle_down,
              color: Colors.green,
            ),
            title: const Text("Income Details"),
          ),
          ListTile(
            onTap: () {
              expensesController.getExpensesList();
              Navigator.pop(context);
              Get.to(() => const ExpensesListView());
            },
            leading: const Icon(
              Icons.arrow_circle_up,
              color: Colors.red,
            ),
            title: const Text("Expensive Details"),
          ),
          ListTile(
            onTap: () {},
            leading: const Icon(
              Icons.monetization_on_rounded,
              color: Colors.amber,
            ),
            title: const Text("Loan Report"),
          ),
          ListTile(
            title: Text(
              "Company",
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(Icons.info),
            title: const Text("About us"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(Icons.security),
            title: const Text("Privacy & Policy"),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(Icons.rule),
            title: const Text("Terms & Condition"),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.pop(context);
            },
            leading: const Icon(Icons.exit_to_app),
            title: const Text("Logout"),
          ),
        ],
      ),
    );
  }
}
