import 'package:animations/util/seven_segment_util.dart';
import 'package:flutter/material.dart';

class RawSevenSegment extends CustomPainter {
  List<bool> characterBools = [false, false, false, false, false, false, false];
  late final Stopwatch s1;
  late String inputText;

  RawSevenSegment({
    required AnimationController controller,
  }) : super(repaint: controller) {
    s1 = Stopwatch();
    s1.start();
    inputText =
        (s1.elapsedMilliseconds / 1000).toString(); // Initialize the input text
  }

  @override
  void paint(Canvas canvas, Size size) {
    // print("Paint!!");
    final double gap = 10; // Space between segments
    final double segmentWidth = size.width / 4 - 20; // Horizontal segment width
    final double segmentHeight =
        size.height / 20 - 20; // Segment height (for all)
    final double xCenter = size.width / 2;
    final double yCenter = size.height / 2;
    final Color activeColor = Colors.red;
    final Color inactiveColor = Colors.white;
    final paint = Paint();

    // Segment positions (aligned for a 7-segment display)
    final segments = [
      Rect.fromLTWH(xCenter - segmentWidth / 2, gap, segmentWidth,
          segmentHeight), // Top (A)
      Rect.fromLTWH(xCenter + segmentWidth / 2, gap + segmentHeight,
          segmentHeight, segmentWidth), // Top right (B)
      Rect.fromLTWH(xCenter + segmentWidth / 2, yCenter + gap, segmentHeight,
          segmentWidth), // Bottom right (C)
      Rect.fromLTWH(
          xCenter - segmentWidth / 2,
          size.height - segmentHeight - gap,
          segmentWidth,
          segmentHeight), // Bottom (D)
      Rect.fromLTWH(xCenter - segmentWidth / 2 - segmentHeight, yCenter + gap,
          segmentHeight, segmentWidth), // Bottom left (E)
      Rect.fromLTWH(xCenter - segmentWidth / 2 - segmentHeight,
          gap + segmentHeight, segmentHeight, segmentWidth), // Top left (F)
      Rect.fromLTWH(xCenter - segmentWidth / 2, yCenter - segmentHeight / 2,
          segmentWidth, segmentHeight), // Middle (G)
    ];

    inputText = (s1.elapsedMilliseconds / 1000).round().toString();

    characterBools = getSegments(inputText.substring(inputText.length - 1));

    for (int i = 0; i < segments.length; i++) {
      paint.color = characterBools[i] ? activeColor : inactiveColor;
      canvas.drawRect(segments[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant RawSevenSegment oldDelegate) {
    return oldDelegate.inputText != inputText;
  }
}
