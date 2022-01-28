import 'package:checkasync/database/dptlistentity.dart';
import 'package:checkasync/database/psschooldb.dart';
import 'package:checkasync/database/userentity.dart';
import 'package:checkasync/utiles/constant_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController{

  final controlName = TextEditingController();
  final controlFName = TextEditingController();
  final controlEmail = TextEditingController();
  final controlPassword = TextEditingController();
  final controlCPassword = TextEditingController();


  RxBool isObscure=true.obs;

  RxString selectedDpt='Select Dpt'.obs;

  setDpt(String value){
    selectedDpt.value=value;
  }

  RxString selectGender='Gender'.obs;

  setGender(String value){
    selectGender.value=value;
  }


  List<String> genderList=["Gender","MALE", "FEMALE"];


  RxList<String> dptFromDb=<String>['Select Dpt'].obs;

  addDptFromDataBase()async{
    final dataBase= await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final List<DptListEntity> lOfDpt=await dataBase.dptDao.getAllDpt();
    if(lOfDpt.isNotEmpty){
      for(int i=0;i<lOfDpt.length;i++){
        dptFromDb.add(lOfDpt[i].dptName);
      }
    }
  }

  emptyDialog(){

  }

  samePassDialog(){

  }

  loginProcess()async{

    final dataBase = await $FloorPsSchoolDB
        .databaseBuilder("main_database.db")
        .build();
    final UserEntity? checkEmail =
    await dataBase.userDao.getUserByEmail(
        controlEmail.text.toUpperCase());
    if (checkEmail != null) {

      Get.defaultDialog(
        title: 'Email Exist',
        content: const Text(
            "The email you are using is already in use try using different email"),
        onConfirm: (){
          Get.back();
        },
        textConfirm: 'Close',
        confirmTextColor: Colors.white
      );



    } else if (checkEmail == null) {

      final List<UserEntity> cSDept =
      await dataBase.userDao.getUserDptWise(
          selectedDpt.value);
      var length = cSDept.length;
      final UserEntity addThisUser = UserEntity(
          name: controlName.text.toUpperCase(),
          email: controlEmail.text.toUpperCase(),
          pass:
          controlPassword.text.toUpperCase(),
          dpt: selectedDpt.value,
          rollNo: "${selectedDpt.value}-${length + 1}");
      await dataBase.userDao
          .addUser([addThisUser]);
      controlName.clear();
      controlFName.clear();
      controlEmail.clear();
      controlPassword.clear();
      controlCPassword.clear();
      selectedDpt.value='Select Dpt';
      selectGender.value='Gender';
      Get.offNamedUntil(
          kLoginScreen, (route) => false);
    }

  }


@override
  void onInit() {
    // TODO: implement onInit
  addDptFromDataBase();
    super.onInit();
  }


}