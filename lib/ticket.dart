import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:akbas_bas_eventfinderapp/payment.dart';
import 'package:localstorage/localstorage.dart';
import 'package:qr_flutter/qr_flutter.dart';

class TicketPage extends StatelessWidget {
  TicketPage({this.ticketCount});
  final ticketCount;
  final LocalStorage storage = LocalStorage('db');
  final userEmail = FirebaseAuth.instance.currentUser?.email;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: storage.ready,
      builder: (BuildContext context, snapshot) {
        if (snapshot.data == true) {
          Map<String, dynamic> data = storage.getItem('lastEvent') ?? {};
          print('kamil here');
          print(data);

          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildBackHome(
                        backHome: Icons.arrow_back,
                        widget: HomePage(),
                        context: context),
                    SizedBox(height: 24),
                    Text(
                      "Ticket",
                      style: TextStyle(
                        fontSize: 35,
                        color: Color(0xFF0A1034),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Name: ${data["name"]}',
                      style: TextStyle(
                        fontSize: 23,
                        color: Color(0xFF0A1034),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Date: ${data["date"]}',
                      style: TextStyle(
                        fontSize: 23,
                        color: Color(0xFF0A1034),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Time: ${data["time"]}',
                      style: TextStyle(
                        fontSize: 23,
                        color: Color(0xFF0A1034),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Place, location: ${data["place"]}, ${data["city"]}',
                      style: TextStyle(
                        fontSize: 23,
                        color: Color(0xFF0A1034),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    // userEmail != null &&
                    //         userEmail!.contains("@") &&
                    //         userEmail!
                    //             .split("@")[1]
                    //             .toLowerCase()
                    //             .contains("edu.tr")
                    //     ? Text(
                    //         'Total ticket price: $discountPayment ₺',
                    //         style: TextStyle(
                    //             fontSize: 23,
                    //             color: Color(0xFF0A1034),
                    //             fontWeight: FontWeight.w600),
                    //       )
                    //     : Text(
                    //         'Total ticket price: $totalPayment ₺',
                    //         style: TextStyle(
                    //             fontSize: 23,
                    //             color: Color(0xFF0A1034),
                    //             fontWeight: FontWeight.w600),
                    //       ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                      child: QrImageView(
                        data: '${data["name"].toString()+userEmail.toString()+ticketCount.toString()}',
                        version: QrVersions.auto,
                        size: 350.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
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
