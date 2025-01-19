import 'package:flutter/material.dart';
import 'dart:math' as math;

const _petals = 10;

class RectanglePainter extends CustomPainter {
  late Animation<double> stemGrowthTween;
  late Animation<double> petalGrowthTween;
  late Animation<double> leafGrowthTween;
  RectanglePainter({
    required AnimationController controller,
  }) : super(repaint: controller) {
    stemGrowthTween = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.4, curve: Curves.easeInOut),
      ),
    );

    petalGrowthTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.4, 0.8, curve: Curves.fastEaseInToSlowEaseOut),
      ),
    );

    leafGrowthTween = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.8, 1, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    const stemTop = Offset.zero;
    const stemBottom = Offset(0, 400);

    Paint paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 30;

    canvas.drawLine(stemTop + (stemBottom * (1 - stemGrowthTween.value)),
        stemBottom, paint);

    const angleDiff = math.pi / (_petals - 1);

    for (int i = 0; i < _petals; i++) {
      final angle = (math.pi / 2) + (i * angleDiff);
      canvas.save();
      canvas.rotate(angle);
      canvas.drawOval(
        Rect.fromCenter(
            center: stemTop, width: 70, height: 250 * petalGrowthTween.value),
        Paint()..color = Colors.pink.withValues(alpha: 0.75),
      );
      canvas.restore();
    }
    canvas.save();
    canvas.translate(0, 200);
    canvas.rotate(math.pi / 4);
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(stemTop.dx + 85, stemTop.dy),
          width: 50,
          height: 200 * leafGrowthTween.value),
      Paint()..color = Colors.green,
    );
    canvas.restore();
    canvas.save();
    canvas.translate(0, 200);
    canvas.rotate(3 * math.pi / 4);
    canvas.drawOval(
      Rect.fromCenter(
          center: Offset(stemTop.dx + 85, stemTop.dy),
          width: 50,
          height: 200 * leafGrowthTween.value),
      Paint()..color = Colors.green,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
