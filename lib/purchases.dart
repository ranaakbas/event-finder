import 'dart:ffi';
import 'package:akbas_bas_eventfinderapp/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:akbas_bas_eventfinderapp/Event1.dart';
import 'package:akbas_bas_eventfinderapp/ticket.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:akbas_bas_eventfinderapp/verifycode.dart';

class PurchasesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LocalStorage storage = LocalStorage('db');
    final sondurum = getArrayFromLocalStorage();
    return Scaffold(
      body: ListView(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildBackHome(
                      backHome: Icons.arrow_back,
                      widget: ProfilePage(),
                      context: context),
                  SizedBox(height: 20),
                  Text(
                    "Purchases",
                    style: TextStyle(
                      fontSize: 25,
                      color: Color(0xFF0A1034),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

    Text('${sondurum.map((obj) => obj.toJson()).toList()}'),



    // print(sondurum.map((obj) => obj.toJson()).toList());

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildBackHome(
    {required IconData backHome,
      required Widget widget,
      required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return widget;
      }));
    },
    child: Column(
      children: [
        SizedBox(height: 29),
        Icon(
          backHome,
          color: Colors.black,
          size: 50,
        ),
      ],
    ),
  );
}
