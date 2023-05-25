import 'package:akbas_bas_eventfinderapp/music.dart';
import 'package:akbas_bas_eventfinderapp/payment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:akbas_bas_eventfinderapp/ticket.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventPage extends StatefulWidget {
  final dynamic event;

  EventPage({required this.event});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int ticketCount = 1;

  void decrementTicketCount() {
    setState(() {
      if (ticketCount > 1) {
        ticketCount--;
      }
    });
  }

  void incrementTicketCount() {
    setState(() {
      if (ticketCount < 10) {
        ticketCount++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final userEmail = FirebaseAuth.instance.currentUser?.email;
    //final ticketPrice = event["price"];
    //final totalPrice = ticketCount * ticketPrice;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    var originalPriceString = event["price"].toString();
    var numericString = originalPriceString.replaceAll(RegExp(r'[^0-9]'), '');
    var originalPrice = double.parse(numericString);
    var discountedPrice = originalPrice * 0.8; // %20 indirim

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Stack(
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    userEmail != null &&
                                            userEmail.contains("@") &&
                                            userEmail
                                                .split("@")[1]
                                                .toLowerCase()
                                                .contains("edu.tr")
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Price: ",
                                                        style: TextStyle(
                                                          fontSize: 24,
                                                          color:
                                                              Color(0xFF0A1034),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        "${(event["price"])}",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                              Color(0xFF0A1034),
                                                          decoration:
                                                              TextDecoration
                                                                  .lineThrough,
                                                          decorationColor:
                                                              Colors.red,
                                                        ),
                                                      ),
                                                      SizedBox(width: 8),
                                                      Container(
                                                        padding: EdgeInsets
                                                            .symmetric(
                                                                horizontal: 8,
                                                                vertical: 4),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.green,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(6),
                                                        ),
                                                        child: Text(
                                                          "20% STUDENT OFF",
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 9),
                                                  Text(
                                                    "Discounted Price: $discountedPrice",
                                                    style: TextStyle(
                                                      fontSize: 24,
                                                      color: Colors.green,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(height: 5),
                                              // Rest of the code
                                            ],
                                          )
                                        : Text(
                                            //"$ticketPrice",
                                            "Price: ${(event["price"])}",
                                            style: TextStyle(
                                              fontSize: 24,
                                              color: Color(0xFF0A1034),
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        ElevatedButton(
                                          onPressed: (ticketCount > 1)
                                              ? () {
                                                  setState(() {
                                                    ticketCount--;
                                                  });
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            padding: EdgeInsets.all(16),
                                            primary: Color(0xFF98CBE0),
                                          ),
                                          child: Icon(Icons.remove),
                                        ),
                                        Text(
                                          '${ticketCount.toString()} ticket',
                                          style: TextStyle(
                                              fontSize: 23,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        ElevatedButton(
                                          onPressed: (ticketCount < 10)
                                              ? () {
                                                  setState(() {
                                                    ticketCount++;
                                                  });
                                                }
                                              : null,
                                          style: ElevatedButton.styleFrom(
                                            shape: CircleBorder(),
                                            padding: EdgeInsets.all(16),
                                            primary: Color(0xFFE5D788),
                                          ),
                                          child: Icon(Icons.add),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
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
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 100),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xFF70B0C5),
                                              Color(0xFF7ACE8C),
                                              Color(0xFFCBBC66),
                                            ],
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Buy Ticket",
                                            style: TextStyle(
                                                color: Colors.white,
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
          ],
        ),
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
