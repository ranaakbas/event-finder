// import 'dart:ffi';
// import 'dart:html';
// import 'dart:ui';
import 'package:firebase_database/firebase_database.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/material.dart';
import 'package:postgres/postgres.dart';
import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());

}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
