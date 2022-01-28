import 'package:checkasync/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

class SplashScreen extends GetView<LoginScreen> {

  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SplashScreenView(
          navigateRoute: const LoginScreen(),
          duration: 3000,
          imageSrc: "assets/images/logo.png",
          text: "Project School",
          textType: TextType.TyperAnimatedText,
          textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
