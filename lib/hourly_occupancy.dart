import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //needed to customize the date picker
import 'package:table_calendar/table_calendar.dart';

class HourlyOccupancy extends StatefulWidget {
  const HourlyOccupancy({Key? key}) : super(key: key);

  @override
  _HourlyOccupancyState createState() => _HourlyOccupancyState();
}

class _HourlyOccupancyState extends State<HourlyOccupancy> {
  DateTime? selectedDate = DateTime.now();
  CalendarFormat calendarFormat = CalendarFormat.month;
  TextEditingController _calendarController = TextEditingController();
  bool showCalendar = false; // Added variable to control calendar visibility

  @override
  Widget build(BuildContext context) {
    return Material( // Wrap with Material widget
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Hourly Occupancy', style: TextStyle(fontSize: 30)),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Data for: ", style: TextStyle(fontSize: 20)),
                    Text(
                      selectedDate != null
                          ? DateFormat.yMMMd().format(selectedDate!)
                          : selectedDate.toString(),
                    ),
                    CupertinoButton(
                      padding: const EdgeInsets.only(left: 10),
                      onPressed: () {
                        setState(() {
                          showCalendar = !showCalendar;
                        });
                      },
                      child: const Icon(CupertinoIcons.calendar),
                    ),
                  ],
                ),
                if (showCalendar) // Show calendar only when showCalendar is true
                  TableCalendar(
                    calendarFormat: calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        selectedDate = selectedDay;
                        _calendarController.text =
                            DateFormat.yMMMd().format(selectedDate!);
                        showCalendar = false; // Hide calendar after a date is selected
                      });
                    },
                    focusedDay: selectedDate?.toUtc() ?? DateTime.now().toUtc(),
                    firstDay: DateTime.utc(2024, 1, 1),
                    lastDay: DateTime.utc(2024, 12, 31),
                  ),
                // rest of page content
              ],
            ),
          ),
        ),
      ),
    );
  }
}