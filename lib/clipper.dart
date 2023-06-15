import 'package:flutter/material.dart';

class SideCutClipper extends CustomClipper<Path> {
  double yFactor;
  double xFactor;
  SideCutClipper({this.yFactor = 50, this.xFactor = 30});
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;

    final path = Path();
    path.lineTo(0, height);

    // var a = 0.55;
    // var b1 = 0.4; // 0.4
    // var b2 = 0.45;
    // var hOfP = 0.6; // 0.6
    // var r = 0.87; // 0.87

    // path.quadraticBezierTo(
    //     size.width * (1 - a), size.height, size.width * b1, size.height * r);
    // path.quadraticBezierTo(size.width * b2, size.height * hOfP,
    //     size.width * 0.5, size.height * hOfP);
    // path.quadraticBezierTo(size.width * (1 - b2), size.height * hOfP,
    //     size.width * (1 - b1), size.height * r);
    // path.quadraticBezierTo(
    //     size.width * a, size.height, size.width, size.height);

    // path.quadraticBezierTo(
    //     size.width * 0.45, size.height, size.width * 0.45, size.height * 0.87);
    // path.quadraticBezierTo(size.width * 0.4, size.height * 0.6,
    //     size.width * 0.5, size.height * 0.6);
    // path.quadraticBezierTo(size.width * 0.6, size.height * 0.6,
    //     size.width * 0.55, size.height * 0.87);
    // path.quadraticBezierTo(
    //     size.width * 0.55, size.height, size.width, size.height);
    // path.lineTo(width, 0);

    double startX = 0.5 * width - 2 * xFactor;
    double xVal = width;
    double yVal = 0;
    yVal = height;
    xVal = startX;

    path.cubicTo(0, yVal, xVal + xFactor, yVal, xVal + xFactor, yVal - yFactor);
    xVal = xVal + xFactor;
    yVal = yVal - yFactor;

    path.cubicTo(
        xVal, yVal, xVal, yVal - yFactor, xVal + xFactor, yVal - yFactor);
    xVal = xVal + xFactor;
    yVal = yVal - yFactor;
    path.cubicTo(
        xVal, yVal, xVal + xFactor, yVal, xVal + xFactor, yVal + yFactor);
    xVal = xVal + xFactor;
    yVal = yVal + yFactor;

    path.cubicTo(xVal, yVal, xVal, yVal + yFactor, width, height);
    xVal = xVal + xFactor;
    yVal = yVal + yFactor;

    path.lineTo(width, height);
    path.lineTo(width, 0);

    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
