import 'package:flutter/material.dart';

class RPSCustomPainterCurve2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.quadraticBezierTo(size.width * 0.13, size.height * 0.51,
        size.width * 0.25, size.height * 0.60);
    path_0.cubicTo(size.width * 0.37, size.height * 0.67, size.width * 0.63,
        size.height * 0.40, size.width * 0.75, size.height * 0.60);
    path_0.quadraticBezierTo(
        size.width * 0.89, size.height * 0.79, size.width, size.height * 0.80);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomPainterConvexCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.60);
    path_0.quadraticBezierTo(size.width * 0.25, size.height * 0.80,
        size.width * 0.50, size.height * 0.80);
    path_0.quadraticBezierTo(
        size.width * 0.75, size.height * 0.80, size.width, size.height * 0.60);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.60);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomPainterConcaveCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * 0.50);
    path_0.quadraticBezierTo(size.width * 0.25, size.height * 0.25,
        size.width * 0.50, size.height * 0.25);
    path_0.quadraticBezierTo(
        size.width * 0.75, size.height * 0.25, size.width, size.height * 0.50);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, size.height * 0.50);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomPainterEventCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.quadraticBezierTo(size.width * 0.13, size.height * 0.74,
        size.width * 0.50, size.height * 0.75);
    path_0.quadraticBezierTo(
        size.width * 0.75, size.height * 0.75, size.width, size.height * 0.50);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class CustomPainterClubCurve extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;
    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.quadraticBezierTo(size.width * 0.09, size.height * 0.75,
        size.width * 0.25, size.height * 0.75);
    path_0.cubicTo(size.width * 0.50, size.height * 0.75, size.width * 0.57,
        size.height * 0.50, size.width * 0.75, size.height * 0.50);
    path_0.quadraticBezierTo(
        size.width * 0.88, size.height * 0.50, size.width, size.height * 0.75);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Color.fromARGB(255, 33, 150, 243)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    Path path_0 = Path();
    path_0.moveTo(0, 0);
    path_0.quadraticBezierTo(size.width * 0.11, size.height * 0.75,
        size.width * 0.25, size.height * 0.75);
    path_0.cubicTo(size.width * 0.44, size.height * 0.75, size.width * 0.57,
        size.height * 0.50, size.width * 0.85, size.height * 0.50);
    path_0.quadraticBezierTo(
        size.width * 0.92, size.height * 0.50, size.width, size.height * 0.75);
    path_0.lineTo(size.width, size.height);
    path_0.lineTo(0, size.height);
    path_0.lineTo(0, 0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
