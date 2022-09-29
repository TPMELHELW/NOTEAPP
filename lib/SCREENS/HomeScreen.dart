import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_4/AUTH/Login.dart';
import 'package:project_4/SCREENS/AddScreen.dart';
import 'package:project_4/SCREENS/EditScreen.dart';
import 'package:project_4/SCREENS/InfoScreen.dart';
import 'package:project_4/SCREENS/NoteView.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var noteref = FirebaseFirestore.instance.collection("notes");
  var userref = FirebaseFirestore.instance.collection("users");
  getUser() async {
    var user = await FirebaseAuth.instance.currentUser;
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          height: 30,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.bottomSheet(AddScreen());
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.to(() => InfoScreen());
            },
            icon: Icon(
              Icons.info,
              color: Colors.black,
            )),
        actions: [
          IconButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Get.off(Login());
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black,
            ),
          )
        ],
        elevation: 0,
        title: Text(
          "HOME SCREEN",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: noteref
            .where("userid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, i) {
                  return Dismissible(
                    onDismissed: (val) async {
                      await noteref.doc(snapshot.data!.docs[i].id).delete();
                      await FirebaseStorage.instance
                          .refFromURL(snapshot.data!.docs[i]["imageurl"])
                          .delete();
                    },
                    key: UniqueKey(),
                    child: ListNotes(
                      notes: snapshot.data!.docs[i],
                      docsid: snapshot.data!.docs[i].id,
                    ),
                  );
                });
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class ListNotes extends StatelessWidget {
  final notes;
  final docsid;
  const ListNotes({super.key, required this.notes, required this.docsid});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => NoteView(
              text: notes,
            ));
      },
      child: ListTile(
        subtitle: Text("${notes['note']}"),
        title: Text("${notes['title']}"),
        trailing: IconButton(
          onPressed: () {
            Get.to(
              () => EditScreen(
                docsid: docsid,
                text: notes,
              ),
            );
          },
          icon: Icon(Icons.edit),
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network("${notes['imageurl']}",
              width: 50, height: 50, fit: BoxFit.cover),
        ),
      ),
    );
  }
}
