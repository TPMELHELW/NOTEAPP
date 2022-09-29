import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("images/3.png"),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(30),
            child: Text(
              "YOU DON'T HAVE TO BE GREAT TO START , BUT YOU HAVE TO START TO BE GREAT",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: "elhelw0",
                  fontWeight: FontWeight.bold),
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                Text(
                  "DESIGNED BY: MAHMOUD ELHELW",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "elhelw0",
                      fontWeight: FontWeight.bold),
                ),
                Divider(
                  color: Colors.black,
                  thickness: 10,
                ),
                Text(
                  "VERSION : 1.0.0",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: "elhelw0",
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
          )
        ],
      ),
    );
  }
}
