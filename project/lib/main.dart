import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

import 'presentation/clock_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ClockScreen(),
    );
  }
}
