import 'package:expensive_app/service/remote_service.dart';
import 'package:expensive_app/settings/app_size.dart';
import 'package:expensive_app/view/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> key = GlobalKey<FormState>();
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(AppSize.pagePadding),
              child: Form(
                key: key,
                child: Column(
                  children: [
                    Image.asset(
                      "images/icon.png",
                      width: Get.size.width * .30,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                          hintText: 'Email',
                          suffixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty ? 'required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: password,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.visibility_off)),
                          border: const OutlineInputBorder(),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
                      keyboardType: TextInputType.text,
                      validator: (value) => value!.isEmpty ? 'required' : null,
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              onPressed: () {
                                if (key.currentState!.validate()) {
                                  Map data = {
                                    "email": email.text,
                                    "password": password.text,
                                  };
                                  RemoteService.login(data);
                                }
                              },
                              child: const Text("Login")),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const RegisterView());
                      },
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(color: Colors.black),
                          children: [
                            TextSpan(text: 'Are you new? '),
                            TextSpan(text: 'Register', style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
