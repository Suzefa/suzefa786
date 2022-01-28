import 'package:checkasync/controllers/login_controller.dart';
import 'package:checkasync/controllers/manage_dpt_controller.dart';
import 'package:checkasync/controllers/signup_controller.dart';
import 'package:checkasync/controllers/std_profile_update_controller.dart';
import 'package:get/get.dart';

class ControllerBindings implements Bindings{


  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<SignUpController>(() => SignUpController());
    Get.lazyPut<ManageDptController>(() => ManageDptController());
    Get.lazyPut<StdProfileUpdateController>(() => StdProfileUpdateController());

  }


}