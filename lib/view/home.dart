import 'package:d_chart/d_chart.dart';
import 'package:expensive_app/controller/category_controller.dart';
import 'package:expensive_app/controller/expense_controller.dart';
import 'package:expensive_app/controller/income_controller.dart';
import 'package:expensive_app/controller/loan_controller.dart';
import 'package:expensive_app/controller/transaction_controller.dart';
import 'package:expensive_app/settings/app_size.dart';
import 'package:expensive_app/view/add_transaction.dart';
import 'package:expensive_app/widget/drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.find<CategoryController>();
    var transactionController = Get.find<TransactionController>();
    var loanController = Get.find<LoanController>();
    var incomeController = Get.find<IncomeController>();
    var expansesController = Get.find<ExpenseController>();
    loanController.getLoans();
    transactionController.getTransaction();
    incomeController.getTotalIncome();
    expansesController.getTotalExpanses();
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              categoryController.getCategories();
              Get.to(() => const AddTransactionView());
            },
            child: const Icon(Icons.add),
          ),
          drawer: const MyDrawer(),
          appBar: AppBar(
            title: const Text("Expensive Management"),
          ),
          body: Obx(() {
            if (transactionController.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(color: Colors.red.shade200),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Total Expanses",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
                                    ),
                                    Text(
                                      "Rs.${expansesController.totalExpanses.value.totalExpenses}",
                                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(color: Colors.green.shade200),
                                child: Column(
                                  children: [
                                    const Text(
                                      "Total Income",
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Colors.black),
                                    ),
                                    Text(
                                      "Rs.${incomeController.totalIncome.value.totalIncome}",
                                      style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: AspectRatio(
                        aspectRatio: 16 / 9,
                        child: DChartBar(
                          data: [
                            {
                              'id': 'Bar',
                              'data': [
                                {'domain': 'Income', 'measure': incomeController.totalIncome.value.totalIncome},
                                {'domain': 'Expenses', 'measure': expansesController.totalExpanses.value.totalExpenses},
                              ],
                            },
                          ],
                          domainLabelPaddingToAxisLine: 16,
                          axisLineTick: 2,
                          axisLinePointTick: 2,
                          axisLinePointWidth: 10,
                          axisLineColor: Colors.red,
                          measureLabelPaddingToAxisLine: 16,
                          barColor: (barData, index, id) => Colors.green,
                          showBarValue: true,
                          animate: true,
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        "Recent Transaction",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    ListView.builder(
                      itemCount: transactionController.transactions.value.data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        var mydata = transactionController.transactions.value.data[index];
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
                                          mydata.category == "income"
                                              ? const Icon(
                                                  Icons.arrow_circle_down,
                                                  color: Colors.green,
                                                )
                                              : const Icon(
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
                    ),
                    ListTile(
                      title: Text(
                        "Credit History",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: loanController.loans.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            elevation: .2,
                            child: ListTile(
                              title: Text(
                                loanController.loans[index].name,
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    loanController.loans[index].address,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    loanController.loans[index].mobile,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                              trailing: Text(loanController.loans[index].amount),
                            ));
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
