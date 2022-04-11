import 'package:expensive_app/controller/about_controller.dart';
import 'package:expensive_app/controller/privacy_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var privacyController = Get.find<PrivacyController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Privacy & Policy"),
        ),
        body: Obx(() {
          if (privacyController.isLoading.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return SingleChildScrollView(
              child: ListTile(
                title: Text(
                  privacyController.privacy.value.title,
                  style: Theme.of(context).textTheme.headline4,
                ),
                subtitle: Html(data: privacyController.privacy.value.description),
              ),
            );
          }
        }),
      ),
    );
  }
}
