import 'package:checkasync/controllers/std_profile_update_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:checkasync/models/user_entity_models.dart';

class StdProfileUpdate extends GetView<StdProfileUpdateController> {
  StdProfileUpdate({Key? key}) : super(key: key);


  final UserEntityModels argument=Get.arguments;


  @override
  Widget build(BuildContext context) {

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Update Profile"),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding:
              const EdgeInsets.only(top: 30, bottom: 30, left: 10, right: 10),
              child: ListView(
                children: [
                  Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white54,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Name :"),
                            TextField(
                              textAlign: TextAlign.center,
                              controller: controller.upName,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Name',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Email :"),
                            TextField(
                              textAlign: TextAlign.center,
                              controller: controller.upEmail,
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: 'Email',
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Pass :"),
                            Obx(()=>TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.text,
                              obscureText: controller.passIsObscure.value,
                              controller: controller.upPass,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                suffixIcon:
                                IconButton(
                                  icon: Icon(controller.passIsObscure.value
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onPressed: () {
                                    controller.passIsObscure.toggle();
                                  },
                                ),
                                hintText: "PassWord",
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            )),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Roll No :"),
                            TextField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: argument.rollNo,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text("Department :"),
                            TextField(
                              enabled: false,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                hintText: argument.dpt,
                                filled: true,
                                fillColor: Colors.white,
                                contentPadding: const EdgeInsets.all(10),
                              ),
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  if (controller.upName.text.isEmpty &&
                                      controller.upPass.text.isEmpty &&
                                      controller.upEmail.text.isEmpty) {

                                    controller.fieldsAreEmpty();

                                  }

                                  ///  update full profile here also check same email
                                  else if (controller.upName.text.isNotEmpty &&
                                      controller.upPass.text.isNotEmpty &&
                                      controller.upEmail.text.isNotEmpty) {
                                    if(GetUtils.isEmail(controller.upEmail.text)){
                                      controller.updateProfile(argument.email);
                                    }else{
                                      Get.snackbar('Email is Not valid', 'Please Provide a Valid email',backgroundColor: Colors.red,colorText: Colors.white);
                                    }


                                  }

                                  else {
                                    Get.defaultDialog(
                                      title: "Error",
                                      content: const Text("Not All field are Fill properly"),
                                      textConfirm: "Close",
                                      onConfirm: (){
                                        Get.back();
                                      },confirmTextColor: Colors.white
                                    );
                                  }
                                },
                                child: const Text("Update Profile"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
