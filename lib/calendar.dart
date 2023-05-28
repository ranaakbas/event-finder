import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_calendar/flutter_clean_calendar.dart';
import 'package:akbas_bas_eventfinderapp/home.dart';
import 'package:http/http.dart' as http;
import 'package:akbas_bas_eventfinderapp/Event1.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<dynamic> _events = [];
  List<dynamic> filterEvent = [];
  DateTime _selectedDate = DateTime.now();
  List<DateTime> _eventDates = [];
  DateTime convertDateFormat(String dateStr) {
    String trimmedDateStr = dateStr.trim();
    List<String> dateParts = trimmedDateStr.split('.');
    int year = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[2]);
    DateTime parsedDate = DateTime(year, month, day);

    return parsedDate;
  }

  Future<void> fetchEvents() async {
    final response = await http
        .get(Uri.parse("https://my-event-api.herokuapp.com/etkinlikler"));
    if (response.statusCode == 200) {
      // API'den veri başarıyla alındı
      final List<dynamic> events = json.decode(response.body);
      // events listesini kullanarak istediğiniz işlemleri yapabilirsiniz
      setState(() {
        _events = events;
      });
      print(_events);
    } else {
      // API'den veri alınırken bir hata oluştu
      throw Exception('API isteği başarısız oldu: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now(); // Varsayılan olarak bugünü seçiyoruz
    fetchEvents();
  }

  void _handleDateSelected(DateTime date) {
    setState(() {
      _selectedDate = date;
      filterEvent = _events
          .where((event) =>
              convertDateFormat(event['date']).day == date.day &&
              convertDateFormat(event['date']).month == date.month &&
              convertDateFormat(event['date']).year == date.year)
          .toList();
    });
  }

  Widget _buildCalendarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            final previousMonth =
                DateTime(_selectedDate.year, _selectedDate.month - 1);
            _handleDateSelected(previousMonth);
          },
        ),
        Text(
          '${_selectedDate.year} - ${_selectedDate.month}',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: Icon(Icons.arrow_forward),
          onPressed: () {
            final nextMonth =
                DateTime(_selectedDate.year, _selectedDate.month + 1);
            _handleDateSelected(nextMonth);
          },
        ),
      ],
    );
  }

  Widget _buildCalendarDays() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('Mon'),
        Text('Tue'),
        Text('Wed'),
        Text('Thu'),
        Text('Fri'),
        Text('Sat'),
        Text('Sun'),
      ],
    );
  }

  Widget _buildCalendarGrid() {
    final daysInMonth =
        DateTime(_selectedDate.year, _selectedDate.month + 1, 0).day;
    final firstWeekday =
        DateTime(_selectedDate.year, _selectedDate.month, 1).weekday;
    final List<Widget> calendarDays = [];

    for (int i = 0; i < firstWeekday; i++) {
      calendarDays.add(Container());
    }

    for (int i = 1; i <= daysInMonth; i++) {
      final currentDate = DateTime(_selectedDate.year, _selectedDate.month, i);
      final isSelected = currentDate.day == _selectedDate.day;

      calendarDays.add(
        GestureDetector(
          onTap: () => _handleDateSelected(currentDate),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: isSelected ? Colors.blue : null,
            ),
            child: Center(
              child: Text(
                i.toString(),
                style: TextStyle(
                  color: isSelected ? Colors.white : null,
                  fontWeight: isSelected ? FontWeight.bold : null,
                ),
              ),
            ),
          ),
        ),
      );
    }

    return GridView.count(
      crossAxisCount: 7,
      children: calendarDays,
    );
  }

  Widget _buildEventList() {
    if (filterEvent.isEmpty) {
      return Text('No events found for the selected date.');
    }

    return Column(
      children: filterEvent.map((event) {
        final name = event['name'] ?? '';
        final imgUrl = event['imageUrl'] ?? '';
        final date = event['date'] ?? '';

        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventPage(event: event),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: imgUrl.isNotEmpty
                  ? Container(
                      width: 57,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue, // Çerçeve rengi burada belirlenir
                      ),
                      child: ClipOval(
                        child: Image.network(
                          imgUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  : null,
              title: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                date,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar'),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF70B0C5),
                Color(0xFF7ACE8C),
                Color(0xFFCBBC66),
              ], // İstediğiniz renkler burada belirlenir
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          _buildCalendarHeader(),
          _buildCalendarDays(),
          Expanded(
            child: _buildCalendarGrid(),
          ),
          Expanded(
            child: _buildEventList(),
          ),
        ],
      ),
    );
  }
}
