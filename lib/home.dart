import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nickNameText = "Hello";
  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void initState() {
    super.initState();
    activateListeners();
  }

  void activateListeners() {
    database.ref().child("users/1/nickName").onValue.listen((event) {
      final Object? value = event.snapshot.value;

      setState(() {
        nickNameText = "Hello $value";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference userRef = FirebaseDatabase.instance.ref("users/1");
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
                  buildBasBilet(
                      iconPerson: Icons.person,
                      widget: MembershipPage(),
                      context: context),

                  //FILTER COLUMN2
                  //MOST PREFFERED COLUMN3-4

                  buildNickNameText(nickNameText),
                  //
                  buildMostPreferredText(),
                  buildMostPreferred(),
                  // //UPCOMING EVENTS COLUMN5-6
                  buildUpcomingText(),
                  buildUpcoming(),
                  //
                  buildCategories(),
                  // //COLUMN 8 MUSIC ARTS
                  buildMusicArts(
                      textMusic: "Music", textArts: "Arts", context: context),

                  //COLUMN 9 SPORTS EDUCATION
                  buildSportsMore(
                      textSports: "Sport", textMore: "More", context: context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildBasBilet(
    {required IconData iconPerson,
    required Widget widget,
    required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return widget;
      }));
    },
    child: Padding(
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
          Padding(
            padding: EdgeInsets.only(left: 155),
            child: Icon(
              Icons.search,
              size: 33,
              color: Color(0xFF0A1034),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Icon(
              iconPerson,
              size: 33,
              color: Color(0xFF0A1034),
            ),
          )
        ],
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

Widget buildMusicArts(
    {required String textMusic,
    required String textArts,
    Widget? widget,
    required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return widget!;
        }),
      );
    },
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            height: 100.0,
            width: 160.0,
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                  image: AssetImage("assets/images/music.jpg"),
                  fit: BoxFit.cover),
            ),
            child:Center(
            child: Text(
              textMusic,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
            ),),
          ),),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            height: 100.0,
            width: 160.0,
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
            decoration: BoxDecoration(
              color: Color(0xFFE0ECF8),
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                  image: AssetImage("assets/images/arts.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Text(
                textArts,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget buildSportsMore(
    {required String textSports,
    required String textMore,
    Widget? widget,
    required BuildContext context}) {
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return widget!;
          },
        ),
      );
    },
    child: Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            height: 100.0,
            width: 160.0,
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
            decoration: BoxDecoration(
              color: Color(0xFFE0ECF8),
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                  image: AssetImage("assets/images/sports.png"),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Text(
                textSports,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
            height: 100.0,
            width: 160.0,
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
            decoration: BoxDecoration(
              color: Color(0xFFE0ECF8),
              borderRadius: BorderRadius.circular(6),
              image: DecorationImage(
                  image: AssetImage("assets/images/education&more.jpg"),
                  fit: BoxFit.cover),
            ),
            child: Center(
              child: Text(
                textMore,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
