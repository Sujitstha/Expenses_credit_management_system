import 'package:expensive_app/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void checkAuth() {
    Future.delayed(const Duration(seconds: 2), () {
      Get.off(() => const LoginView());
    });
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "images/icon.png",
            width: Get.size.width * .30,
          ),
          const Text("Expanses Management System")
        ],
      ),
    ));
  }
}
