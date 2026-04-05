import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/utils/assets.dart';
import '../../../core/utils/responsive_helper.dart';

class CurvedBottomNav extends StatelessWidget {
  final int currentIndex;
  final void Function(int) onTap;

  const CurvedBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const _items = [
    _NavItem(
        tapped: AppAssets.homeTapped,
        untapped: AppAssets.homeUntapped,
        label: 'Home'),
    _NavItem(
        tapped: AppAssets.earningsTapped,
        untapped: AppAssets.earningsUntapped,
        label: 'Earnings'),
    _NavItem(
        tapped: AppAssets.historyTapped,
        untapped: AppAssets.historyUntapped,
        label: 'History'),
    _NavItem(
        tapped: AppAssets.profileTapped,
        untapped: AppAssets.profileUntapped,
        label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final r = ResponsiveHelper(context);
    final circleD = r.s56;
    final barH = r.s72;
    final floatUp = r.s28;
    final totalH = barH + floatUp + r.s8 + r.bottomPadding;

    return LayoutBuilder(builder: (context, constraints) {
      final itemW = constraints.maxWidth / _items.length;
      final centerX = itemW * currentIndex + itemW / 2;
      final notchR = circleD / 2 + 6.0;

      return SizedBox(
        height: totalH,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // ── Shadow layer ───────────────────────────────────────────
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(r.r24),
                    topRight: Radius.circular(r.r24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 12,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
              ),
            ),

            // ── White bar with semicircle notch ────────────────────────
            Positioned.fill(
              child: CustomPaint(
                painter: _NavPainter(
                  centerX: centerX,
                  notchR: notchR,
                  barH: barH + r.bottomPadding,
                  topRadius: r.r20,
                ),
              ),
            ),

            // ── Nav item labels + untapped icons ───────────────────────
            Positioned(
              bottom: r.bottomPadding,
              left: 0,
              right: 0,
              height: barH,
              child: Row(
                children: List.generate(_items.length, (i) {
                  final item = _items[i];
                  final sel = i == currentIndex;

                  if (sel) {
                    // Selected: show label only (circle is separate layer)
                    return Expanded(
                      child: GestureDetector(
                        onTap: () => onTap(i),
                        behavior: HitTestBehavior.opaque,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(item.label,
                                style: TextStyle(
                                    fontSize: r.f11,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF042E60))),
                            SizedBox(height: r.s10),
                          ],
                        ),
                      ),
                    );
                  }

                  // Unselected: untapped SVG + label
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTap(i),
                      behavior: HitTestBehavior.opaque,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            item.untapped,
                            width: r.i24,
                            height: r.i24,
                            colorFilter: ColorFilter.mode(
                              Colors.grey.shade400,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(height: r.s4),
                          Text(item.label,
                              style: TextStyle(
                                  fontSize: r.f11,
                                  color: Colors.grey.shade400)),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),

            // ── Floating circle with tapped SVG ────────────────────────
            Positioned(
              bottom:
                  r.bottomPadding + barH - circleD / 2 + floatUp - circleD / 2,
              left: centerX - circleD / 2,
              width: circleD,
              height: circleD,
              child: GestureDetector(
                onTap: () => onTap(currentIndex),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF042E60),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      _items[currentIndex].tapped,
                      width: r.i24,
                      height: r.i24,
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}

// ── Painter ───────────────────────────────────────────────────────────────────
class _NavPainter extends CustomPainter {
  final double centerX;
  final double notchR;
  final double barH;
  final double topRadius;

  const _NavPainter({
    required this.centerX,
    required this.notchR,
    required this.barH,
    required this.topRadius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final barTop = size.height - barH;
    final cx = centerX;
    final nr = notchR;
    final sw = nr * 0.5;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, barTop + topRadius);
    path.quadraticBezierTo(0, barTop, topRadius, barTop);
    path.lineTo(cx - nr - sw, barTop);
    path.cubicTo(
      cx - nr - sw * 0.1,
      barTop,
      cx - nr + sw * 0.1,
      barTop + nr * 0.3,
      cx - nr,
      barTop + nr * 0.15,
    );
    path.arcToPoint(
      Offset(cx + nr, barTop + nr * 0.15),
      radius: Radius.circular(nr),
      clockwise: false,
    );
    path.cubicTo(
      cx + nr - sw * 0.1,
      barTop + nr * 0.3,
      cx + nr + sw * 0.1,
      barTop,
      cx + nr + sw,
      barTop,
    );
    path.lineTo(size.width - topRadius, barTop);
    path.quadraticBezierTo(size.width, barTop, size.width, barTop + topRadius);
    path.lineTo(size.width, size.height);
    path.close();

    canvas.drawPath(
        path,
        Paint()
          ..color = Colors.black.withOpacity(0.06)
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6));
    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(_NavPainter old) => old.centerX != centerX;
}

class _NavItem {
  final String tapped;
  final String untapped;
  final String label;
  const _NavItem(
      {required this.tapped, required this.untapped, required this.label});
}

extension _NavExtras on ResponsiveHelper {
  double get s72 => 72 * screenWidth / 390;
}
