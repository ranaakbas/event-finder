import 'dart:ffi';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:akbas_bas_eventfinderapp/profile.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:akbas_bas_eventfinderapp/Event1.dart';
import 'package:akbas_bas_eventfinderapp/ticket.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:localstorage/localstorage.dart';
import 'package:akbas_bas_eventfinderapp/verifycode.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PurchasesPage extends StatelessWidget {
  final userEmail = FirebaseAuth.instance.currentUser?.email;

  final LocalStorage storage = LocalStorage('db');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == true) {
          List<dynamic> tickets = storage.getItem('tickets') ?? {};
          print("tickets purchase");
          print(tickets);


          return Scaffold(
            body: ListView(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.only(
                              top: 29, left: 16, right: 16, bottom: 5),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              bottom: BorderSide(
                                color: Color.fromARGB(255, 211, 238, 244),
                                width: 2,
                              ),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF70B0C5),
                                      Color(0xFF7ACE8C),
                                      Color(0xFFCBBC66),
                                    ],
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                  ),
                                ),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    size: 20,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => ProfilePage(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Text(
                                "Purchases",
                                style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0A1034),
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              SizedBox(width: 36),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        tickets.isEmpty
                            ? Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 40,
                              ),
                              Icon(
                                Icons.sentiment_dissatisfied,
                                size: 48,
                                color: Colors.grey,
                              ),
                              SizedBox(height: 16),
                              Text(
                                "You have never bought a ticket before.",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        )
                            : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: tickets.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> ticket = tickets[index];

                            var originalPriceString = ticket['price'];
                            var numericString = originalPriceString
                                .replaceAll(RegExp(r'[^0-9]'), '');
                            var originalPrice =
                            double.parse(numericString);
                            var discountedPrice =
                                originalPrice * 0.8; // %20 indirim
                            final ticketCount = ticket['ticketCount'] != null
                                ? int.tryParse(ticket['ticketCount'])
                                : 1;

                            return Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: NetworkImage(ticket['imageUrl']),
                                  fit: BoxFit.cover,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            ticket['name'],
                                            style: TextStyle(
                                              color: Color(0xFF0A1034),
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '${ticket['date']}, ${ticket['time']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF0A1034),
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                          SizedBox(height: 10),
                                          Text(
                                            '${ticket['place']}, ${ticket['city']}',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xFF0A1034),
                                                fontWeight:
                                                FontWeight.w600),
                                          ),
                                          SizedBox(height: 10),
                                          userEmail != null &&
                                              userEmail!
                                                  .contains("@") &&
                                              userEmail!
                                                  .split("@")[1]
                                                  .toLowerCase()
                                                  .contains("edu.tr")
                                              ? Text(
                                            '${discountedPrice *
                                                ticketCount!} ₺',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(
                                                    0xFF0A1034),
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          )
                                              : Text(
                                            '${originalPrice *
                                                ticketCount!} ₺',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(
                                                    0xFF0A1034),
                                                fontWeight:
                                                FontWeight
                                                    .w600),
                                          ),
                                          QrImageView(
                                            data:
                                            '${ticket['name'] +
                                                userEmail.toString() +
                                                ticketCount.toString()}',
                                            version: QrVersions.auto,
                                            size: 100.0,
                                          ),
                                        ],
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white54,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

Widget buildBackHome({required IconData backHome,
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
