import 'package:akbas_bas_eventfinderapp/music.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/src/widgets/framework.dart';

class EventPage extends StatelessWidget {
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
                  widget: MusicPage(),
                  context: context),
              SizedBox(height: 24),
              Text(
                "Duman Concert",
                style: TextStyle(
                  fontSize: 25,
                  color: Color(0xFF0A1034),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5),
                height: 200.0,
                padding: EdgeInsets.symmetric(horizontal: 19, vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  image: DecorationImage(
                      image: AssetImage("assets/images/duman.webp"),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 5,),
              Text(
                "Place: Harbiye Açık Hava Sahnesi",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF0A1034),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Date: 22.10.2023",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF0A1034),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20,),
              Text("Information",
                style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF0A1034),
                  fontWeight: FontWeight.bold,
                ),),
              Text(
                "You have to show your ticket when you're entering the place. You have to older than 18. You couldn't bring any food or drink.",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF272D4F),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 80,),
              Text(
                "Price: 500₺",
                style: TextStyle(
                  fontSize: 20,
                  color: Color(0xFF0A1034),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              InkWell(
                  onTap: () {},
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 100),
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF79709F), Color(0xFFB491CB)],
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
                  ))
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