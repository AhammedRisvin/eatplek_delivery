import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/utils/responsive_helper.dart';
import '../controllers/splash_controller.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());
    final r = ResponsiveHelper(context);

    return Scaffold(
      backgroundColor: const Color(0xFF042E60),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomPaint(
              size: Size(r.s48, r.s48),
              painter: _PinPainter(),
            ),
            SizedBox(height: r.s16),
            Text(
              'EATPLEK',
              style: TextStyle(
                fontSize: r.f28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: r.s4,
              ),
            ),
            SizedBox(height: r.s6),
            Text(
              'DELIVERY',
              style: TextStyle(
                fontSize: r.f13,
                fontWeight: FontWeight.w400,
                color: Colors.white70,
                letterSpacing: r.s4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PinPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    final cx = size.width / 2;
    final cy = size.height * 0.42;
    final r = size.width * 0.42;
    final path = Path();
    path.addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));
    path.moveTo(cx - r * 0.5, cy + r * 0.6);
    path.quadraticBezierTo(cx, size.height, cx, size.height);
    path.quadraticBezierTo(cx, size.height, cx + r * 0.5, cy + r * 0.6);
    path.close();
    canvas.drawPath(path, paint);
    canvas.drawCircle(
        Offset(cx, cy), r * 0.45, Paint()..color = const Color(0xFF042E60));
  }

  @override
  bool shouldRepaint(covariant CustomPainter _) => false;
}
