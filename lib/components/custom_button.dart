// ignore_for_file: prefer_const_constructors, unused_import, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:touchable_opacity/touchable_opacity.dart';

import '../constants.dart';

class CustomerAppButton extends StatelessWidget {
  CustomerAppButton({super.key, required this.title, required this.url});

  String title = "";
  // ignore: prefer_typing_uninitialized_variables
  var url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(url);
      },
      child: Container(
        width: double.infinity,
        height: 56.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey),
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(12.0)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class CustomerAppButton2 extends StatelessWidget {
  CustomerAppButton2({super.key, required this.title, required this.url});

  String title = "";
  // ignore: prefer_typing_uninitialized_variables
  var url;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(url);
      },
      child: Container(
        width: double.infinity,
        height: 56.0,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent),
          borderRadius: BorderRadius.circular(12.0),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
