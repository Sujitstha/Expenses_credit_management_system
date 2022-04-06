import 'package:expensive_app/controller/loan_controller.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:expensive_app/view/loan.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoanTransactionView extends StatefulWidget {
  const LoanTransactionView({Key? key}) : super(key: key);

  @override
  State<LoanTransactionView> createState() => _LoanTransactionViewState();
}

class _LoanTransactionViewState extends State<LoanTransactionView> {
  TextEditingController name = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController purpose = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController date = TextEditingController();
  TextEditingController remarks = TextEditingController();

  GlobalKey<FormState> key = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
        date.text = selectedDate.toString().substring(0, 10);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var loanController = Get.find<LoanController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Credit Transaction"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: key,
              child: Column(
                children: [
                  //Name
                  TextFormField(
                    controller: name,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    validator: (value) => value!.isEmpty ? 'required' : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: address,
                    decoration: const InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    validator: (value) => value!.isEmpty ? 'required' : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //Mobile
                  TextFormField(
                    controller: mobile,
                    decoration: const InputDecoration(
                      labelText: 'Mobile',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    validator: (value) => value!.isEmpty ? 'required' : null,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //Purpose
                  TextFormField(
                    controller: purpose,
                    decoration: const InputDecoration(
                      labelText: 'Purpose for loan',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    validator: (value) => value!.isEmpty ? 'required' : null,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    controller: amount,
                    decoration: const InputDecoration(
                      labelText: 'amount',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    validator: (value) => value!.isEmpty ? 'required' : null,
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  //Due Date
                  TextFormField(
                    controller: date,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(5),
                        hintText: 'Pick Date',
                        suffixIcon: IconButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            icon: const Icon(Icons.date_range))),
                    keyboardType: TextInputType.text,
                    validator: (value) => value!.isEmpty ? 'required' : null,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  TextFormField(
                    controller: remarks,
                    decoration: const InputDecoration(
                      labelText: 'Remarks',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                    validator: (value) => value!.isEmpty ? 'required' : null,
                    keyboardType: TextInputType.text,
                    maxLines: 4,
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            if (key.currentState!.validate()) {
                              Map data = {
                                'name': name.text,
                                'address': address.text,
                                'mobile': mobile.text,
                                'purpose': purpose.text,
                                'amount': amount.text,
                                'due_date': date.text,
                                'remarks': remarks.text,
                              };
                              print("sajal");
                              RemoteService.addLoan(data).whenComplete(() {
                                loanController.getLoans();
                                Get.off(() => const LoanView());
                              });
                            }
                          },
                          child: const Text("Save Record")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
