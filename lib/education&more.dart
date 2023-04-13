import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/src/widgets/framework.dart';

class EducationMorePage extends StatelessWidget {
  final List<String> events = [
    "Education&MoreEvent1",
    "Education&MoreEvent2",
    "Education&MoreEvent3",
    "Education&MoreEvent4",
    "Education&MoreEvent5",
    "Education&MoreEvent6",
  ];

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
                "Art Events",
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
                        .map((String title) => buildEvents(title: title))
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

Widget buildEvents({required String title}) {
  return Container(
    padding: EdgeInsets.all(50),
    margin: EdgeInsets.only(bottom: 16),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Color(0xFFC7D8F6FF),
      borderRadius: BorderRadius.circular(6),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.25),
          blurRadius: 4,
          offset: Offset(0, 4),
        ),
      ],
    ),
    child: Text(title),
  );
}
