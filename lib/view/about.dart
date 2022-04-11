import 'package:expensive_app/controller/about_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var aboutController = Get.find<AboutController>();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("About us"),
        ),
        body: Obx(() {
          if (aboutController.isLoading.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListTile(
              title: Text(
                aboutController.about.value.title,
                style: Theme.of(context).textTheme.headline4,
              ),
              subtitle: Text(aboutController.about.value.description),
            );
          }
        }),
      ),
    );
  }
}
