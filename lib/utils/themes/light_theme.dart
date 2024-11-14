import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  useMaterial3: false,
  fontFamily: 'OpenSans',
  primaryColor: const Color(0xFF0F84B8),
  primaryColorDark: const Color(0xFF115878),
  secondaryHeaderColor: const Color(0xFF000743),
  disabledColor: const Color(0xFF000000),
  brightness: Brightness.light,
  hintColor:  const Color(0xFF000000).withOpacity(0.50),
  cardColor: Colors.white,
  canvasColor: const Color(0xffFFFFFF),
  scaffoldBackgroundColor: const Color(0xffFFFFFF),
    checkboxTheme: CheckboxThemeData(
      checkColor: MaterialStateProperty.all(Colors.white),
      fillColor: MaterialStateProperty.all(Colors.transparent),
      side: MaterialStateBorderSide.resolveWith(
            (states) => const BorderSide(
          color: Colors.white, // Custom border color
          width: 1,
        ),
      )),
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(0xFF0F84B8))), colorScheme: const ColorScheme.light(primary: Color(0xFF0F84B8), secondary: Color(0xFF0F84B8)).copyWith(error: const Color(0xFF0F84B8)).copyWith(background: const Color(0xFF0F84B8)),
);
const Color primaryColor = Color(0xFF0F84B8);
 Color hintColor = const Color(0xFF000000).withOpacity(0.50);
const Color redColor = Color(0xffB43642);
const Color greenColor = Color(0xff6D9C0A);
const Color blueColor = Color(0xff115878);
const Color skyColor = Color(0xff46C8D0);
const Color darkBlueColor = Color(0xff517DA5);
const Color darkPinkColor = Color(0xffBC6868);
const Color yellowColor = Color(0xffFFAC33);
