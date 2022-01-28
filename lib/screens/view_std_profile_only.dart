
import 'package:checkasync/models/user_entity_models.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewStdProfileOnly extends StatelessWidget {
  ViewStdProfileOnly({Key? key}) : super(key: key);
  final UserEntityModels argument=Get.arguments;

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: const Text("Std Profile View"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding:const EdgeInsets.only(top: 20,left: 10,right: 10),
        child: ListView(
          children: [
            const SizedBox(height: 20,),
            const Center(child: Text('You can only view Profile Detail here For Update Please goto Manage Std Section.'),),
            const SizedBox(height: 10,),
            const Text("Name:"),
            TextField(
              enabled: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: argument.name,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
              ),
            ),

            const SizedBox(height: 10,),
            const Text("Email:"),
            TextField(
              enabled: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: argument.email,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
              ),
            ),


            const SizedBox(height: 10,),
            const Text("Department:"),
            TextField(
              enabled: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: argument.dpt,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
              ),
            ),

            const SizedBox(height: 10,),
            const Text("Roll number:"),
            TextField(
              enabled: false,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: argument.rollNo,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.all(10),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
