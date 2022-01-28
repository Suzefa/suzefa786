import 'package:checkasync/controllers/std_profile_update_controller.dart';
import 'package:checkasync/models/user_entity_models.dart';
import 'package:checkasync/utiles/constant_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StdScreen extends GetView<StdProfileUpdateController> {
   StdScreen({Key? key}) : super(key: key);
  final UserEntityModels arg=Get.arguments;

   @override
  Widget build(BuildContext context) {

    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text("Student Panel"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-300,
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white54,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 10,),
                CircleAvatar(
                  child: Text(arg.name[0]),
                  backgroundColor: Colors.blue,
                  radius: 35,
                ),
                const SizedBox(height: 10,),

                Text("Name : ${arg.name}",style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                Text("Email : ${arg.email}",style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                Text("Department : ${arg.dpt}",style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),
                Text("RollNo : ${arg.rollNo}",style:const TextStyle(fontSize: 25,fontWeight: FontWeight.bold)),

              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(arg.name),
              accountEmail: Text(arg.email),
              currentAccountPicture: CircleAvatar(
                child: Text(arg.name[0],style: const TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              ),
            ),
            ListTile(
              title: const Text("Update Account"),
              onTap: (){
                Get.back();
                controller.giveControllerValues(arg.name, arg.pass, arg.email);

                Get.toNamed(
                    kStudentUpdateScreen,arguments: UserEntityModels(id: arg.id, name: arg.name, email: arg.email, pass: arg.pass, dpt: arg.dpt, rollNo: arg.rollNo)
                );
              },
            ),
            ListTile(
              title: const Text("LogOut"),
              onTap:(){
                Get.back();
                GetStorage().remove("email");
                Get.offNamedUntil(kLoginScreen, (route) => false);
              } ,
            )
          ],
        ),
      ),

    ));
  }
}

