import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shapes/flutter_shapes.dart';

class painter extends CustomPainter {
  painter(int ver, int g);
  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint();

    paint.color = Colors.grey;
    var cPosition = Offset(30, size.height / 2);
    canvas.drawCircle(cPosition, 25, paint);
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
