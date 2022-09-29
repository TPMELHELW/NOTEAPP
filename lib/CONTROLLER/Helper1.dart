import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_4/CONTROLLER/Get.dart';

class Helper1 extends GetxController {
  var username, email, password;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  signUp(context) async {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      formData.save();
      try {
        showLoading(context);
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "$email",
          password: "$password",
        );
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          Get.back();
          AwesomeDialog(
            context: context,
            title: "ERROR",
            body:const Text(
              "The password provided is too weak.",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "elhelw"),
            ),
          ).show();
        } else if (e.code == 'email-already-in-use') {
          Get.back();
          AwesomeDialog(
            context: context,
            title: "ERROR",
            body:const Text(
              "The account already exists for that email.",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "elhelw"),
            ),
          ).show();
        }
      } catch (e) {
        print(e);
      }
    } else {}
  }
}
