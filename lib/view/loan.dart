import 'package:expensive_app/controller/loan_controller.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:expensive_app/view/loan_edit.dart';
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
          title: const Text("Credit List"),
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
                                      Row(
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                Get.to(() => LoanEditView(
                                                      id: mydata.id,
                                                      name: mydata.name,
                                                      address: mydata.address,
                                                      mobile: mydata.mobile,
                                                      purpose: mydata.purpose,
                                                      date: mydata.dueDate.toString(),
                                                      remarks: mydata.remarks,
                                                      amount: mydata.amount,
                                                    ));
                                              },
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.blue,
                                              )),
                                          IconButton(
                                              onPressed: () {
                                                RemoteService.deleteLoan(mydata.id).whenComplete(() {
                                                  loanController.getLoans();
                                                });
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ))
                                        ],
                                      )
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
