import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mariners_coloring_notes/model/touch_points.dart';

class CanvasPainter extends CustomPainter {
  CanvasPainter({this.pointsList});

  //Keep track of the points tapped on the screen
  List<TouchPoints> pointsList;
  List<Offset> offsetPoints = List();

  //This is where we can draw on canvas.
  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < pointsList.length - 1; i++) {
      if (pointsList[i] != null && pointsList[i + 1] != null) {
        //Drawing line when two consecutive points are available
        canvas.drawLine(pointsList[i].points, pointsList[i + 1].points,
            pointsList[i].paint);
      } else if (pointsList[i] != null && pointsList[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(pointsList[i].points);
        offsetPoints.add(Offset(
            pointsList[i].points.dx + 0.1, pointsList[i].points.dy + 0.1));

        //Draw points when two points are not next to each other
        canvas.drawPoints(PointMode.points, offsetPoints, pointsList[i].paint);
      }
    }
  }

  //Called when CustomPainter is rebuilt.
  //Returning true because we want canvas to be rebuilt to reflect new changes.
  @override
  bool shouldRepaint(CanvasPainter oldDelegate) => true;
}
