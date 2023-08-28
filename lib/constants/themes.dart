import 'package:flutter/material.dart';

final lightTheme = ThemeData.light(
  useMaterial3: true,
).copyWith(
  primaryColor: const Color(0XFF241c1c),
  // backgroundColor: const Color(0xFFEDE1E1),
  scaffoldBackgroundColor: const Color(0xFFEDE1E1),
  colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: const Color.fromARGB(255, 237, 225, 225),
      onPrimary: const Color(0XFF241c1c),
      secondary: const Color(0XFFffcc00),
      onSecondary: Colors.white,
      tertiary: const Color(0XFFff6600),
      onTertiary: Colors.white,
      shadow: Colors.black26,
      error: Colors.red,
      onError: Colors.white,
      background: const Color(0xFFEDE1E1),
      onBackground: Colors.brown.shade900,
      surface: const Color(0xFFFFEDED),
      onSurface: const Color(0xFF2F211B),
      primaryContainer: const Color(0xFFF8DACD),
      surfaceVariant: const Color(0xFFC2B0B0),
      secondaryContainer: const Color(0xFFF8DACD)),
);

final darkTheme = ThemeData.dark().copyWith(
  useMaterial3: true,
  // backgroundColor: const Color(0XFF241c1c),
  scaffoldBackgroundColor: const Color(0XFF241C1C),
  dividerColor: Colors.grey,
  colorScheme: const ColorScheme(
    primary: Color(0XFF241c1c),
    onPrimary: Color(0xFFEDE1E1),
    secondary: Color(0XFFffcc00),
    onSecondary: Colors.white,
    tertiary: Color(0XFFff6600),
    onTertiary: Colors.white,
    shadow: Colors.black26,
    error: Colors.red,
    onError: Colors.white,
    brightness: Brightness.dark,
    background: Color(0XFF241C1C),
    onBackground: Color(0xFFEDE1E1),
    surface: Color(0xFF403232),
    onSurface: Colors.white,
    surfaceVariant: Color.fromARGB(255, 53, 41, 41),
    primaryContainer: Color(0xFF34251F),
  ),
);
