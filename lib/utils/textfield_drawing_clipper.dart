import 'package:flutter/material.dart';

class TextfieldDrawingClipper extends CustomClipper<Path> {
  Size size;
  Offset topLeft;
  TextfieldDrawingClipper({required this.size, required this.topLeft});

  @override
  Path getClip(Size size) {
    double midX = (topLeft.dx + (size.width + topLeft.dx)) / 2;
    double midY = topLeft.dy + size.height;

    Offset midRectStart = Offset(midX - 5, midY);
    Offset midRectEnd = Offset(midX + 5, midY + 5);

    Path path = Path();

    path.moveTo(topLeft.dx, topLeft.dy);
    path.lineTo(size.width + topLeft.dx, topLeft.dy);
    path.lineTo(size.width + topLeft.dx, topLeft.dy + size.height);
    path.lineTo(topLeft.dx, topLeft.dy + size.height);
    path.lineTo(topLeft.dx, topLeft.dy);

    path.moveTo(midRectStart.dx, midRectEnd.dy);
    path.addRect(Rect.fromPoints(midRectStart, midRectEnd));

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
