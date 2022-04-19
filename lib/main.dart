import 'package:expensive_app/bindings/controller_bindings.dart';
import 'package:expensive_app/controller/category_controller.dart';
import 'package:expensive_app/view/add_transaction.dart';
import 'package:expensive_app/view/home.dart';
import 'package:expensive_app/view/letsgo.dart';
import 'package:expensive_app/view/login.dart';
import 'package:expensive_app/view/splash.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Expensive Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      defaultTransition: Transition.fadeIn,
      routes: {
      "/": (context) => const SplashView(),
      "letsgo": (context) => const LetsGo(),
      "login": (context) => const LoginView(),
      "home": (context) => const HomeView(),
      },
      initialBinding: ControllerBinding(),
    );
  }
}
