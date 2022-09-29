import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_4/AUTH/Login.dart';
import 'package:project_4/CONTROLLER/Helper1.dart';

class SignUp extends StatelessWidget {
  Helper1 controller = Get.put(Helper1());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Image.asset("images/3.png"),
              Form(
                key: controller.formstate,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextFormField(
                        onSaved: (val) {
                          controller.username = val;
                        },
                        validator: (val) {
                          if (val!.length > 20) {
                            return "USERNAME is very longer";
                          }
                          if (val.length < 4) {
                            return "USERNAME is very short";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          labelText: "USERNAME",
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onSaved: (val) {
                          controller.email = val;
                        },
                        validator: (val) {
                          if (val!.length > 50) {
                            return "EMAIL is very long";
                          }
                          if (val.length < 10) {
                            return "EMAIL is very short";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            // ignore: prefer_const_constructors
                            borderSide: BorderSide(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          labelText: "EMAIL",
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onSaved: (val) {
                          controller.password = val;
                        },
                        validator: (val) {
                          if (val!.length < 10) {
                            return "PASSWORD is very short";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(50)),
                          labelText: "PASSWORD",
                          prefixIcon: const Icon(Icons.password),
                        ),
                        obscureText: true,
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  UserCredential? responde = await controller.signUp(context);
                  if (responde != null) {
                    await FirebaseFirestore.instance.collection("users").add({
                      "username": controller.username,
                      "email": controller.email,
                      "password": controller.password,
                    });
                    Get.to(() => Login());
                  } else {
                    print("SIGN UP FAILED");
                  }
                },
                child: const Text("SIGN UP"),
              ),
              Container(
                margin: const EdgeInsets.only(top: 5),
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    const Text(
                      "if you have account click here",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => Login());
                      },
                      child: const Text("LOG IN"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
