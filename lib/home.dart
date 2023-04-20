import 'dart:ffi';
import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:akbas_bas_eventfinderapp/music.dart';
import 'package:akbas_bas_eventfinderapp/search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/art.dart';
import 'package:akbas_bas_eventfinderapp/sport.dart';
import 'package:akbas_bas_eventfinderapp/education&more.dart';
import 'package:flutter/foundation.dart';
import 'package:akbas_bas_eventfinderapp/search.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //BAŞBİLET COLUMN1
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, bottom: 3),
                    child: Row(
                      children: [
                        Text(
                          "BaşBilet",
                          style: TextStyle(
                            fontSize: 30,
                            color: Color(0xFF0A1034),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 130),
                        buildTopButton(
                            icon: Icons.search,
                            widget: SearchBar(),
                            context: context),
                        buildTopButton(
                            icon: Icons.person,
                            widget: MembershipPage(),
                            context: context),
                      ],
                    ),
                  ),


                  //FILTER COLUMN2
                  //MOST PREFFERED COLUMN3-4

                  buildMostPreferredText(),
                  buildMostPreferred(),
                  // //UPCOMING EVENTS COLUMN5-6
                  buildUpcomingText(),
                  buildUpcoming(),
                  //
                  buildCategories(),

                  buildNavigation(
                      text: "Music",
                      widget: MusicPage(),
                      image: AssetImage('assets/images/music.jpg'),
                      context: context),
                  buildNavigation(
                      text: "Art",
                      widget: ArtPage(),
                      image: AssetImage('assets/images/arts.jpg'),
                      context: context),
                  buildNavigation(
                      text: "Sport",
                      widget: SportPage(),
                      image: AssetImage('assets/images/sports.png'),
                      context: context),
                  buildNavigation(
                      text: "Education&More",
                      widget: EducationMorePage(),
                      image: AssetImage('assets/images/education&more.jpg'),
                      context: context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTopButton({required IconData icon,
  required Widget widget,
  required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return widget;
      }));
    },
    child: Padding(
      padding: EdgeInsets.only(left: 20),
      child: Icon(
        icon,
        size: 33,
        color: Color(0xFF0A1034),
      ),
    ),
  );
}

Widget buildNickNameText(nickNameText) {
  return Padding(
    padding: EdgeInsets.only(top: 10),
    child: Text(
      nickNameText,
      style: TextStyle(
          color: Color(0xFF0A1034), fontSize: 19, fontWeight: FontWeight.bold),
    ),
  );
}

Widget buildMostPreferredText() {
  return Padding(
    padding: EdgeInsets.only(top: 19),
    child: Text(
      "Most Preferred Events",
      style: TextStyle(
          color: Color(0xFF0A1034), fontSize: 18, fontWeight: FontWeight.bold),
    ),
  );
}

Widget buildMostPreferred() {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: 110.0,
        child: ListView(
          // This next line does the trick..
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 160.0,
              color: Colors.red,
            ),
            Container(
              width: 160.0,
              color: Colors.blue,
            ),
            Container(
              width: 160.0,
              color: Colors.green,
            ),
            Container(
              width: 160.0,
              color: Colors.yellow,
            ),
            Container(
              width: 160.0,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildUpcomingText() {
  return Padding(
      padding: EdgeInsets.only(top: 15),
      child: Text(
        "Upcoming Events",
        style: TextStyle(
            color: Color(0xFF0A1034),
            fontSize: 18,
            fontWeight: FontWeight.bold),
      ));
}

Widget buildUpcoming() {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: 110.0,
        child: ListView(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 160.0,
              color: Colors.red,
            ),
            Container(
              width: 160.0,
              color: Colors.blue,
            ),
            Container(
              width: 160.0,
              color: Colors.green,
            ),
            Container(
              width: 160.0,
              color: Colors.yellow,
            ),
            Container(
              width: 160.0,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    ],
  );
}

Widget buildCategories() {
  return Padding(
      padding: EdgeInsets.only(top: 15, bottom: 10),
      child: Text(
        "Categories",
        style: TextStyle(
            color: Color(0xFF0A1034),
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ));
}

Widget buildNavigation({required String text,
  required Widget widget,
  required ImageProvider image,
  required BuildContext context}) {
  return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return widget;
          }),
        );
      },
      child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              height: 90.0,
              padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(image: image, fit: BoxFit.cover),
              ),
              child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  )))));
}
