
import 'package:checkasync/utiles/controller_bindings.dart';
import 'package:checkasync/utiles/route_generator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
      ]
  );

  await GetStorage.init();


  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    smartManagement: SmartManagement.full,
    initialBinding: ControllerBindings(),
    initialRoute: '/Splash_Screen',
    getPages: RouteGenerator.getPages() ,
  ));
}