import 'package:checkasync/controllers/manage_dpt_controller.dart';
import 'package:checkasync/models/user_entity_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageStd extends GetView<ManageDptController> {
  const ManageStd({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text("All Student Here"),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(
                () => Text(
                    "\n\nThere are Total ${controller.countAllStd} Std in DB corresponding to different Dpt",
                    style: const TextStyle(
                      fontSize: 15,
                    )),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height-220,
                padding: const EdgeInsets.only(top: 20),
                child: Obx(() => ListView(
                      children: [
                        for (UserEntityModels userEntityModel
                            in controller.userFromDb)
                          ListTile(
                            title: Text(userEntityModel.name),
                            subtitle: Text(userEntityModel.rollNo),
                            onTap: () {},
                            trailing: IconButton(
                                icon: const Icon(Icons.delete), onPressed: () {
                                  controller.deleteStdFromDbAndList(userEntityModel.id);
                            }),
                          ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
