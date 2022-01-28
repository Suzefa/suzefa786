import 'package:checkasync/controllers/manage_dpt_controller.dart';
import 'package:checkasync/models/dpt_entity_model.dart';
import 'package:checkasync/utiles/constant_variable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageDptScreen extends GetView<ManageDptController> {
  const ManageDptScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Manage Dpt"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
          child: Column(
            children: [
              Center(
                child: TextField(
                  controller: controller.addDpt,
                  textInputAction: TextInputAction.done,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: "Add Dpt",
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.all(10),
                      ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: (){
                    if(controller.addDpt.text.isNotEmpty){
                      controller.addDptFromUI();
                    }else{
                      Get.snackbar("Field Error", "Fill Field First",colorText: Colors.white,backgroundColor: Colors.red);
                    }
                  },
                  child: const Text("Add Dpt"),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 350,
                padding: const EdgeInsets.all(10),
                child: Obx((){
                  return ListView(
                    children: [
                      for(DptEntityModel deM in controller.dptFromDb)
                        Center(
                          child: ListTile(
                            title: Text(deM.dptName),
                            trailing: Wrap(
                              spacing: 12,
                              children: [
                                IconButton(
                                  onPressed: (){
                                    controller.updateDpt(deM.dptName);
                                  },
                                  icon: const Icon(Icons.border_color),
                                ),
                                IconButton(
                                  onPressed: ()async{
                                    controller.deleteDptFromList(deM);
                                  },
                                  icon: const Icon(Icons.delete),
                                ),
                              ],
                            ),
                            onTap: (){
                              controller.fillDataDptWiseFromDb(deM.dptName);
                              Get.toNamed(kStudentOfDpt,arguments: DptEntityModel(id: deM.id, dptName: deM.dptName));
                            },
                          ),
                        ),
                    ],
                  );
                }),
              )
            ],
          ),
        ),
      ),
    ));
  }
}