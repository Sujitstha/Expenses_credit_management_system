import 'package:expensive_app/controller/loan_controller.dart';
import 'package:expensive_app/view/loan_transaction.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanView extends StatelessWidget {
  const LoanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loanController = Get.find<LoanController>();
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.to(() => const LoanTransactionView());
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Loan"),
        ),
        body: Obx(() {
          if (loanController.isLoading.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return loanController.loans.isNotEmpty
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          ListView.builder(
                            itemCount: loanController.loans.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (BuildContext context, int index) {
                              var mydata = loanController.loans[index];
                              return Card(
                                elevation: .2,
                                child: ListTile(
                                  contentPadding: const EdgeInsets.all(5),
                                  trailing: Text(
                                    "Rs.${mydata.amount}",
                                    style: Theme.of(context).textTheme.headline6,
                                  ),
                                  title: Text(mydata.name),
                                  subtitle: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(mydata.address),
                                      Text(mydata.mobile),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: Text("No Record Found"),
                  );
          }
        }),
      ),
    );
  }
}
