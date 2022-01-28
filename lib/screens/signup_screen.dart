import 'package:checkasync/controllers/signup_controller.dart';
import 'package:checkasync/utiles/constant_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreen extends GetView<SignUpController> {

  const SignUpScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: ListView(
              children: [
                Card(
                  color: Colors.white54,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 10,
                  child: Container(
                    width: _size.width,
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          controller: controller.controlName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            hintText: "Name",
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.all(10),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          controller: controller.controlFName,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Father Name",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextField(
                          textInputAction: TextInputAction.next,
                          textAlign: TextAlign.center,
                          controller: controller.controlEmail,
                          decoration: InputDecoration(
                            suffixIcon: const Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20)),
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.all(10),
                            hintText: "Email",
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => TextField(
                            textInputAction: TextInputAction.next,
                            textAlign: TextAlign.center,
                            obscureText: controller.isObscure.value,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: controller.controlPassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
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
                              filled: true,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Password",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => TextField(
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.center,
                            obscureText: controller.isObscure.value,
                            autocorrect: false,
                            enableSuggestions: false,
                            controller: controller.controlCPassword,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
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
                              filled: true,
                              contentPadding: const EdgeInsets.all(10),
                              hintText: "Confirm Password",
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                         Obx((){
                           return DropdownButton(
                               value: controller.selectedDpt.value,
                               hint: const Text("Dept"),
                               items: controller.dptFromDb.map((element) {
                                 return DropdownMenuItem(
                                   value: element,
                                   child: Text(element),
                                 );
                               }).toList(),
                               onChanged: (newDpt) {
                                 controller.setDpt(newDpt.toString());
                               });
                         }),
                        const SizedBox(
                          width: 10,
                        ),
                        Obx((){
                          return DropdownButton(
                            onChanged: (newValue) {
                              controller.setGender(newValue.toString());
                            },
                            value: controller.selectGender.value,
                            hint: const Text("Gender"),
                            items: controller.genderList.map((e) {
                              return DropdownMenuItem(
                                  value: e,
                                  child: Text(e));
                            }).toList(),
                          );
                        }),
                        ElevatedButton.icon(
                            onPressed: () async {
                              if (controller.controlName.text.isEmpty ||
                                  controller.controlFName.text.isEmpty ||
                                  controller.controlEmail.text.isEmpty ||
                                  controller.controlPassword.text.isEmpty ||
                                  controller.controlCPassword.text.isEmpty ||
                                  controller.selectedDpt.value=='Select Dpt'||
                                  controller.selectGender.value=='Gender') {

                                Get.snackbar('Fields are Empty', 'One or More Fields are Empty',backgroundColor: Colors.red,colorText: Colors.white);
                              }
                              else {
                                if(GetUtils.isEmail(controller.controlEmail.text)){
                                  if (controller.controlPassword.text ==
                                      controller.controlCPassword.text) {
                                    controller.loginProcess();
                                  }
                                  else {
                                    Get.snackbar('Password Conflict', 'The Password and Confirm password is not Same',backgroundColor: Colors.red,colorText: Colors.white);
                                  }
                                }else{
                                  Get.snackbar('Email is not Valid', 'Please Use Genuine Email',backgroundColor: Colors.red,colorText: Colors.white);
                                }

                              }
                            },
                            icon: const Icon(Icons.person),
                            label: const Text("SignUp"),
                          ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text("Already have an account.?"),
                        TextButton(
                            onPressed: () {
                              Get.offNamedUntil(
                                  kLoginScreen, (route) => false);
                            },
                            child: const Text("Login"))
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
