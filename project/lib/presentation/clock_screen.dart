import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ClockScreen extends StatefulWidget {
  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 90, 150, 149),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Clock.......",
          style: TextStyle(fontStyle: FontStyle.italic, fontSize: 30,color: Colors.white),
        ),
      ),
      body: Center(
        child: ClockWidget(),
      ),
    );
  }
}

class ClockWidget extends StatefulWidget {
  @override
  _ClockWidgetState createState() => _ClockWidgetState();
}

class _ClockWidgetState extends State<ClockWidget> {
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 1), (timer) => setState(() {}));
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(300, 300),
      painter: ClockPainter(),
    );
  }
}

class ClockPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final fillBrush = Paint()..color = Colors.white;
    final outlineBrush = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    final centerDotBrush = Paint()..color = Colors.black;
    final hourHandBrush = Paint()
      ..color = Colors.black
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;
    final minuteHandBrush = Paint()
      ..color = Colors.black
      ..strokeWidth = 6
      ..strokeCap = StrokeCap.round;
    final secondHandBrush = Paint()
      ..color = Colors.red
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, fillBrush);
    canvas.drawCircle(center, radius, outlineBrush);
    canvas.drawCircle(center, 5, centerDotBrush);

    final dateTime = DateTime.now();

    void drawHand(double angle, double length, Paint paint) {
      final radian = (pi / 180) * angle;
      final handX = center.dx + length * cos(radian - pi / 2);
      final handY = center.dy + length * sin(radian - pi / 2);
      canvas.drawLine(center, Offset(handX, handY), paint);
    }

    drawHand(dateTime.hour * 30 + dateTime.minute * 0.5, radius * 0.5,
        hourHandBrush);
    drawHand(dateTime.minute * 6, radius * 0.7, minuteHandBrush);
    drawHand(dateTime.second * 6, radius * 0.9, secondHandBrush);

    for (int i = 1; i <= 12; i++) {
      final angle = i * 30 * pi / 180;
      final digitX = center.dx + (radius - 30) * cos(angle - pi / 2);
      final digitY = center.dy + (radius - 30) * sin(angle - pi / 2);
      final textPainter = TextPainter(
        text: TextSpan(
          text: '$i',
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();
      textPainter.paint(
          canvas,
          Offset(
              digitX - textPainter.width / 2, digitY - textPainter.height / 2));
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
