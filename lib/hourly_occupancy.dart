import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //needed to customize the date picker
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
//import 'package:firebase_database/firebase_database.dart';

// class HourlyOccupancy extends StatefulWidget {
//   const HourlyOccupancy({super.key});

//   @override
//   State<HourlyOccupancy> createState() => _HourlyOccupancyState();
// }

// class _HourlyOccupancyState extends State<HourlyOccupancy> {
//   DateTime? selectedDate = DateTime.now();
//   CalendarFormat calendarFormat = CalendarFormat.month;
//   final TextEditingController _calendarController = TextEditingController();
//   bool showCalendar = false; // Added variable to control calendar visibility

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       // Wrap with Material widget
//       child: CupertinoPageScaffold(
//         navigationBar: const CupertinoNavigationBar(
//           middle: Text('Hourly Occupancy', style: TextStyle(fontSize: 30)),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.only(top: 30),
//             child: Column(
//               children: [
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Data for: ",
//                       style: TextStyle(
//                         color: CupertinoColors.label.resolveFrom(context),
//                         fontSize: 20,
//                       ),
//                     ),
//                     Text(
//                         selectedDate != null
//                             ? DateFormat.yMMMd().format(selectedDate!)
//                             : selectedDate.toString(),
//                         style: TextStyle(
//                           color: CupertinoColors.label.resolveFrom(context),
//                           fontSize: 20,
//                         )),
//                     CupertinoButton(
//                       padding: const EdgeInsets.only(left: 10),
//                       onPressed: () {
//                         setState(() {
//                           showCalendar = !showCalendar;
//                         });
//                       },
//                       child: const Icon(CupertinoIcons.calendar),
//                     ),
//                   ],
//                 ),
//                 if (showCalendar) // Show calendar only when showCalendar is true
//                   TableCalendar(
//                     calendarFormat: calendarFormat,
//                     selectedDayPredicate: (day) {
//                       return isSameDay(selectedDate, day);
//                     },
//                     onDaySelected: (selectedDay, focusedDay) {
//                       setState(() {
//                         selectedDate = selectedDay;
//                         _calendarController.text =
//                             DateFormat.yMMMd().format(selectedDate!);
//                         showCalendar =
//                             false; // Hide calendar after a date is selected
//                       });
//                     },
//                     focusedDay: selectedDate?.toUtc() ?? DateTime.now().toUtc(),
//                     firstDay: DateTime.utc(2024, 1, 1),
//                     lastDay: DateTime.utc(2024, 12, 31),
//                     calendarStyle: CalendarStyle(
//                       defaultTextStyle: TextStyle(
//                         color: CupertinoColors.label.resolveFrom(context),
//                       ),
//                       weekendTextStyle: TextStyle(
//                         color: CupertinoColors.label.resolveFrom(context),
//                       ),
//                       selectedDecoration: const BoxDecoration(
//                         color: CupertinoColors.activeBlue,
//                         shape: BoxShape.circle,
//                       ),
//                     ),
//                     headerStyle: HeaderStyle(
//                         formatButtonVisible: false,
//                         titleCentered: true,
//                         titleTextStyle: TextStyle(
//                             color: CupertinoColors.label.resolveFrom(context))),
//                   ),
//                 // rest of page content
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class HourlyOccupancy extends StatefulWidget {
  const HourlyOccupancy({Key? key}) : super(key: key);

  @override
  State<HourlyOccupancy> createState() => _HourlyOccupancyState();
}

class _HourlyOccupancyState extends State<HourlyOccupancy> {
  DateTime? selectedDate = DateTime.now();
  final TextEditingController _calendarController = TextEditingController();
  bool showCalendar = false; // Added variable to control calendar visibility

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Hourly Occupancy'),
        ),
        child: SafeArea(
          child: HeatMapCalendar(
            defaultColor: Colors.white,
            flexible: true,
            colorMode: ColorMode.color,
            datasets: {
              DateTime(2021, 1, 6): 3,
              DateTime(2021, 1, 7): 7,
              DateTime(2021, 1, 8): 10,
              DateTime(2021, 1, 9): 13,
              DateTime(2021, 1, 13): 6,
            },
            colorsets: const {
              1: Colors.red,
              3: Colors.orange,
              5: Colors.yellow,
              7: Colors.green,
              9: Colors.blue,
              11: Colors.indigo,
              13: Colors.purple,
            },
            onClick: (value) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(value.toString())));
            },
          ),
        ),
      ),
    );
  }
}
