import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //needed to customize the date picker
import 'package:table_calendar/table_calendar.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:openrooms/get_firebase_data.dart';
import 'package:openrooms/utils.dart';

/// This file defines the `HourlyOccupancy` StatefulWidget, which displays hourly occupancy data
/// for a selected room. It utilizes the `TableCalendar` package for enabling users to pick a date,
/// and fetches occupancy data from Firebase for that date. The UI renders a list showing occupancy status for each hour
/// of the chosen day.

class HourlyOccupancy extends StatefulWidget {
  final String roomId;
  final FirebaseRoomService firebaseRoomService;

  const HourlyOccupancy(
      {super.key, required this.roomId, required this.firebaseRoomService});

  @override
  State<HourlyOccupancy> createState() => _HourlyOccupancyState();
}

class _HourlyOccupancyState extends State<HourlyOccupancy> {
  DateTime? selectedDate;
  CalendarFormat calendarFormat = CalendarFormat.month;
  //final TextEditingController _calendarController = TextEditingController();
  bool showCalendar = false; // Added variable to control calendar visibility
  Map<int, String>? occupancyData; // Variable to hold occupancy data
  StreamSubscription<Map<int, String>>? occupancyDataSubscription;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now().subtract(const Duration(days: 1));
    fetchOccupancyData(); // Fetch initial data for the current date
  }

  void fetchOccupancyData() {
    String formattedDate = DateFormat('yyyy-MM-dd').format(selectedDate!);

    // Cancel the previous subscription if it exists
    occupancyDataSubscription?.cancel();

    widget.firebaseRoomService
        .getOccupancyDataForDateAndRoom(formattedDate, widget.roomId)
        .listen((hourData) {
      if (mounted) {
        setState(() {
          occupancyData = hourData;
        });
      }
    }, onError: (error) {
      print("Error fetching occupancy data: $error");
    });
  }

  @override
  void dispose() {
    occupancyDataSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<ScatterSpot> spots = _generateSpotsFromData();
    final yesterday = DateTime.now().subtract(const Duration(days: 1));

    return Material(
        child: CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Hourly Occupancy', style: TextStyle(fontSize: 30)),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                // Your existing code for displaying the date picker...
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Data for: ",
                      style: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      selectedDate != null
                          ? DateFormat.yMMMd().format(selectedDate!)
                          : "Select a date",
                      style: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                        fontSize: 20,
                      ),
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
                if (showCalendar)
                  TableCalendar(
                    calendarFormat: calendarFormat,
                    selectedDayPredicate: (day) {
                      return isSameDay(selectedDate, day);
                    },
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        selectedDate = selectedDay;
                        showCalendar =
                            false; // Hide calendar after a date is selected
                        fetchOccupancyData(); // Fetch occupancy data for the new selected date
                      });
                    },
                    focusedDay: selectedDate ?? DateTime.now(),
                    firstDay: DateTime.utc(2024, 2, 16),
                    lastDay: yesterday,
                    calendarStyle: CalendarStyle(
                      selectedDecoration: const BoxDecoration(
                        color: CupertinoColors.activeBlue,
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible: false,
                      defaultTextStyle: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                      ),
                      weekendTextStyle: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                      ),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(
                        color: CupertinoColors.label.resolveFrom(context),
                      ),
                    ),
                  ),

                // Replace the ListView.builder with the scatter chart
                Container(
                  height: 1000,
                  padding: const EdgeInsets.all(20.0),
                  child: ScatterChart(
                    ScatterChartData(
                      scatterSpots: spots,
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            getTitlesWidget: (double value, TitleMeta meta) {
                              final hour = value.toInt();
                              final isPM = hour >= 12;
                              final formattedHour = isPM ? hour - 12 : hour;
                              final formattedTime =
                                  "${formattedHour == 0 ? 12 : formattedHour} ${isPM ? 'PM' : 'AM'}";
                              return SideTitleWidget(
                                axisSide: meta.axisSide,
                                space: 20.0, // Adjust the spacing as needed
                                child: Text(
                                  formattedTime,
                                  style: TextStyle(
                                    color: CupertinoColors.label
                                        .resolveFrom(context),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            },
                            reservedSize: 90,
                          ),
                        ),
                        bottomTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      gridData: const FlGridData(show: false),
                      scatterTouchData: ScatterTouchData(
                        enabled: false,
                      ),
                    ),
                    swapAnimationDuration: const Duration(milliseconds: 300),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'available':
        return CupertinoColors.activeGreen;
      case 'unavailable':
        return CupertinoColors.systemRed;
      case 'offline':
      default:
        return CupertinoColors.inactiveGray;
    }
  }

  List<ScatterSpot> _generateSpotsFromData() {
    return occupancyData?.keys.map((hour) {
          final status = occupancyData![hour]!;
          // Match the color based on the status
          final color = OccupancyUtils.getStatusColor(status);
          const radius = 8.0;
          const xValue =
              0.0; // Set a constant x-axis value since we are not using it
          // Create a new ScatterSpot with the given color and radius
          return ScatterSpot(
            xValue,
            hour.toDouble(), // Y value as the x-axis value for the horizontal line
            dotPainter: FlDotCirclePainter(color: color, radius: radius),
          );
        }).toList() ??
        [];
  }
}
