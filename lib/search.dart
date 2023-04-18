import 'dart:ffi';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:akbas_bas_eventfinderapp/music.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/art.dart';
import 'package:akbas_bas_eventfinderapp/sport.dart';
import 'package:akbas_bas_eventfinderapp/education&more.dart';
import 'package:flutter/foundation.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(
          margin: EdgeInsets.only(top: 25, left: 25, right: 25),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
              Row(
                children: [
                  Flexible(
                    flex: 1,
                    child: TextField(
                      controller: _searchController,
                      cursorColor: Colors.grey,
                      decoration: InputDecoration(
                        fillColor: Colors.black12,
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        prefixIcon: buildBackHome(icon: Icons.arrow_back, widget: HomePage(), context: context),

                      ),
                      onSubmitted: (value) {
                        // Perform search based on input
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ]),
    );
  }
}

Widget buildBackHome({
required IconData icon,
required Widget widget,
required BuildContext context}) {
  return GestureDetector(
  onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context) {
return widget;
}));
},
child: Container(
  padding: EdgeInsets.all(15),
  child: Icon(
  icon,
  size: 33,
  color: Color(0xFF0A1034),
  ),
  width: 18,
  ),);
}

