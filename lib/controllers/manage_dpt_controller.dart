import 'package:checkasync/database/dptlistentity.dart';
import 'package:checkasync/database/psschooldb.dart';
import 'package:checkasync/database/userentity.dart';
import 'package:checkasync/models/dpt_entity_model.dart';
import 'package:checkasync/models/user_entity_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageDptController extends GetxController {
  RxList<UserEntityModels> userFromDb = RxList();

  void deleteStdFromDbAndList(int _id) async {
    final dataBase =
        await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final UserEntity? getProfile = await dataBase.userDao.getSingleUser(_id);
    if (getProfile != null) {
      Get.defaultDialog(
          title: "Delete ${getProfile.name}",
          content: Text('Are you sure to delete ${getProfile.rollNo}.'),
          textConfirm: 'Delete',
          textCancel: "Cancel",
          confirmTextColor: Colors.white,
          cancelTextColor: Colors.white,
          onCancel: () {
            Get.back();
          },
          onConfirm: () async {
            /// Delete profile here
            await dataBase.userDao.deleteUser(getProfile);
            userFromDb.removeWhere((element) => element.id == _id);
            final List<UserEntity> getStdCount =
                await dataBase.userDao.getAllUser();
            countStdDptWise.value = getStdCount.length;
            count();
            Get.back();
          });
    }
  }

  void getAllStdFromDb() async {
    userFromDb.clear();

    final dataBase =
        await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final List<UserEntity> allStd = await dataBase.userDao.getAllUser();
    for (int i = 0; i < allStd.length; i++) {
      final addStdInList = UserEntityModels(
          id: allStd[i].id!,
          name: allStd[i].name,
          email: allStd[i].email,
          pass: allStd[i].pass,
          dpt: allStd[i].dpt,
          rollNo: allStd[i].rollNo);
      userFromDb.add(addStdInList);
      count();
    }
  }

  RxList<UserEntityModels> dptStd = RxList();
  RxInt countStdDptWise = 0.obs;

  void fillDataDptWiseFromDb(String dept) async {
    countStdDptWise.value = 0;
    dptStd.clear();

    final dataBase =
        await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final List<UserEntity> getStdDptWise =
        await dataBase.userDao.getUserDptWise(dept);
    countStdDptWise.value = getStdDptWise.length;
    for (int i = 0; i < getStdDptWise.length; i++) {
      dptStd.add(UserEntityModels(
          id: getStdDptWise[i].id!,
          name: getStdDptWise[i].name,
          email: getStdDptWise[i].email,
          pass: getStdDptWise[i].pass,
          dpt: getStdDptWise[i].dpt,
          rollNo: getStdDptWise[i].rollNo));
    }
  }

  void deleteStdFromStdDptList(int _id) async {
    final dataBase =
        await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final UserEntity? getProfile = await dataBase.userDao.getSingleUser(_id);
    if (getProfile != null) {
      String dptName = getProfile.dpt;
      Get.defaultDialog(
          title: "Delete ${getProfile.name}",
          content: Text('Are you sure to delete ${getProfile.rollNo}.'),
          textConfirm: 'Delete',
          confirmTextColor: Colors.white,
          textCancel: 'Cancel',
          cancelTextColor: Colors.white,
          onCancel: () {
            Get.back();
          },
          onConfirm: () async {
            /// Delete profile here
            await dataBase.userDao.deleteUser(getProfile);
            dptStd.removeWhere((element) => element.id == _id);
            final List<UserEntity> getStdCount =
                await dataBase.userDao.getUserDptWise(dptName);
            countStdDptWise.value = getStdCount.length;
            count();
            Get.back();
          });
    }
  }

  RxInt countAllStd = 0.obs;
  RxInt countAllDpt = 0.obs;

  void count() async {
    final dataBase =
        await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final List<DptListEntity> getAllDpt = await dataBase.dptDao.getAllDpt();
    countAllDpt.value = getAllDpt.length;
    final List<UserEntity> getAllStd = await dataBase.userDao.getAllUser();
    countAllStd.value = getAllStd.length;
  }

  RxList<DptEntityModel> dptFromDb = RxList();

  void fillDataFromDb() async {
    dptFromDb.clear();
    final dataBase =
        await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final List<DptListEntity> getAllDpt = await dataBase.dptDao.getAllDpt();
    for (int i = 0; i < getAllDpt.length; i++) {
      dptFromDb.add(
          DptEntityModel(id: getAllDpt[i].id!, dptName: getAllDpt[i].dptName));
    }
    count();
  }

  final addDpt = TextEditingController();

  void addDptFromUI() async {
    final dataBase =
        await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final DptListEntity? findDpt =
        await dataBase.dptDao.getOnlyDpt(addDpt.text.toUpperCase());
    if (findDpt == null) {
      final DptListEntity addNew =
          DptListEntity(dptName: addDpt.text.toUpperCase());
      await dataBase.dptDao.addDpt([addNew]);
      final DptListEntity? checkId =
          await dataBase.dptDao.getOnlyDpt(addDpt.text.toUpperCase());
      if (checkId != null) {
        dptFromDb
            .add(DptEntityModel(id: checkId.id!, dptName: checkId.dptName));
      }
      Get.snackbar("Add Dpt", 'Dpt Add SuccessFull',
          colorText: Colors.white, backgroundColor: Colors.green);
    } else {
      Get.snackbar(
          'Error', 'This Dpt name Is Already in Use. try Different name',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
    addDpt.clear();
    count();
  }

  void deleteDptFromList(DptEntityModel dptM) async {
    final dataBase =
        await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final List<UserEntity> dptWiseStd =
        await dataBase.userDao.getUserDptWise(dptM.dptName);
    RxString sDpt = "Select Dpt".obs;
    if (dptWiseStd.isNotEmpty) {
      final List<DptListEntity> dptListExcept =
          await dataBase.dptDao.getAllDptExcept(dptM.dptName);
      if (dptListExcept.isEmpty) {
        Get.defaultDialog(
            title: "Alert..!!",
            content: Text(
                "There are ${dptWiseStd.length} Std in this Dpt. for delete this dpt you need to create an empty dpt there first and then shift all the std there."),
            textConfirm: "Close",
            confirmTextColor: Colors.white,
            onConfirm: () {
              Get.back();
            });
      } else {
        List<String> exceptDpt = ['Select Dpt'];
        for (int i = 0; i < dptListExcept.length; i++) {
          exceptDpt.add(dptListExcept[i].dptName);
        }
        Get.defaultDialog(
            title: "Delete ${dptM.dptName}?",
            content: Text(
                'There are ${dptWiseStd.length} Std in ${dptM.dptName}.\nBefore Delete the Dpt Please Shift Std to Other Dpt.\nfor shifting please select a Dpt From Dropdown to shift std there'),
            actions: [
              Obx(() => DropdownButton(
                  value: sDpt.value,
                  items: exceptDpt.map((e) {
                    return DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    );
                  }).toList(),
                  onChanged: (newDpt) {
                    sDpt.value = newDpt.toString();
                  })),
              ElevatedButton(
                  onPressed: () async {
                    if (sDpt.value == 'Select Dpt') {
                      Get.snackbar('Error', "Please Select Dpt First",
                          backgroundColor: Colors.red, colorText: Colors.white);
                    } else {
                      final List<UserEntity> sInSelectedDpt =
                          await dataBase.userDao.getUserDptWise(sDpt.value);
                      if (sInSelectedDpt.isEmpty) {
                        for (int i = 0; i < dptWiseStd.length; i++) {
                          final update = dptWiseStd[i];
                          update.dpt = sDpt.value;
                          update.rollNo = "${sDpt.value}-${i + 1}";
                          await dataBase.userDao.updateUser(update);
                          dptFromDb
                              .removeWhere((element) => element.id == dptM.id);
                        }
                        final DptListEntity? findDpt =
                            await dataBase.dptDao.getDptFromId(dptM.id);
                        await dataBase.dptDao.deleteDPt(findDpt!);
                        count();
                        sDpt.value = 'Select Dpt';
                        Navigator.pop(Get.context!);
                        Get.snackbar('Dpt Deleted', 'DPT DELETED SUCCESS-FULL',
                            colorText: Colors.white,
                            backgroundColor: Colors.red);
                      } else {
                        int totalStdInSDpt = sInSelectedDpt.length;
                        for (int i = 0; i < dptWiseStd.length; i++) {
                          totalStdInSDpt++;
                          final update = dptWiseStd[i];
                          update.dpt = sDpt.value;
                          update.rollNo = "${sDpt.value}-$totalStdInSDpt";
                          await dataBase.userDao.updateUser(update);
                          dptFromDb
                              .removeWhere((element) => element.id == dptM.id);
                        }
                        final DptListEntity? findDpt =
                            await dataBase.dptDao.getDptFromId(dptM.id);
                        await dataBase.dptDao.deleteDPt(findDpt!);
                        count();
                        sDpt.value = 'Select Dpt';
                        Navigator.pop(Get.context!);
                        Get.snackbar('Dpt Deleted', 'DPT DELETED SUCCESS-FULL',
                            colorText: Colors.white,
                            backgroundColor: Colors.red);
                      }
                    }
                  },
                  child: const Text("Delete"))
            ]);
      }
    } else {
      Get.defaultDialog(
        title: "Delete ${dptM.dptName}?",
        content: Text('are you sure to delete ${dptM.dptName}'),
        textConfirm: "Delete",
        textCancel: "Cancel",
        cancelTextColor: Colors.white,
        onCancel: () {
          Get.back();
        },
        confirmTextColor: Colors.white,
        onConfirm: () async {
          final DptListEntity? getDpt =
              await dataBase.dptDao.getDptFromId(dptM.id);
          await dataBase.dptDao.deleteDPt(getDpt!);
          dptFromDb.removeWhere((element) => element.id == dptM.id);
          count();
          Navigator.pop(Get.context!);
          Get.snackbar('Dpt Deleted', 'DPT DELETED SUCCESS-FULL',
              colorText: Colors.white, backgroundColor: Colors.red);
        },
      );
    }
  }

  void updateDpt(String _dptName) async {
    final dataBase =
        await $FloorPsSchoolDB.databaseBuilder('main_database.db').build();
    final DptListEntity? findDpt = await dataBase.dptDao.getOnlyDpt(_dptName);
    if (findDpt != null) {
      debugPrint("${findDpt.id} || ${findDpt.dptName}");
      final List<UserEntity> stdIntThisDpt =
          await dataBase.userDao.getUserDptWise(findDpt.dptName);
      final newName = TextEditingController();
      newName.text = findDpt.dptName;
      if (stdIntThisDpt.isNotEmpty) {
        Get.defaultDialog(
            title: "Update ${findDpt.dptName}",
            content: Column(
              children: [
                const Text('Each and Every Std dpt Name will be change also.!'),
                TextField(
                  controller: newName,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    hintText: "Update Dpt",
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.all(10),
                  ),
                ),
              ],
            ),
            onConfirm: () async {
              if (newName.text.isEmpty) {
                Get.snackbar('Error', 'Fill Field First',
                    backgroundColor: Colors.amber);
              } else if (newName.text.toUpperCase() == findDpt.dptName) {
                Get.back();
                Get.snackbar('No change Detect', 'Dpt Name is Not Change',
                    backgroundColor: Colors.green, colorText: Colors.white);
              } else {
                final DptListEntity? chkCngNme = await dataBase.dptDao
                    .getOnlyDpt(newName.text.toUpperCase());
                if (chkCngNme == null) {
                  /// new name is new for db
                  findDpt.dptName = newName.text.toUpperCase();
                  await dataBase.dptDao.updateDpt(findDpt);
                  for (int i = 0; i < stdIntThisDpt.length; i++) {
                    final updateUser = stdIntThisDpt[i];
                    updateUser.dpt = newName.text.toUpperCase();
                    updateUser.rollNo =
                        "${newName.text.toUpperCase()}-${i + 1}";
                    await dataBase.userDao.updateUser(updateUser);
                  }
                  final index =
                      dptFromDb.indexWhere((e) => e.dptName == _dptName);
                  if (index > -1) {
                    dptFromDb[index].dptName = newName.text.toUpperCase();
                    Get.back();
                    Get.snackbar(
                        'Dpt Update SuccessFull', 'Dpt name Change SuccessFull',
                        backgroundColor: Colors.green, colorText: Colors.white);
                  }
                } else {
                  Get.snackbar('Dpt Name Conflict', 'Same Name Dpt Available');
                }
              }
            },
            textConfirm: "Update",
            confirmTextColor: Colors.white,
            onCancel: () {
              Get.back();
            },
            textCancel: 'Cancel',
            cancelTextColor: Colors.white);
      } else {
        Get.defaultDialog(
            title: "Update ${findDpt.dptName}",
            content: TextField(
              controller: newName,
              textInputAction: TextInputAction.done,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Update Dpt",
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
            onConfirm: () async {
              if (newName.text.isEmpty) {
                Get.snackbar('Error', 'Fill Field First',
                    backgroundColor: Colors.amber);
              } else if (newName.text.toUpperCase() == findDpt.dptName) {
                Get.back();
                Get.snackbar('No change Detect', 'Dpt Name is Not Change',
                    backgroundColor: Colors.green, colorText: Colors.white);
              } else {
                final DptListEntity? chkCngNme = await dataBase.dptDao
                    .getOnlyDpt(newName.text.toUpperCase());
                if (chkCngNme == null) {
                  /// new name is new for db
                  findDpt.dptName = newName.text.toUpperCase();
                  await dataBase.dptDao.updateDpt(findDpt);
                  final index =
                      dptFromDb.indexWhere((e) => e.dptName == _dptName);
                  if (index > -1) {
                    dptFromDb[index].dptName = newName.text.toUpperCase();
                    Get.back();
                    Get.snackbar(
                        'Dpt Update SuccessFull', 'Dpt name Change SuccessFull',
                        backgroundColor: Colors.green, colorText: Colors.white);
                  }
                } else {
                  Get.snackbar('Dpt Name Conflict', 'Same Name Dpt Available');
                }
              }
            },
            textConfirm: "Update",
            confirmTextColor: Colors.white,
            cancelTextColor: Colors.white,
            onCancel: () {
              Get.back();
            },
            textCancel: "Cancel");
      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fillDataFromDb();
    getAllStdFromDb();
    count();
    super.onInit();
  }
}
