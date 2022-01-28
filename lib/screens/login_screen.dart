import 'package:checkasync/controllers/login_controller.dart';
import 'package:checkasync/utiles/constant_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends GetView<LoginController> {

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var sizeOfScreen = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                const SizedBox(
                  height: 100,
                ),
                Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white54,
                  child: Container(
                    width: sizeOfScreen.width,
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          textAlign: TextAlign.center,
                          controller: controller.controlEmail,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                              suffixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              hintText: "Email",
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.all(10),
                              icon: const Icon(Icons.person)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Obx(() =>
                          TextField(
                            textAlign: TextAlign.center,
                            obscureText: controller.isObscure.value,
                            autocorrect: false,
                            enableSuggestions: false,
                            textInputAction: TextInputAction.done,
                            controller: controller.controlPassword,
                            decoration: InputDecoration(
                              suffixIcon:
                                 IconButton(
                                  icon: Icon(controller.isObscure.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    controller.isObscure.toggle();
                                  },
                                ),

                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              fillColor: Colors.white,
                              icon: const Icon(Icons.lock),
                              filled: true,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Password",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ElevatedButton.icon(
                          onPressed: () async {
                            if (controller.controlPassword.text.isEmpty ||
                                controller.controlEmail.text.isEmpty) {

                              controller.showEmptyFieldDialog();


                            }
                            else if (controller.controlPassword.text.isNotEmpty &&
                                controller.controlEmail.text.isNotEmpty) {

                              controller.loginProcess();

                            }
                          },
                          icon: const Icon(Icons.login),
                          label: const Text("Log in"),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("Don't have an account.?"),
                        TextButton(
                            onPressed: () {
                              Get.toNamed(kSignUpScreen);
                            },
                            child: const Text("Create a new Account"))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
