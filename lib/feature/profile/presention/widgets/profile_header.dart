
import 'package:flutter/material.dart';
import 'package:todo_apps/core/component/my_custom_linear_gradient.dart';

class ProfileHeader extends CustomPainter {
  final Size deviceSize;

  ProfileHeader({required this.deviceSize});

  @override
  void paint(Canvas canvas, Size size) {
    final Gradient gradient = MyLinearGradient;
    Rect rect = new Rect.fromCircle(
      center: new Offset(this.deviceSize.height / 2, this.deviceSize.width / 2),
      radius: this.deviceSize.width * 0.5,
    );
    var paint = Paint()..shader = gradient.createShader(rect);
    paint.color = Colors.green[800]!;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0, this.deviceSize.height * 0.25);
    path.quadraticBezierTo(
        this.deviceSize.width * .1,
        this.deviceSize.height * 0.35,
        this.deviceSize.width * .30,
        this.deviceSize.height * 0.30);
    path.lineTo(this.deviceSize.width, this.deviceSize.height * 0.15);
    path.lineTo(this.deviceSize.width, 0);
    path.lineTo(0, 0);

    canvas.drawShadow(path, Colors.black54, 5.0, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
