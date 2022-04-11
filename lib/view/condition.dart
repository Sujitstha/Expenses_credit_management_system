import 'package:expensive_app/controller/condition_controller.dart';
import 'package:expensive_app/controller/privacy_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class ConditionView extends StatelessWidget {
  const ConditionView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var conditionController = Get.find<ConditionController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Terms & Condition"),
        ),
        body: Obx(() {
          if (conditionController.isLoading.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: ListTile(
                title: Text(
                  conditionController.condition.value.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Html(data: conditionController.condition.value.description),
              ),
            );
          }
        }),
      ),
    );
  }
}
