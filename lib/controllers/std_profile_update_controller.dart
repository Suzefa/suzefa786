import 'package:checkasync/database/psschooldb.dart';
import 'package:checkasync/database/userentity.dart';
import 'package:checkasync/utiles/constant_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StdProfileUpdateController extends GetxController{

  final upName = TextEditingController();

  final upEmail = TextEditingController();

  final upPass = TextEditingController();

  RxBool passIsObscure=true.obs;

  void giveControllerValues(String _name, String _pass, String _email){
    upName.text=_name;
    upPass.text=_pass;
    upEmail.text=_email;
  }


  void fieldsAreEmpty(){
    Get.defaultDialog(
      title: "Empty Field",
      content: const Text("Please Fill all the fields"),
      confirmTextColor: Colors.white,
      textConfirm: "Close",
      onConfirm: (){
        Get.back();
      }
    );
  }

  void updateProfile(String _email)async{


    final dataBase = await $FloorPsSchoolDB
        .databaseBuilder('main_database.db')
        .build();
    final UserEntity? result = await dataBase
        .userDao
        .getUserByEmail(upEmail.text.toUpperCase());
    if (result != null) {
      /// dataBase have Same Email
      Get.defaultDialog(
        title: "Same Email Found",
        content: const Text(
            "This Email is Already In use"),
        confirmTextColor: Colors.white,
        textConfirm: "Close",
        onConfirm: (){
          Get.back();
        }
      );
    }
    else if (result == null) {
      /// This Email is new For Database
      final UserEntity? updateProfile =
      await dataBase.userDao.getUserByEmail(_email);
      if (updateProfile != null) {
        updateProfile.email =
            upEmail.text.toUpperCase();
        updateProfile.name =
            upName.text.toUpperCase();
        updateProfile.pass =
            upPass.text.toUpperCase();
        await dataBase.userDao
            .updateUser(updateProfile);
        GetStorage().remove("email");
        Get.offNamedUntil(
            kLoginScreen, (route) => false);
      }
    }
  }


}