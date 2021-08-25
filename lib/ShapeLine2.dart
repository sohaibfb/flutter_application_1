import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shapes/flutter_shapes.dart';

class ShapeLine2 extends CustomPainter {
  Color lineColor2;

  ShapeLine2({
    this.lineColor2,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint();

    paint.color = lineColor2;

    var lPosition1 = Offset(55, size.height / 2);
    var lPosition2 = Offset(75, size.height / 2);
    paint.strokeWidth = 5;
    canvas.drawLine(lPosition1, lPosition2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
