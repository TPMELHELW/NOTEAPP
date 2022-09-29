import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoading(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("PLEASE WAIT"),
        content: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      );
    },
  );
}

//-----------------------------------------
//-----------------------------------------
class Helper extends GetxController {
  var email, password;
  GlobalKey<FormState> formstate = new GlobalKey<FormState>();
  signIn(context) async {
    var formData = formstate.currentState;
    if (formData!.validate()) {
      formData.save();
      try {
        showLoading(context);
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        return userCredential;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.back();
          AwesomeDialog(
              context: context,
              title: "ERROR",
              body: const Text(
                "No user found for that email.",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "elhelw"),
              )).show();
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Get.back();
          AwesomeDialog(
            context: context,
            title: "ERROR",
            body: const Text(
              "Wrong password provided for that user.",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "elhelw"),
            ),
          ).show();
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
