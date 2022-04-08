import 'package:expensive_app/controller/category_controller.dart';
import 'package:expensive_app/controller/expense_controller.dart';
import 'package:expensive_app/controller/income_controller.dart';
import 'package:expensive_app/controller/sub_category_controller.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:expensive_app/settings/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditTransaction extends StatefulWidget {
  final int transactionId;
  final String date;
  final int category_id;
  final int subcategory_id;
  final String amount;
  final String remarks;

  const EditTransaction(
      {Key? key,
      required this.transactionId,
      required this.date,
      required this.category_id,
      required this.subcategory_id,
      required this.amount,
      required this.remarks})
      : super(key: key);

  @override
  State<EditTransaction> createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController date = TextEditingController();
  String? selectedCategory;
  String? selectedSubCategory;
  int? id;
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
  void initState() {
    super.initState();
    id = widget.transactionId;
    date.text = widget.date.toString().substring(0, 10);
    selectedCategory = widget.category_id.toString();
    selectedSubCategory = widget.subcategory_id.toString();
    amount.text = widget.amount;
    remarks.text = widget.remarks;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var categoryController = Get.find<CategoryController>();
    var subCategoryController = Get.find<SubCategoryController>();
    var incomeController = Get.find<IncomeController>();
    var expenseController = Get.find<ExpenseController>();
    categoryController.getCategories();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Edit Transaction"),
          ),
          body: Obx(() {
            if (categoryController.isLoading.value == true) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(AppSize.pagePadding),
                  child: Form(
                    key: key,
                    child: Column(
                      children: [
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
                        //Category
                        const SizedBox(height: 10),
                        DropdownButtonFormField(
                          decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.all(5)),
                          hint: const Text("Select Category"),
                          items: categoryController.categories.value.data.map((e) {
                            return DropdownMenuItem(
                              child: Text(e.name),
                              value: e.id,
                            );
                          }).toList(),
                          onChanged: (value) {
                            // print(value);
                            selectedCategory = value.toString();
                            subCategoryController.getSubCategoreis(int.parse(value.toString()));
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        subCategoryController.isLoading.value == true
                            ? const SizedBox()
                            : DropdownButtonFormField(
                                decoration: const InputDecoration(border: OutlineInputBorder(), contentPadding: EdgeInsets.all(5)),
                                hint: const Text("Select Subcategory"),
                                items: subCategoryController.subcategories.map((e) {
                                  return DropdownMenuItem(
                                    child: Text(e.name),
                                    value: e.id,
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  // print(value);
                                  selectedSubCategory = value.toString();
                                },
                              ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: amount,
                          decoration: const InputDecoration(hintText: 'Amount', border: OutlineInputBorder(), contentPadding: EdgeInsets.all(5)),
                          keyboardType: TextInputType.text,
                          validator: (value) => value!.isEmpty ? 'required' : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: remarks,
                          decoration: const InputDecoration(hintText: 'Remarks', border: OutlineInputBorder(), contentPadding: EdgeInsets.all(5)),
                          keyboardType: TextInputType.text,
                          validator: (value) => value!.isEmpty ? 'required' : null,
                          maxLines: 3,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                                onPressed: () {
                                  if (key.currentState!.validate()) {
                                    Map data = {
                                      'id': id,
                                      "date": date.text,
                                      "category_id": selectedCategory,
                                      "sub_category_id": selectedSubCategory,
                                      "amount": amount.text,
                                      "remarks": remarks.text
                                    };

                                    if (selectedCategory == null) {
                                      Get.defaultDialog(content: const Text("Please Select Category"));
                                    }

                                    if (subCategoryController.isLoading.value == false && selectedSubCategory == null) {
                                      Get.defaultDialog(content: const Text("Please Select SubCategory"));
                                    }

                                    RemoteService.updateTransaction(data, id!).whenComplete(() {
                                      date.clear();
                                      selectedCategory = null;
                                      selectedSubCategory = null;
                                      amount.clear();
                                      remarks.clear();
                                      incomeController.getIncomeList();
                                      expenseController.getExpensesList();
                                    });
                                  }
                                },
                                child: const Text("Save Record")),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          })),
    );
  }
}
