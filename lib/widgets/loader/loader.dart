import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loader extends StatelessWidget {
  /// Creates a generic loader that can be used anywhere in the app
  /// [size] and [color] must be not-null
  final double size;
  final Color color;

  const Loader({
    super.key,
    required this.size,
    required this.color,
  });
  @override
  Widget build(BuildContext context) {
    return SpinKitFoldingCube(
      size: size,
      color: color,
    );
  }
}
