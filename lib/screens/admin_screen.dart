
import 'package:checkasync/controllers/manage_dpt_controller.dart';
import 'package:checkasync/utiles/constant_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AdminScreen extends GetView<ManageDptController> {
  const AdminScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: const Text("Admin Panel"),
            centerTitle: true,
          ),
          body: Center(
            child: Container(
              padding:const EdgeInsets.all(20),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Hello Admin\n\n",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  Obx(()=>Text("There are ${controller.countAllDpt} Dpt present in DB.",style: const TextStyle(fontSize: 15,)),),
                  Obx(()=>Text("\n\nThere are Total ${controller.countAllStd} Std in DB corresponding to different Dpt",style: const TextStyle(fontSize: 15,)),),
                  const Text('\n\nto EDIT , UPDATE , CREATE and DELETE Dpt go through the drawer and go for Manage DPt.\n\n'),
                  const Text('to EDIT , UPDATE and DELETE Std got through the drawer and go for Manage Sdt.')
                ],
              ),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children:  [
                const UserAccountsDrawerHeader(
                  accountName: Text("ADMIN"),
                  accountEmail: Text("Admin"),
                  currentAccountPicture: CircleAvatar(
                    child: Text("A",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  ),
                ),
                ListTile(
                  title: const Text("Manage Dpt"),
                  onTap: (){
                    Get.back();
                    Get.toNamed(kManageDptScreen);
                  },
                ),
                ListTile(
                  title: const Text("Manage Students"),
                  onTap: (){
                    controller.getAllStdFromDb();
                    Get.back();
                    Get.toNamed(kManageStdScreen);
                  },
                ),
                ListTile(
                  title: const Text("Log Out"),
                  onTap: (){
                    Get.back();
                    Get.offNamedUntil(kLoginScreen, (route) => false);
                  },
                )
              ],
            ),
          ),
        )
    );
  }
}
