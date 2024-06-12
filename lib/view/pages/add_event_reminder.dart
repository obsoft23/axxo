// ignore_for_file: prefer_const_constructors, unused_import, use_key_in_widget_constructors, depend_on_referenced_packages, must_be_immutable, use_build_context_synchronously, prefer_final_fields, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vixo/theme/constants.dart';
import 'package:vixo/theme/theme.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class AddEventPage extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String _selectedType = 'Event';
  DateTime _selectedDateTime = DateTime.now();
  DateTime _selectedEndTime = DateTime.now().add(Duration(hours: 1));

  final bool _isTextFieldFilled = false;

  List<String> _list = [
    'Event',
    'Reminder',
  ];

  List _list2 = [
    'None',
    'At the time of event',
    '5 minutes before',
    '10 minutes before',
    '15 minutes before',
    '30 minutes before',
    '1 hour before',
    '2 hours before',
    '1 day before',
    '2 days before',
    '1 week before',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event/Reminder'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () async {
            if (_formKey.currentState!.validate()) {
              calendarController.addEventToFirebase(
                _titleController.text,
                _locationController.text,
                _selectedType,
                _selectedDateTime,
              );
              Navigator.of(context).pop();
            }
          },
          child: Ink(
            width: double.infinity,
            height: 56.0,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blueGrey),
              borderRadius: BorderRadius.circular(12.0),
              color: _isTextFieldFilled ? kPrimaryColor2 : kDarkGreyColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create",
                  style: TextStyle(
                    color: kDefaultIconDarkColor,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title', ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Location'),
              ),
              SizedBox(height: 16.0),
              Text('Type'),
              CustomDropdown(
                hintText: 'Select an option',
                items: _list,
                validator: (value) {
                  if (value == null || value == 'None') {
                    return 'Please select an option other than None';
                  }
                  return null;
                },
                onChanged: (value) {},
              ),
              SizedBox(height: 4.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Start Time'),
              ),
              InkWell(
                onTap: () async {
                  final selectedDateTime = await _selectDateTime(context);
                  if (selectedDateTime != null) {
                    _selectedDateTime = selectedDateTime;
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8.0),
                    Text(
                      DateFormat('MMM d, yyyy - HH:mm')
                          .format(_selectedDateTime),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('End Time'),
              ),
              InkWell(
                onTap: () async {
                  final selectedEndTime = await _selectDateTime(context);
                  if (selectedEndTime != null) {
                    _selectedDateTime = selectedEndTime;
                  }
                },
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 8.0),
                    Text(
                      DateFormat('MMM d, yyyy - HH:mm')
                          .format(_selectedEndTime),
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text('Alert'),
              CustomDropdown(
                hintText: 'Select an option',
                items: _list2,
                validator: (value) {
                  if (value == null || value == 'None') {
                    return 'Please select an option other than None';
                  }
                  return null;
                },
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDateTime = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDateTime != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );
      if (pickedTime != null) {
        return DateTime(
          pickedDateTime.year,
          pickedDateTime.month,
          pickedDateTime.day,
          pickedTime.hour,
          pickedTime.minute,
        );
      }
    }
    return null;
  }
}
