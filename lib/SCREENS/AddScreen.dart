import 'dart:io';
import 'dart:math';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_4/CONTROLLER/Get.dart';
import 'package:project_4/SCREENS/HomeScreen.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  CollectionReference noteref = FirebaseFirestore.instance.collection("notes");
  File? file;
  addNote(context) async {
    if (file == null) {
      return AwesomeDialog(
              context: context,
              title: "ERROR",
              body: const Text(
                "PLEASE ADD IMAGE",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "elhelw"),
              ),
              dialogType: DialogType.error)
          .show();
    }
    var formdata = formstate.currentState;
    if (formdata!.validate()) {
      showLoading(context);
      formdata.save();
      await ref.putFile(file!);
      imageURL = await ref.getDownloadURL();
      await noteref.add({
        "title": title,
        "note": body,
        "imageurl": imageURL,
        "userid": FirebaseAuth.instance.currentUser?.uid,
      });
      Get.offAll(() => HomeScreen());
    }
  }

  var title, body, imageURL, ref;
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(50)),
              child: const Text(
                "ADD NOTES",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (val) {
                        if (val!.length < 2) {
                          return "title is very short";
                        }
                        if (val.length > 50) {
                          return "title is very long";
                        }
                      },
                      onSaved: (val) {
                        title = val;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        labelText: "TITLE",
                        prefixIcon: Icon(Icons.text_fields),
                        // hintText: "TITLE",
                      ),
                      maxLength: 50,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      // style: TextStyle(color: Colors.white),
                      validator: (val) {
                        if (val!.length < 3) {
                          return "note is very short";
                        }
                        if (val.length > 300) {
                          return " note is very long";
                        }
                      },
                      onSaved: (val) {
                        body = val;
                      },
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        labelText: "NOTE",
                        prefixIcon: Icon(Icons.note),
                        // hintText: "TITLE",
                      ),
                      maxLength: 1000,
                      maxLines: null,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                var imagepick =
                    await ImagePicker().pickImage(source: ImageSource.gallery);

                if (imagepick != null) {
                  file = File(imagepick.path);
                  var ran = Random().nextInt(100000000);

                  var imagename = "$ran" + basename(imagepick.path);
                  ref = FirebaseStorage.instance.ref("IMAGES/$imagename");
                }
              },
              child: Text("ADD IMAGE"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                await addNote(context);
              },
              child: const Text("ADD NOTES"),
            ),
          ],
        ),
      ],
    );
  }
}
