import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class HourlyOccupancy extends StatefulWidget {
  const HourlyOccupancy({super.key});

  @override
  State<HourlyOccupancy> createState() => _HourlyOccupancy();
}

class _HourlyOccupancy extends State<HourlyOccupancy> {
  //HourlyOccupancy({Key? key}) : super(key: key) {}
  DateTime? selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: const CupertinoNavigationBar(
          middle: Text('Hourly Occupancy', style: TextStyle(fontSize: 30)),
        ),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30), //Adjust top padding as needed
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Data for:  ", style: TextStyle(fontSize: 20)),
                    Text(selectedDate != null
                        ? DateFormat.yMMMd().format(selectedDate!)
                        : selectedDate.toString()),
                    CupertinoButton(
                      padding:
                          const EdgeInsets.only(left: 10), //Optional spacing
                      onPressed: () => showDatePopup(context),
                      child: const Icon(CupertinoIcons.calendar),
                    ),
                  ],
                ),
                //rest of page content
              ],
            ),
          ),
        ));
  }

  Future<DateTime?> showDatePopup(BuildContext context) async {
    return showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (context) => Container(
        child: CupertinoDatePicker(
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (selectedDateTime) {
            setState(() {
              selectedDate = selectedDateTime;
            });
          },
          //other date picker customizations
        ),
      ),
    );
  }
}
