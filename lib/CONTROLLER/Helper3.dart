import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_4/CONTROLLER/Get.dart';
import 'package:project_4/SCREENS/HomeScreen.dart';

class Helper3 extends GetxController {
  CollectionReference noteref = FirebaseFirestore.instance.collection("notes");
  File? file;
  editNote(context, docsid) async {
    var formdata = formstate.currentState;

    if (file == null) {
      if (formdata!.validate()) {
        showLoading(context);
        formdata.save();
        await noteref.doc(docsid).update({
          "title": title,
          "note": body,
        });
        Get.offAll(() =>const HomeScreen());
      }
    } else {
      if (formdata!.validate()) {
        showLoading(context);
        formdata.save();
        await ref.putFile(file!);
        imageURL = await ref.getDownloadURL();
        await noteref.doc(docsid).update({
          "title": title,
          "note": body,
          "imageurl": imageURL,
        });
        Get.offAll(() =>const HomeScreen());
      }
    }
  }

  var title, body, imageURL, ref;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
}
