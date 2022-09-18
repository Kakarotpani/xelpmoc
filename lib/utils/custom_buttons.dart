import 'package:flutter/material.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  textStyle: const TextStyle(
    letterSpacing: 0,
    fontSize: 18,
    //fontFamily: 'serif',
    fontWeight: FontWeight.normal,
  ),
  onPrimary: const Color.fromARGB(255, 255, 255, 255),
  primary: const Color.fromARGB(255, 36, 198, 241),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
);

final ButtonStyle updateButtonStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  textStyle: const TextStyle(
    letterSpacing: 0,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  ),
  onPrimary: const Color.fromARGB(255, 255, 255, 255),
  primary: const Color.fromARGB(255,24,31,249),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
);

final ButtonStyle addJobButtonStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  textStyle: const TextStyle(
    letterSpacing: 0,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  ),
  onPrimary: const Color.fromARGB(255, 255, 255, 255),
  primary: const Color.fromARGB(255, 13, 177, 149),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
);

final ButtonStyle deleteButtonStyle = ElevatedButton.styleFrom(
  alignment: Alignment.center,
  textStyle: const TextStyle(
    letterSpacing: 0,
    fontSize: 18,
    fontWeight: FontWeight.normal,
  ),
  onPrimary: const Color.fromARGB(255, 255, 255, 255),
  primary: const Color.fromARGB(255, 230, 7, 7),
  padding: const EdgeInsets.symmetric(horizontal: 16),
  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
);