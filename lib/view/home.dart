import 'package:expensive_app/controller/category_controller.dart';
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
    loanController.getLoans();
    transactionController.getTransaction();
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
                    // Chart

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
                        "Loan History",
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
