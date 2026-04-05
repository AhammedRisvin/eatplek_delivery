import 'package:flutter/material.dart';

class ResponsiveHelper {
  final BuildContext context;
  late final double _w;
  late final double _h;
  late final double _sw; // scale factor based on width
  late final double _sh; // scale factor based on height

  ResponsiveHelper(this.context) {
    final size = MediaQuery.of(context).size;
    _w = size.width;
    _h = size.height;
    _sw = _w / 390; // base: iPhone 14 width
    _sh = _h / 844; // base: iPhone 14 height
  }

  double get screenWidth => _w;
  double get screenHeight => _h;

  // ── Spacing (width-scaled) ─────────────────────────────────────────────────
  double get s2 => 2 * _sw;
  double get s4 => 4 * _sw;
  double get s6 => 6 * _sw;
  double get s8 => 8 * _sw;
  double get s10 => 10 * _sw;
  double get s12 => 12 * _sw;
  double get s14 => 14 * _sw;
  double get s16 => 16 * _sw;
  double get s18 => 18 * _sw;
  double get s20 => 20 * _sw;
  double get s24 => 24 * _sw;
  double get s28 => 28 * _sw;
  double get s32 => 32 * _sw;
  double get s36 => 36 * _sw;
  double get s40 => 40 * _sw;
  double get s48 => 48 * _sw;
  double get s56 => 56 * _sw;
  double get s64 => 64 * _sw;

  // ── Height-scaled values ───────────────────────────────────────────────────
  double get h4 => 4 * _sh;
  double get h8 => 8 * _sh;
  double get h12 => 12 * _sh;
  double get h16 => 16 * _sh;
  double get h20 => 20 * _sh;
  double get h24 => 24 * _sh;
  double get h28 => 28 * _sh;
  double get h32 => 32 * _sh;
  double get h40 => 40 * _sh;
  double get h48 => 48 * _sh;
  double get h52 => 52 * _sh;
  double get h56 => 56 * _sh;
  double get h64 => 64 * _sh;

  // ── Font sizes ────────────────────────────────────────────────────────────
  double get f10 => 10 * _sw;
  double get f11 => 11 * _sw;
  double get f12 => 12 * _sw;
  double get f13 => 13 * _sw;
  double get f14 => 14 * _sw;
  double get f15 => 15 * _sw;
  double get f16 => 16 * _sw;
  double get f18 => 18 * _sw;
  double get f20 => 20 * _sw;
  double get f22 => 22 * _sw;
  double get f24 => 24 * _sw;
  double get f28 => 28 * _sw;
  double get f32 => 32 * _sw;

  // ── Border radius ─────────────────────────────────────────────────────────
  double get r4 => 4 * _sw;
  double get r6 => 6 * _sw;
  double get r8 => 8 * _sw;
  double get r10 => 10 * _sw;
  double get r12 => 12 * _sw;
  double get r14 => 14 * _sw;
  double get r16 => 16 * _sw;
  double get r20 => 20 * _sw;
  double get r24 => 24 * _sw;

  // ── Icon sizes ────────────────────────────────────────────────────────────
  double get i16 => 16 * _sw;
  double get i18 => 18 * _sw;
  double get i20 => 20 * _sw;
  double get i22 => 22 * _sw;
  double get i24 => 24 * _sw;
  double get i28 => 28 * _sw;
  double get i32 => 32 * _sw;

  // ── Screen fractions ──────────────────────────────────────────────────────
  double wp(double percent) => _w * percent / 100;
  double hp(double percent) => _h * percent / 100;

  // ── Safe area ─────────────────────────────────────────────────────────────
  double get topPadding => MediaQuery.of(context).padding.top;
  double get bottomPadding => MediaQuery.of(context).padding.bottom;
}
