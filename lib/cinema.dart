import 'package:akbas_bas_eventfinderapp/Event1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/src/widgets/framework.dart';

class CinemaPage extends StatefulWidget {
  final List<dynamic> events;

  CinemaPage({required this.events});

  @override
  _CinemaPageState createState() => _CinemaPageState();
}

class _CinemaPageState extends State<CinemaPage> {
  String _selectedCity = "All";
  List<dynamic> _filteredEvents = [];

  @override
  void initState() {
    super.initState();
    _filterEventsByCity();
  }

  void _filterEventsByCity() {
    if (_selectedCity == "All") {
      setState(() {
        _filteredEvents = widget.events.toList();
      });
    } else {
      setState(() {
        _filteredEvents = widget.events
            .where((event) => event["city"] == _selectedCity)
            .toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding:
                    EdgeInsets.only(top: 29, left: 16, right: 16, bottom: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                      color: Color(0xFF70B0C5),
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
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Text(
                      "Movie Events",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(90, 89, 92, 0.91),
                        decoration: TextDecoration.none,
                      ),
                    ),
                    SizedBox(width: 36),
                  ],
                ),
              ),
              SizedBox(height: 16),
              DropdownButton<String>(
                value: _selectedCity,
                items: <String>[
                  'All',
                  'Adana',
                  'Adıyaman',
                  'Afyonkarahisar',
                  'Ağrı',
                  'Aksaray',
                  'Amasya',
                  'Ankara',
                  'Antalya',
                  'Ardahan',
                  'Artvin',
                  'Aydın',
                  'Balıkesir',
                  'Bartın',
                  'Batman',
                  'Bayburt',
                  'Bilecik',
                  'Bingöl',
                  'Bitlis',
                  'Bolu',
                  'Burdur',
                  'Bursa',
                  'Çanakkale',
                  'Çankırı',
                  'Çorum',
                  'Denizli',
                  'Diyarbakır',
                  'Düzce',
                  'Edirne',
                  'Elazığ',
                  'Erzincan',
                  'Erzurum',
                  'Eskişehir',
                  'Gaziantep',
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        value,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCity = newValue!;
                    _filterEventsByCity();
                  });
                },
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black87,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.blue,
                ),
                dropdownColor: Colors.white,
              ),
              Expanded(
                child: ListView(
                  children: _filteredEvents
                      .map((dynamic item) => buildEvents(
                          title: item["name"] ?? "",
                          place: item["city"] ?? "",
                          time: item["date"] ?? "",
                          imageUrl: item["imageUrl"] ?? "",
                          widget: EventPage(
                            event: item,
                          ),
                          context: context))
                      .toList(),
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
      ));
}

Widget buildEvents(
    {required String title,
    required String time,
    required String place,
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
              height: 155.0,
              padding: EdgeInsets.symmetric(horizontal: 19, vertical: 22),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                image: DecorationImage(
                    image: NetworkImage(imageUrl), fit: BoxFit.cover),
              ),
              child: Center(
                  child: Column(children: [
                SizedBox(
                  height: 15,
                ),
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  place,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 3,
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
