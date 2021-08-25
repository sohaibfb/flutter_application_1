import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shapes/flutter_shapes.dart';

class ShapeCircle1 extends CustomPainter {
  Color circleColor1;

  ShapeCircle1({
    this.circleColor1,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // TODO: implement paint
    final paint = Paint();

    paint.color = circleColor1;
    var cPosition = Offset(0, (size.height / 2) + 30);
    canvas.drawCircle(cPosition, 25, paint);
    //var lPosition1 = Offset(55, size.height / 2);
    //var lPosition2 = Offset(75, size.height / 2);
    //paint.strokeWidth = 5;

    //paint.color = lineColor1;

    //canvas.drawLine(lPosition1, lPosition2, paint);

    //paint.color = circleColor2;
    //var cPosition2 = Offset(100, size.height / 2);
    //canvas.drawCircle(cPosition2, 25, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    throw UnimplementedError();
  }
}
