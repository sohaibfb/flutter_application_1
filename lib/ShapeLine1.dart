import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shapes/flutter_shapes.dart';

class ShapeLine1 extends CustomPainter {
  Color circleColor1;
  Color lineColor1;
  Color circleColor2;
  Color lineColor2;
  Color circleColor3;

  ShapeLine1({
    this.lineColor1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint();

    paint.color = lineColor1;

    var lPosition1 = Offset(0, size.height / 2 + 30);
    var lPosition2 = Offset(30, size.height / 2 + 30);
    paint.strokeWidth = 5;
    canvas.drawLine(lPosition1, lPosition2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
