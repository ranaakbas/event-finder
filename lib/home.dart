import 'dart:ffi';
import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:akbas_bas_eventfinderapp/profile.dart';
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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:akbas_bas_eventfinderapp/cinema.dart';
import 'package:akbas_bas_eventfinderapp/theatre.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  List<dynamic> _events = [];

  Future<void> fetchEvents() async {
    final response = await http
        .get(Uri.parse("https://my-event-api.herokuapp.com/etkinlikler"));
    if (response.statusCode == 200) {
      // API'den veri başarıyla alındı
      final List<dynamic> events = json.decode(response.body);
      // events listesini kullanarak istediğiniz işlemleri yapabilirsiniz
      setState(() {
        _events = events;
      });
      print(
        events,
      );
    } else {
      // API'den veri alınırken bir hata oluştu
      throw Exception('API isteği başarısız oldu: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

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
                        SizedBox(width: 118),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchBar()),
                            );
                          },
                          child: Icon(
                            Icons.search,
                            color: Color(0xFF0A1034),
                            size: 30,
                          ),
                        ),
                        SizedBox(width: 20),
                        FirebaseAuth.instance.currentUser == null
                            ? InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MembershipPage()),
                                  );
                                },
                                child: Icon(
                                  Icons.person,
                                  color: Color(0xFF0A1034),
                                  size: 30,
                                ),
                              )
                            : InkWell(
                                onTap: () async {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProfilePage()),
                                  );
                                },
                                child: Icon(Icons.person,
                                    color: Color(0xFF0A1034), size: 30),
                              ),
                        SizedBox(width: 20),
                        Visibility(
                          visible: FirebaseAuth.instance.currentUser != null,
                          child: InkWell(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MembershipPage()),
                              );
                            },
                            child: Icon(
                              Icons.logout,
                              color: Color(0xFF0A1034),
                              size: 30,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //FILTER COLUMN2
                  //MOST PREFFERED COLUMN3-4

                  buildMostPreferredText(),
                  buildMostPreferred(),
                  // //UPCOMING EVENTS COLUMN5-6
                  buildUpcomingText(),
                  buildUpcoming(_events),
                  //
                  buildCategories(),

                  buildNavigation(
                    text: "Music",
                    widget: MusicPage(
                        events: _events
                            .where((event) => event['category'] == 'Music')
                            .toList()),
                    image: AssetImage('assets/images/music.jpg'),
                    context: context,
                  ),
                  buildNavigation(
                      text: "Art",
                      widget: ArtPage(
                          events: _events
                              .where((event) => event['category'] == 'Art')
                              .toList()),
                      image: AssetImage('assets/images/art.jpg'),
                      context: context),
                  buildNavigation(
                      text: "Cinema",
                      widget: CinemaPage(
                          events: _events
                              .where((event) => event['category'] == 'Movie')
                              .toList()),
                      image: AssetImage('assets/images/cinema.jpeg'),
                      context: context),
                  buildNavigation(
                      text: "Theatre",
                      widget: TheatrePage(
                          events: _events
                              .where((event) => event['category'] == 'Theatre')
                              .toList()),
                      image: AssetImage('assets/images/theatre.jpg'),
                      context: context),
                  buildNavigation(
                      text: "Sport",
                      widget: SportPage(
                          events: _events
                              .where((event) => event['category'] == 'Sport')
                              .toList()),
                      image: AssetImage('assets/images/sports.png'),
                      context: context),
                  buildNavigation(
                      text: "Education&More",
                      widget: EducationMorePage(
                          events: _events
                              .where(
                                  (event) => event['category'] == 'Education')
                              .toList()),
                      image: AssetImage('assets/images/education&more.jpg'),
                      context: context),
                  //  buildApi(context),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildTopButton(
    {required IconData icon,
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

Widget buildApi(_events) {
  return Scaffold(
    body: ListView.builder(
      itemCount: _events.length,
      itemBuilder: (BuildContext context, int index) {
        final event = _events[index];
        return ListTile(
          title: Text(event['name']),
          subtitle: Text(event['description']),
        );
      },
    ),
  );
}

Widget buildMostPreferredText() {
  return Padding(
    padding: EdgeInsets.only(top: 19),
    child: Text(
      "Most Preferred Events",
      style: TextStyle(
          color: Color(0xFF0A1034), fontSize: 25, fontWeight: FontWeight.bold),
    ),
  );
}

Widget buildMostPreferred() {
  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: 150.0,
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
            fontSize: 25,
            fontWeight: FontWeight.bold),
      ));
}

Widget buildUpcoming(_events) {
  List<dynamic> mostEvents = _events
      .where((event) => event['category'] == 'Coming')
      .toList(); // Sadece "Most" kategorisindeki etkinliklerin listesi

  return Column(
    children: [
      Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        height: 150.0,
        child: ListView.builder(
          // This next line does the trick.
          scrollDirection: Axis.horizontal,
          itemCount: mostEvents.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: 160.0,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: Card(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Image.network(
                        mostEvents[index]['imageUrl'],
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(mostEvents[index]['name']),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
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

Widget buildNavigation(
    {required String text,
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
              height: 130.0,
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
