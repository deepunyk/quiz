import 'package:flutter/material.dart';

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;
  final double mHeight;
  final double mWidth;
  final int direction;
  final double tempHeight;
  final double tempWidth;

  TrianglePainter({this.strokeColor, this.strokeWidth, this.paintingStyle, this.mHeight, this.mWidth, this.direction, this.tempHeight, this.tempWidth});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    if(direction == 0){
      canvas.drawPath(getBottomTriangle(mWidth, mHeight), paint);
    }else{
      canvas.drawPath(getUpperTriangle(mWidth, mHeight), paint);
    }
  }

  Path getBottomTriangle(double x, double y) {
    return Path()
      ..moveTo(0, mHeight - tempHeight)
      ..lineTo(0, y)
      ..lineTo(tempWidth, y)
      ..lineTo(0, mHeight - tempHeight);
  }

  Path getUpperTriangle(double x, double y) {
    return Path()
      ..moveTo(mWidth - tempWidth, 0)
      ..lineTo(x, 0)
      ..lineTo(x, tempHeight)
      ..lineTo(mWidth - tempWidth, 0);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth
        ||
        oldDelegate.tempHeight != tempHeight
        ||
        oldDelegate.tempWidth != tempWidth;
  }
}