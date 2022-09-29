import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_4/AUTH/SignUp.dart';
import 'package:project_4/CONTROLLER/Get.dart';
import 'package:project_4/SCREENS/HomeScreen.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Helper controller = Get.put(Helper());
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: controller.formstate,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset("images/3.png"),
                      TextFormField(
                        onSaved: (val) {
                          controller.email = val;
                        },
                        validator: (val) {
                          if (val!.length < 10) {
                            return "EMAIL is very short";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          labelText: "EMAIL",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        onSaved: (val) {
                          controller.password = val;
                        },
                        validator: (val) {
                          if (val!.length < 5) {
                            return "PASSWORD is very short";
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "PASSWORD",
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(width: 1),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          prefixIcon: const Icon(Icons.password_outlined),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  var user = await controller.signIn(context);
                  if (user != null) {
                    Get.offAll(() => const HomeScreen());
                  }
                },
                child: const Text("LOG IN"),
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
                      "if you havn't account click here",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.offAll(() => SignUp());
                      },
                      child: const Text("SIGN UP"),
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
