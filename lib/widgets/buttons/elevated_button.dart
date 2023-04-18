import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  /// A custom elevated button wrapper with app design
  final Widget child;
  final GestureTapCallback onTap;
  final Color color;
  final double radius;
  final double height;
  final double width;

  const CustomElevatedButton(
      {super.key,
      required this.onTap,
      required this.color,
      required this.radius,
      required this.height,
      required this.width,
      required this.child});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        borderRadius: BorderRadius.circular(radius),
        color: color,
        child: InkWell(
          borderRadius: BorderRadius.circular(radius),
          onTap: onTap,
          child: Center(child: child),
        ),
      ),
    );
  }
}
