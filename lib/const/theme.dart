import 'package:flutter/material.dart';

const primaryColor = Color(0xFF0078d4);
const barBackgroundColor = Color(0xFF1F1F1F);
const backgroundColor = Color(0xFF151515);
const borderColor = Color(0x99ffffff);
const dangerColor = Color(0xFFff5f56);

var theme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: primaryColor,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black,
        error: dangerColor,
        onError: Colors.white,
        background: backgroundColor,
        onBackground: Colors.white,
        surface: primaryColor,
        onSurface: Colors.white));
