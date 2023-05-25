import 'package:akbas_bas_eventfinderapp/Event1.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutterfire_ui/database.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:flutter/src/widgets/framework.dart';

class MusicPage extends StatefulWidget {
  final List<dynamic> events;

  MusicPage({required this.events});

  @override
  _MusicPageState createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  String _selectedCity = 'All';
  List<dynamic> _filteredEvents = [];

  double? _minPrice;
  double? _maxPrice;

  @override
  void initState() {
    super.initState();
    _filterEventsByCity();
  }

  void _filterEventsByCity() {
    if (_selectedCity == 'All') {
      setState(() {
        _filteredEvents = widget.events.toList();
      });
    } else {
      setState(() {
        _filteredEvents = widget.events
            .where((event) => event['city'] == _selectedCity)
            .toList();
      });
    }
  }

  double? _getNumericPrice(String price) {
    final numericPrice = price.replaceAll(RegExp('[^0-9.]'), '');
    return double.tryParse(numericPrice);
  }

  void _filterEventsByCityAndPrice() {
    if (_selectedCity == 'All') {
      setState(() {
        _filteredEvents = widget.events
            .where((event) =>
                (_minPrice == null ||
                    _getNumericPrice(event['price'])! >= _minPrice!) &&
                (_maxPrice == null ||
                    _getNumericPrice(event['price'])! <= _maxPrice!))
            .toList();
      });
    } else {
      setState(() {
        _filteredEvents = widget.events
            .where((event) =>
                event['city'] == _selectedCity &&
                (_minPrice == null ||
                    _getNumericPrice(event['price'])! >= _minPrice!) &&
                (_maxPrice == null ||
                    _getNumericPrice(event['price'])! <= _maxPrice!))
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
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Text(
                      "Music Events",
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
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: DropdownButton<String>(
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
                        color: Color.fromARGB(255, 132, 186, 229),
                      ),
                      dropdownColor: Colors.white,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Min Price',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _minPrice = double.tryParse(value);
                          _filterEventsByCityAndPrice();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Max Price',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          _maxPrice = double.tryParse(value);
                          _filterEventsByCityAndPrice();
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Expanded(
                child: _filteredEvents.isEmpty
                    ? Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.sentiment_dissatisfied,
                              size: 48,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              "Sorry, no results found.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView(
                        children: _filteredEvents
                            .map((dynamic item) => buildEvents(
                                  title: item["name"] ?? "",
                                  place: item["city"] ?? "",
                                  time: item["date"] ?? "",
                                  imageUrl: item["imageUrl"] ?? "",
                                  widget: EventPage(
                                    event: item,
                                  ),
                                  context: context,
                                ))
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
          image:
              DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
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
            ],
          ),
        ),
      ),
    ),
  );
}
