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
  final usersQuery = FirebaseDatabase.instance.ref('users').orderByChild('nickName');

  // FirebaseDatabase database = FirebaseDatabase.instance;
  // // DatabaseReference ref = FirebaseDatabase.instance.ref("users/1");
  // final ref = FirebaseDatabase.instance.ref();
  // final snapshot = await ref.child('users/1').get();
  // if (snapshot.exists) {
  // print('ramazan');
  // print(snapshot.value);
  // } else {
  // print('No data available.');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //BAŞBİLET COLUMN1
              buildBasBilet(
                  iconPerson: Icons.person,
                  widget: MembershipPage(),
                  context: context),

              //FILTER COLUMN2
            FirebaseDatabaseListView(
              query: usersQuery,
              pageSize: 20,
              shrinkWrap: true,
              itemBuilder: (context, snapshot) {
                Map<String, dynamic> user = snapshot.value as Map<String, dynamic>;

                return Text('User name is}');
              },
            ),

              //MOST PREFFERED COLUMN3-4
              buildMostPreferredText(),
              buildMostPreferred(),
              //UPCOMING EVENTS COLUMN5-6
              buildUpcomingText(),
              buildUpcoming(),

              buildCategories(),
              //COLUMN 8 MUSIC ARTS
              buildMusicArts(
                  textMusic: "Music", textArts: "Arts", context: context),

              //COLUMN 9 SPORTS EDUCATION
              buildSportsMore(
                  textSports: "Sport", textMore: "More", context: context),
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
      padding: const EdgeInsets.only(top: 24.0, bottom: 10),
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

Widget buildMostPreferredText() {
  // final FirebaseDatabase firebaseDatabase;
  // final ref = FirebaseDatabase.instance.ref();
  // final snapshot = await ref.child('users/1').get();
  // if (snapshot.exists) {
  //   print(snapshot.value);
  // } else {
  //   print('No data available.');
  // }

  return Padding(
    padding: EdgeInsets.only(top: 27),
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
        height: 125.0,
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
        height: 125.0,
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
      padding: EdgeInsets.only(top: 35, bottom: 10),
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
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            height: 100.0,
            width: 160.0,
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
            decoration: BoxDecoration(
              color: Color(0xFFE0ECF8),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                textMusic,
                style: TextStyle(
                    color: Color(0xFF0A1034),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            height: 100.0,
            width: 160.0,
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
            decoration: BoxDecoration(
              color: Color(0xFFE0ECF8),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                textArts,
                style: TextStyle(
                    color: Color(0xFF0A1034),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
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
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            height: 100.0,
            width: 160.0,
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
            decoration: BoxDecoration(
              color: Color(0xFFE0ECF8),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                textSports,
                style: TextStyle(
                    color: Color(0xFF0A1034),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            height: 100.0,
            width: 160.0,
            padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
            decoration: BoxDecoration(
              color: Color(0xFFE0ECF8),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Text(
                textMore,
                style: TextStyle(
                    color: Color(0xFF0A1034),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
