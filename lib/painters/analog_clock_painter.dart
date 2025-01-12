import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnalogClockPainter extends CustomPainter {
  final DateTime datetime;
  AnalogClockPainter({
    required AnimationController controller,
    required this.datetime,
  }) : super(repaint: controller);
  @override
  void paint(Canvas canvas, Size size) {
    print("Hmm");
    double clockRadius = math.min(size.width, size.height) / 2;
    canvas.translate(size.width / 2, size.height / 2);
    print(clockRadius);
    canvas.drawCircle(Offset.zero, 5, Paint()..color=Colors.black..style=PaintingStyle.fill);

    Paint hourPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4;

    Paint minutePaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2;

    //dial
    canvas.drawCircle(
      Offset.zero,
      clockRadius,
      Paint()
        ..isAntiAlias = true
        ..color = Colors.black
        ..strokeWidth = 5
        ..style = PaintingStyle.stroke,
    );

    //lines
    for(int i = 0; i < 60; i++){
      double angle = (i * math.pi / 30);
      double outerRadius = clockRadius;
      double innerRadius = (i % 5 == 0)
          ? clockRadius * 0.85
          : clockRadius * 0.9;

      Offset start = Offset(
        innerRadius * math.cos(angle),
        innerRadius * math.sin(angle),
      );
      Offset end = Offset(
        outerRadius * math.cos(angle),
        outerRadius * math.sin(angle),
      );

      canvas.drawLine(start, end, i % 5 == 0 ? hourPaint : minutePaint);
    }
    final now = DateTime.now();
    final second = now.second;
    final minute = now.minute;
    final hour = now.hour % 12; // Convert to 12-hour format
    final secondHandLength = clockRadius * 0.9;
    final minuteHandLength = clockRadius * 0.7;
    final hourHandLength = clockRadius * 0.5;
    final secondAngle = (2 * math.pi / 60) * second - math.pi / 2;
    final minuteAngle = (2 * math.pi / 60) * minute + (2 * math.pi / (60 * 60)) * second - math.pi / 2;
    final hourAngle = (2 * math.pi / 12) * hour + (2 * math.pi / (12 * 60)) * minute - math.pi / 2;
    // Second hand
    final secondHand = Offset(
      Offset.zero.dx + secondHandLength * math.cos(secondAngle),
      Offset.zero.dy + secondHandLength * math.sin(secondAngle),
    );
    canvas.drawLine(
      Offset.zero,
      secondHand,
      Paint()
        ..color = Colors.red
        ..strokeWidth = 2,
    );

    // Minute hand
    final minuteHand = Offset(
      Offset.zero.dx + minuteHandLength * math.cos(minuteAngle),
      Offset.zero.dy + minuteHandLength * math.sin(minuteAngle),
    );
    canvas.drawLine(
      Offset.zero,
      minuteHand,
      Paint()
        ..color = Colors.black
        ..strokeWidth = 4,
    );

    // Hour hand
    final hourHand = Offset(
      Offset.zero.dx + hourHandLength * math.cos(hourAngle),
      Offset.zero.dy + hourHandLength * math.sin(hourAngle),
    );
    canvas.drawLine(
      Offset.zero,
      hourHand,
      Paint()
        ..color = Colors.black
        ..strokeWidth = 6,
    );
    // canvas.save();
  }

  @override
  bool shouldRepaint(covariant AnalogClockPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return oldDelegate.datetime != datetime;
  }
}