import 'dart:io';
import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_4/CONTROLLER/Helper3.dart';

class EditScreen extends StatelessWidget {
  final docsid;
  final text;

  const EditScreen({super.key, required this.docsid, required this.text});

  @override
  Widget build(BuildContext context) {
    Helper3 controller = Get.put(Helper3());
    return Scaffold(
      body: ListView(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                ),
                child: const Text(
                  "EDIT NOTES",
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
                  key: controller.formstate,
                  child: Column(
                    children: [
                      TextFormField(
                        initialValue: text['title'],
                        validator: (val) {
                          if (val!.length < 2) {
                            return "title is very short";
                          }
                          if (val.length > 50) {
                            return "title is very long";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          controller.title = val;
                        },
                        decoration: InputDecoration(
                          labelText: "TITLE",
                          prefixIcon: const Icon(Icons.text_fields),
                          // hintText: "TITLE",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        maxLength: 50,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        initialValue: text["note"],
                        validator: (val) {
                          if (val!.length < 3) {
                            return "note is very short";
                          }
                          if (val.length > 300) {
                            return " note is very long";
                          }
                          return null;
                        },
                        onSaved: (val) {
                          controller.body = val;
                        },
                        decoration: InputDecoration(
                          labelText: "BODY",
                          prefixIcon: const Icon(
                            Icons.telegram,
                          ),
                          // hintText: "BODY",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
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
                    controller.file = File(imagepick.path);
                    var ran = Random().nextInt(100000000);

                    var imagename = "$ran${basename(imagepick.path)}";
                    controller.ref =
                        FirebaseStorage.instance.ref("IMAGES/$imagename");
                  }
                },
                child: const Text("EDIT IMAGE"),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  await controller.editNote(context, docsid);
                },
                child: const Text("EDIT NOTES"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
