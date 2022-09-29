import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:project_4/AUTH/Login.dart';
import 'package:project_4/SCREENS/HomeScreen.dart';

bool? isLogin;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    isLogin = false;
  } else {
    isLogin = true;
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF5EDDC),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF5EDDC),
          ),
        ),
        home: SplashScreen());
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 6)).then((value) {
      Get.offAll(isLogin == false ? Login() : const HomeScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset("images/2.png"),
          SpinKitThreeBounce(
            color: Colors.white,
            size: 50,
          )
        ]));
  }
}
