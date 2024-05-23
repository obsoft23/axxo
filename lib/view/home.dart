// ignore_for_file: prefer_const_constructors, unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vixo/theme/constants.dart';
import 'package:liquid_swipe/liquid_swipe.dart';
import 'package:vixo/view/pages/calender_page.dart';
import 'package:vixo/view/pages/events_page.dart';
import 'package:vixo/view/pages/map_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = [
    PartnerLocationMap(),
    CalenderPage(),
    EventsPage(),
  ];

  int currentPage = 0;
  bool showDots = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LiquidSwipe(
          pages: pages,
          waveType: WaveType.liquidReveal,
          onPageChangeCallback: (index) {
            setState(() {
              currentPage = index;
            });
          },
        ),
        Positioned(
          bottom: 50,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(pages.length, (index) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 4.0),
                width: currentPage == (index + 2) % 3 ? 12.0 : 8.0,
                height: currentPage == (index + 2) % 3 ? 12.0 : 8.0,
                decoration: BoxDecoration(
                  color: currentPage == (index + 2) % 3
                      ? Colors.black
                      : Colors.grey,
                  shape: BoxShape.circle,
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
