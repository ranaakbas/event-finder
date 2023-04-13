import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/src/widgets/framework.dart';

class MusicPage extends StatelessWidget{
  const MusicPage({super.key});

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
        child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Text('Music'),)
    ),);
  }
}