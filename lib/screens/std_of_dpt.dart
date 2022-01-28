
import 'package:checkasync/controllers/manage_dpt_controller.dart';
import 'package:checkasync/models/user_entity_models.dart';
import 'package:checkasync/utiles/constant_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StdOfDpt extends GetView<ManageDptController> {
  StdOfDpt({Key? key}) : super(key: key);
  final arg= Get.arguments;


  @override
  Widget build(BuildContext context) {


    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Std Of ${arg.dptName}"),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(child: Obx(()=>Text("There Are ${controller.countStdDptWise} Student in ${arg.dptName}",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),))),
                  Container(
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height-200,
                    child: Obx(()=>ListView(
                      children: [
                        for(UserEntityModels ueM in controller.dptStd)
                          ListTile(
                            title: Text(ueM.name),
                            subtitle: Text(ueM.rollNo),
                            onTap: (){
                              Get.toNamed(kToViewStudentProfileScreen,arguments: ueM);
                            },
                            trailing: IconButton(onPressed: (){
                              controller.deleteStdFromStdDptList(ueM.id);
                            }, icon: const Icon(Icons.delete)),
                          ),
                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
