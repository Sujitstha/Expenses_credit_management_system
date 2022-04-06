import 'package:expensive_app/controller/category_controller.dart';
import 'package:expensive_app/controller/sub_category_controller.dart';
import 'package:expensive_app/controller/transaction_controller.dart';
import 'package:expensive_app/service/remote_service.dart';
import 'package:expensive_app/settings/app_size.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTransactionView extends StatefulWidget {
  const AddTransactionView({Key? key}) : super(key: key);

  @override
  State<AddTransactionView> createState() => _AddTransactionViewState();
}

class _AddTransactionViewState extends State<AddTransactionView> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  TextEditingController amount = TextEditingController();
  TextEditingController remarks = TextEditingController();
  TextEditingController date = TextEditingController();
  String? selectedCategory;
  String? selectedSubCategory;
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
    var categoryController = Get.find<CategoryController>();
    var subCategoryController = Get.find<SubCategoryController>();
    var transactionController = Get.find<TransactionController>();
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: const Text("New Transaction"),
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
                          keyboardType: TextInputType.number,
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

                                    RemoteService.postTransaction(data).whenComplete(() {
                                      date.clear();
                                      selectedCategory = null;
                                      selectedSubCategory = null;
                                      amount.clear();
                                      remarks.clear();
                                      transactionController.getTransaction();
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
