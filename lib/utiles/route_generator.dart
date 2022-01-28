import 'package:checkasync/screens/admin_screen.dart';
import 'package:checkasync/screens/login_screen.dart';
import 'package:checkasync/screens/manage_dpt_screen.dart';
import 'package:checkasync/screens/manage_std.dart';
import 'package:checkasync/screens/signup_screen.dart';
import 'package:checkasync/screens/spalsh_screen.dart';
import 'package:checkasync/screens/std_of_dpt.dart';
import 'package:checkasync/screens/std_profile_update.dart';
import 'package:checkasync/screens/std_screen.dart';
import 'package:checkasync/screens/view_std_profile_only.dart';
import 'package:checkasync/utiles/constant_variable.dart';
import 'package:get/get.dart';

class RouteGenerator {

  static List<GetPage> getPages() {
    return [
      GetPage(name: kSplashScreen, page: () => const SplashScreen()),
      GetPage(name: kLoginScreen, page: () => const LoginScreen()),
      GetPage(name: kSignUpScreen, page: () => const SignUpScreen()),


      GetPage(name: kAdminScreen, page: () => const AdminScreen()),
      GetPage(name: kManageDptScreen, page: () => const ManageDptScreen()),
      GetPage(name: kStudentOfDpt, page: () => StdOfDpt()),
      GetPage(name: kManageStdScreen, page: () => const ManageStd()),

      GetPage(name: kStudentScreen, page: () => StdScreen()),
      GetPage(name: kStudentUpdateScreen, page: () => StdProfileUpdate()),

      GetPage(name: kToViewStudentProfileScreen, page: () => ViewStdProfileOnly()),
    ];
  }
}

