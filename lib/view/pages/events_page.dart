// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Center(
        child: Text(
          'Page 3',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
