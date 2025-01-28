import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  Map<DateTime, List<String>> events = {};
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  final TextEditingController _eventController = TextEditingController();

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  void _addEvent() {
    if (_eventController.text.isEmpty) return;

    if (events[selectedDay] != null) {
      events[selectedDay]!.add(_eventController.text);
    } else {
      events[selectedDay] = [_eventController.text];
    }

    _eventController.clear();
    Navigator.pop(context);
    setState(() {});
  }

  List<String> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
        backgroundColor: const Color(0xFF4A4590), // Purple color
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: focusedDay,
            firstDay: DateTime(2000),
            lastDay: DateTime(2100),
            selectedDayPredicate: (day) => isSameDay(selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
                this.focusedDay = focusedDay;
              });
            },
            calendarStyle: const CalendarStyle(
              selectedDecoration: BoxDecoration(
                color: Color(0xFF4A4590), // Purple color for selected day
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: Color(0xFFFBF2E9), // Beige color for today's date
                shape: BoxShape.circle,
              ),
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
          ),
          ..._getEventsForDay(selectedDay).map((event) => ListTile(
                title: Text(event),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF4A4590), // Purple floating button
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Add Event'),
            content: TextField(
              controller: _eventController,
              decoration: const InputDecoration(hintText: 'Enter event'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: _addEvent,
                child: const Text('Add'),
              ),
            ],
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
