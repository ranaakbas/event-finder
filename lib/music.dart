import 'package:akbas_bas_eventfinderapp/Event1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/src/widgets/framework.dart';

class MusicPage extends StatelessWidget {
  final List<dynamic> events;

  MusicPage({required this.events});

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
              buildBackHome(
                  backHome: Icons.arrow_back,
                  widget: HomePage(),
                  context: context),
              SizedBox(height: 24),
              Text(
                "Music Events",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF0A1034),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                    children: events
                        .map((dynamic item) => buildEvents(
                            title: item?["name"] ?? "",
                            time: item?["time"] ?? "",
                            imageUrl: item?["imageUrl"] ??
                                "", // pass imageUrl parameter
                            widget: EventPage(
                              event: item,
                            ),
                            context: context))
                        .toList()),
              ),
            ],
          ),
        ),
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
      ));
}

Widget buildEvents(
    {required String title,
    required String time,
    required String imageUrl, // added imageUrl parameter
    required Widget widget,
    required BuildContext context}) {
  return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return widget;
        }));
      },
      child: Padding(
          padding: EdgeInsets.only(top: 10),
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              height: 130.0,
              padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover),
              ),
              child: Center(
                  child: Row(children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  time,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ])))));
}
