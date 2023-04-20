// import 'dart:ffi';
// import 'dart:html';
// import 'dart:ui';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/material.dart';
import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:firebase_core/firebase_core.dart'; //core
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart'; //auth
import 'package:cloud_firestore/cloud_firestore.dart'; //cloud firestore
import 'package:firebase_database/firebase_database.dart'; // realtime


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //  options: DefaultFirebaseOptions.currentPlatform,);

  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initlization= Firebase.initializeApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: "Event Finder",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: FutureBuilder(
        future: _initlization,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return Center(child: Text('SOMETHING WENT WRONG!'),);
          } else if (snapshot.hasData){
            return HomePage();
          } else {
            return Center(child: CircularProgressIndicator(),);
          }

        },
      )
    );
  }
}
