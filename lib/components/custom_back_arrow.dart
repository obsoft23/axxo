// ignore_for_file: prefer_const_constructors, prefer_final_fields, prefer_const_literals_to_create_immutables, unused_field, must_be_immutable, prefer_typing_uninitialized_variables, unused_import, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vixo/auth/user_account_setup/create_username.dart';
import 'package:vixo/constants.dart';
import 'package:vixo/theme/theme.dart';

class CustomBackArrowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20, // Set the desired width for the back arrow icon
      height: 0,
      child: Center(
        child: Icon(
          Icons.arrow_back,
          size: 20.0, // Set the desired size for the back arrow icon
        ),
      ),
    );
  }
}
