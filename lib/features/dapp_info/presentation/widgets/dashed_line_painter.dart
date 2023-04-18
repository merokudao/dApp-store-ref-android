import 'package:flutter/material.dart';

class DashedLinePainter extends CustomPainter {
  final Color dashColor;
  final double width;
  final double space;
  final double padding;
  DashedLinePainter(
      {required this.dashColor,
      required this.width,
      required this.space,
      required this.padding});
  @override
  void paint(Canvas canvas, Size size) {
    double dashWidth = width, dashSpace = space, startX = padding;
    final paint = Paint()
      ..color = dashColor
      ..strokeWidth = 1;
    while (startX < size.width - padding * 2) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
