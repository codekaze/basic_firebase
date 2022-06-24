import 'package:flutter/material.dart';
import 'package:fire_example/core.dart';
import 'package:google_fonts/google_fonts.dart';

var defaultTheme = ThemeData(
  primaryColor: primaryColor,
  scaffoldBackgroundColor: Colors.grey[100],
  cardTheme: CardTheme(
    elevation: 0.6,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16.0),
    ),
  ),
  iconTheme: IconThemeData(
    color: Colors.grey[800],
  ),
  appBarTheme: AppBarTheme(
    elevation: 0.0,
    backgroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.grey[800],
    ),
    actionsIconTheme: IconThemeData(
      color: Colors.grey[800],
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[800],
    ),
  ),
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    headline1: TextStyle(
      color: Colors.grey[800],
    ),
    headline2: TextStyle(
      color: Colors.grey[800],
    ),
    bodyText1: TextStyle(
      color: Colors.grey[800],
    ),
    bodyText2: TextStyle(
      color: Colors.grey[800],
    ),
  ),
);
