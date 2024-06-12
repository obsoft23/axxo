// ignore_for_file: prefer_const_constructors, unused_import, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:vixo/theme/constants.dart';
import 'package:vixo/theme/theme.dart';
import 'package:vixo/view/pages/add_event_reminder.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reminder & Events'),
        backgroundColor: Colors.transparent,
        elevation: 0, // Removes the shadow below the AppBar
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16.0), // Margin for spacing
            child: IconButton(
              icon: Icon(Icons.list),
              color: kDefaultIconDarkColor,
              iconSize: 30.0,
              onPressed: () {
                // Add your onPressed code here!
                showCupertinoModalBottomSheet(
                  context: context,
                  builder: (context) => Container(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff03dac6),
        foregroundColor: Colors.black,
        onPressed: () {
          // Respond to button press
          Get.to(() => AddEventPage());
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Obx(
              () => TableCalendar(
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                weekNumbersVisible: true,
                focusedDay: calendarController.focusedDay.value,
                calendarFormat: calendarController.calendarFormat.value,
                daysOfWeekVisible: true,
                rangeEndDay: DateTime.now(),
                selectedDayPredicate: (day) {
                  return isSameDay(calendarController.selectedDay.value, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  calendarController.onDaySelected(selectedDay, focusedDay);
                },
                onFormatChanged: (format) {
                  calendarController.onFormatChanged(format);
                },
                onPageChanged: (focusedDay) {
                  calendarController.onPageChanged(focusedDay);
                },
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: const [
                Spacer(),
                Text("-----   "),
                Text(
                  'Upcoming Events',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  ),
                ),
                Text("    -----"),
                Spacer(),
              ],
            ),
            SizedBox(height: 8.0),
            // List of upcoming events goes here
            ListTile(
              title: Text('Event 1 - Tomorrow'),
              subtitle: Text('Location: ...'),
              onTap: () {
                // Handle tapping on the event
              },
            ),
            ListTile(
              title: Text('Event 2 - Next Week'),
              subtitle: Text('Location: ...'),
              onTap: () {
                // Handle tapping on the event
              },
            ),
            ListTile(
              title: Text('Event 3 - Next Month'),
              subtitle: Text('Location: ...'),
              onTap: () {
                // Handle tapping on the event
              },
            ),
            // Add more events as needed
          ],
        ),
      ),
    );
  }
}
