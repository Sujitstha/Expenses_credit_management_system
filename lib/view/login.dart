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
                    const FlutterLogo(
                      size: 40,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(hintText: 'Email', suffixIcon: Icon(Icons.person)),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty ? 'required' : null,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: password,
                      decoration:
                          InputDecoration(hintText: 'Password', suffixIcon: IconButton(onPressed: () {}, icon: const Icon(Icons.visibility_off))),
                      keyboardType: TextInputType.text,
                      validator: (value) => value!.isEmpty ? 'required' : null,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
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
