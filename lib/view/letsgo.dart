// ignore_for_file: prefer_const_constructors, unused_import

import 'package:expensive_app/widget/myButton.dart';
import 'package:flutter/material.dart';

class LetsGo extends StatelessWidget {
  const LetsGo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/letsgo.jpg",
              ),
              
              SizedBox(
                height: 50,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: myButton(
                      context, 209, 43, 'Lets Get Started', 'login')),
              SizedBox(
                height: 30,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: myButton(context, 209, 43, 'Skip', 'home')),
            ],
          ),
        ),
      ),
    );
  }
}
