import 'package:expensive_app/view/home.dart';
import 'package:expensive_app/view/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  void checkAuth() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var token = preferences.getString("token");
    if (token != null) {
      Future.delayed(const Duration(seconds: 2), () {
        Get.off(() => const HomeView());
      });
    } else {
      Future.delayed(const Duration(seconds: 2), () {
        Get.off(() => const LoginView());
      });
    }
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
