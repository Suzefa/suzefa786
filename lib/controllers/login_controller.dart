
import 'package:checkasync/database/psschooldb.dart';
import 'package:checkasync/database/userentity.dart';
import 'package:checkasync/models/user_entity_models.dart';
import 'package:checkasync/utiles/constant_variable.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  RxBool isObscure = true.obs;

  final controlPassword = TextEditingController();

  final controlEmail = TextEditingController();

  void showEmptyFieldDialog() {
    Get.defaultDialog(
        title: "Fields are Empty",
        content: const Text(
            "One or More Fields are Empty.\nplease fill all the field"),
        onConfirm: () {
          Get.back();
        },
        textConfirm: "Close",
        confirmTextColor: Colors.white
    );
  }

  void loginProcess() async {
    final dataBase =
        await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final UserEntity? checkEmail =
        await dataBase.userDao.getUserByEmail(controlEmail.text.toUpperCase());
    if (checkEmail != null) {
      if (controlEmail.text.toUpperCase() == "ADMIN" &&
          controlPassword.text.toUpperCase() == "ADMIN") {
        Get.offNamedUntil(kAdminScreen, (route) => false);
        controlPassword.clear();
        controlEmail.clear();
        isObscure.value = true;
      } else if (controlEmail.text.toUpperCase() == checkEmail.email &&
          controlPassword.text.toUpperCase() == checkEmail.pass) {
        GetStorage().write('email', controlEmail.text.toUpperCase());
        Get.offNamedUntil(kStudentScreen, (route) => false,
            arguments: UserEntityModels(
                id: checkEmail.id!,
                name: checkEmail.name,
                email: checkEmail.email,
                pass: checkEmail.pass,
                dpt: checkEmail.dpt,
                rollNo: checkEmail.rollNo));
        controlPassword.clear();
        controlEmail.clear();
        isObscure.value = true;
      }
    } else if (checkEmail == null) {
      if (controlEmail.text.toUpperCase() == "ADMIN" &&
          controlPassword.text.toUpperCase() == "ADMIN") {
        Get.offNamedUntil(kAdminScreen, (route) => false);
        controlEmail.clear();
        controlPassword.clear();
        isObscure.value = true;
      } else {
        Get.defaultDialog(
            title: "Account Not Found",
            content: const Text("Please Create Account first"),
            onConfirm: () {
              Get.back();
            },
            textConfirm: 'Close',
            confirmTextColor: Colors.white);
      }
    }
  }

  void jumpToPage()async{
    final getStorage = GetStorage();
    String email=(getStorage.read('email')).toString();
    if(email!="Null"){
      /// jump to std Page
      final dataBase= await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
      final UserEntity? getUser=await dataBase.userDao.getUserByEmail(email);
      if(getUser==null){
        Get.snackbar('New User', 'Login First',colorText: Colors.white,backgroundColor: Colors.black);
      }else{
        Get.offAndToNamed(kStudentScreen,arguments: UserEntityModels(
            id: getUser.id!,
            name: getUser.name,
            email: getUser.email,
            pass: getUser.pass,
            dpt: getUser.dpt,
            rollNo: getUser.rollNo)
        );
        Get.snackbar("WellCome ${getUser.name}", "Page is being redirect",colorText: Colors.white,backgroundColor: Colors.green);
      }

    }

  }

  @override
  void onInit() {
    // TODO: implement onInit
    jumpToPage();
    super.onInit();
  }

}