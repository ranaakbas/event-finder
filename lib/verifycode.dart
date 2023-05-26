import 'package:akbas_bas_eventfinderapp/home.dart';
import 'dart:ffi';
import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:akbas_bas_eventfinderapp/profile.dart';
import 'package:akbas_bas_eventfinderapp/music.dart';
import 'package:akbas_bas_eventfinderapp/search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/services.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/art.dart';
import 'package:akbas_bas_eventfinderapp/sport.dart';
import 'package:akbas_bas_eventfinderapp/education&more.dart';
import 'package:flutter/foundation.dart';
import 'package:akbas_bas_eventfinderapp/search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:akbas_bas_eventfinderapp/cinema.dart';
import 'package:akbas_bas_eventfinderapp/theatre.dart';
import 'package:akbas_bas_eventfinderapp/Event1.dart';
import 'package:akbas_bas_eventfinderapp/ticket.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:email_otp/email_otp.dart';
import 'package:akbas_bas_eventfinderapp/payment.dart';
import 'package:localstorage/localstorage.dart';

class TicketObject {
  final String name;
  final String city;

  TicketObject(this.name, this.city);

  Map<String, dynamic> toJson() {
    return {'name': name, 'city': city};
  }

  factory TicketObject.fromJson(Map<String, dynamic> json) {
    return TicketObject(json['name'], json['city']);
  }
}

List<TicketObject> currentTickets = [];

// Save the array of objects to local storage
Future<void> saveArrayToLocalStorage() async {
  final storage = LocalStorage('db');

  await storage.setItem(
      'tickets', currentTickets.map((obj) => obj.toJson()).toList());
}

// Retrieve the array of objects from local storage
List<TicketObject> getArrayFromLocalStorage() {
  final storage = LocalStorage('db');
  List<dynamic>? storedArray = storage.getItem('tickets');
  if (storedArray != null) {
    return storedArray.map((json) => TicketObject.fromJson(json)).toList();
  } else {
    return [];
  }
}

class Otp extends StatelessWidget {
  const Otp({
    Key? key,
    required this.otpController,
  }) : super(key: key);
  final TextEditingController otpController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(20),
        ),
        width: 50,
        height: 50,
        child: TextFormField(
          controller: otpController,
          keyboardType: TextInputType.number,
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
            FilteringTextInputFormatter.digitsOnly
          ],
          onChanged: (value) {
            if (value.length == 1) {
              FocusScope.of(context).nextFocus();
            }
            if (value.isEmpty) {
              FocusScope.of(context).previousFocus();
            }
          },
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: (' '),
          ),
          onSaved: (value) {},
        ),
      ),
    );
  }
}

class OtpScreen extends StatefulWidget {
  OtpScreen({required this.myauth, this.ticketCount});

  final EmailOTP myauth;
  final ticketCount;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController otp1Controller = TextEditingController();
  TextEditingController otp2Controller = TextEditingController();
  TextEditingController otp3Controller = TextEditingController();
  TextEditingController otp4Controller = TextEditingController();

  String otpController = "1234";
  final LocalStorage storage = LocalStorage('db');
  var event;

  get ticketCount => ticketCount;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildBackHome(
                  backHome: Icons.arrow_back,
                  widget: HomePage(),
                  context: context),
              SizedBox(
                height: 170,
              ),
              Center(
                child: Text(
                  "Enter the code sent to your e-mail.",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF0A1034),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 45,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Otp(
                    otpController: otp1Controller,
                  ),
                  Otp(
                    otpController: otp2Controller,
                  ),
                  Otp(
                    otpController: otp3Controller,
                  ),
                  Otp(
                    otpController: otp4Controller,
                  ),
                ],
              ),
              SizedBox(
                height: 65,
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () async {
                    if (await widget.myauth.verifyOTP(
                            otp: otp1Controller.text +
                                otp2Controller.text +
                                otp3Controller.text +
                                otp4Controller.text) ==
                        true) {
                      final lastTicket = storage.getItem("lastEvent");

                      final oldTickets = getArrayFromLocalStorage();
                      print("oldTickets");
                      print(oldTickets);
                      if (currentTickets.isEmpty)
                        currentTickets.addAll(oldTickets);

                      currentTickets.add(TicketObject.fromJson(lastTicket));

                      saveArrayToLocalStorage();

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Payment received."),
                        ),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              TicketPage(ticketCount: widget.ticketCount),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Payment declined."),
                      ));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.all(10),
                    backgroundColor: Color(0xFF70B0C5),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60),
                    child: Text(
                      "Confirm",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
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
    ),
  );
}
