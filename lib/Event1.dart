import 'package:akbas_bas_eventfinderapp/music.dart';
import 'package:akbas_bas_eventfinderapp/payment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:akbas_bas_eventfinderapp/ticket.dart';

class EventPage extends StatelessWidget {
  final dynamic event;

  EventPage({required this.event});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SafeArea(
            child: Stack(
              children: [
                Container(
                  height: screenHeight * 0.5,
                  padding: EdgeInsets.symmetric(horizontal: 19, vertical: 20),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(event["imageUrl"]),
                        fit: BoxFit.cover),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: screenHeight * 0.4),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                buildBackHome(
                                    backHome: Icons.arrow_back,
                                    widget: HomePage(),
                                    context: context,
                                category: event["category"]),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  event["name"],
                                  style: TextStyle(
                                    fontSize: 29,
                                    color: Color(0xFF0A1034),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Text(
                                  "Place: ${event["place"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF0A1034),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "City: ${event["city"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF0A1034),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Date: ${event["date"]}",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF0A1034),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Information",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color(0xFF0A1034),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "You have to show your ticket when you're entering the place. You have to older than 18. You couldn't bring any food or drink.",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF272D4F),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Text(
                                  "Price: ${event["price"]}",
                                  style: TextStyle(
                                    fontSize: 22,
                                    color: Color(0xFF0A1034),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 20),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PaymentPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 100),
                                    width: MediaQuery.of(context).size.width,
                                    height: 45,
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF70B0C5),
                                          Color(0xFF7ACE8C),
                                          Color(0xFFCBBC66),
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Buy Ticket",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildBackHome({
  required IconData backHome,
  required Widget widget,
  required BuildContext context,
  required String category,
}) {
  return GestureDetector(
    onTap: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => widget),
            (Route<dynamic> route) => route.isFirst,
      );
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
