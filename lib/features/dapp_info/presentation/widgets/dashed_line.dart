import 'package:dappstore/features/dapp_info/presentation/widgets/dashed_line_painter.dart';
import 'package:flutter/material.dart';

class DashedLine extends StatelessWidget {
  const DashedLine({
    Key? key,
    required this.space,
    required this.color,
    required this.padding,
    required this.width,
  }) : super(key: key);
  final Color color;
  final double space;
  final double width;
  final double padding;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedLinePainter(
        dashColor: color,
        space: space,
        width: width,
        padding: padding,
      ),
    );
  }
}
