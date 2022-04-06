import 'package:expensive_app/controller/expense_controller.dart';
import 'package:expensive_app/settings/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExpensesListView extends StatelessWidget {
  const ExpensesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var expensesController = Get.find<ExpenseController>();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Expenses History"),
          ),
          body: Obx(() {
            if (expensesController.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      title: Text(
                        "EXPENSES",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    ListView.builder(
                      itemCount: expensesController.expenses.value.data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var mydata = expensesController.expenses.value.data[index];
                        return Card(
                          elevation: .2,
                          child: Container(
                              padding: EdgeInsets.symmetric(horizontal: AppSize.pagePadding, vertical: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            mydata.subcategory,
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                          Text(
                                            mydata.category,
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                          Text(
                                            mydata.remarks,
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "${mydata.date}".substring(0, 10),
                                            style: Theme.of(context).textTheme.caption,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Text(
                                            "${mydata.amount}",
                                            style: Theme.of(context).textTheme.bodyText1,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(
                                            Icons.arrow_circle_up,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )),
                        );
                      },
                    )
                  ],
                ),
              );
            }
          })),
    );
  }
}
