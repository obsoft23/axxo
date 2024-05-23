// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key});

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Center(
        child: Text(
          'Page 2',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
      ),
    );
  }
}
