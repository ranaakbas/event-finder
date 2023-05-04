import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:akbas_bas_eventfinderapp/membership.dart';
import 'package:akbas_bas_eventfinderapp/music.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/art.dart';
import 'package:akbas_bas_eventfinderapp/sport.dart';
import 'package:akbas_bas_eventfinderapp/education&more.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:akbas_bas_eventfinderapp/Event1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _searchController = TextEditingController();
  List<dynamic> _events = [];

  Future<void> fetchEvents(String category) async {
    final response = await http.get(Uri.parse(
        "https://my-event-api.herokuapp.com/etkinlikler?category=$category"));

    if (response.statusCode == 200) {
      // API'den veri başarıyla alındı
      final List<dynamic> events = json.decode(response.body);
      // events listesini kullanarak istediğiniz işlemleri yapabilirsiniz
      setState(() {
        _events = events;
      });
      print(events);
    } else {
      // API'den veri alınırken bir hata oluştu
      throw Exception('API isteği başarısız oldu: ${response.statusCode}');
    }
  }

  void search(String searchText) {
    if (searchText.isNotEmpty) {
      Timer(Duration(seconds: 2), () {
        fetchEvents(searchText);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 25, left: 25, right: 25),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
                Row(
                  children: [
                    buildBackHome(backHome: Icons.arrow_back, widget: HomePage(), context: context),
                    Flexible(
                      flex: 1,
                      child: TextField(
                        controller: _searchController,
                        cursorColor: Colors.grey,
                        decoration: InputDecoration(
                          fillColor: Colors.black12,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          hintText: "Search",
                          hintStyle: TextStyle(color: Colors.grey),
                        ),
                        onChanged: (searchText) {
                          search(searchText);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          _events != null
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: _events!.length,
                  itemBuilder: (context, index) {
                    final event = _events![index];
                    return ListTile(
                      title: Text(event['name']),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return EventPage(event: event);
                        }));
                      },
                    );
                  },
                )
              : Container(),
        ],
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
            size: 40,
          ),
        ],
      ));
}