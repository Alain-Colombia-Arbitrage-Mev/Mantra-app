import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Responsive sizing utility.
///
/// Designed for a **375 × 812** reference (iPhone X / SE-class).
/// Scales proportionally to the actual device width while clamping to
/// avoid extremes on very small or very large screens.
class Responsive {
  Responsive._();

  static late double _screenWidth;
  static late double _screenHeight;
  static late double _scaleFactor;
  static late double _verticalScale;
  static late double _textScale;
  static bool _initialized = false;

  static const double _designWidth = 375;
  static const double _designHeight = 812;

  /// Call once in the root widget build (or per-frame via `of(context)`).
  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    _screenWidth = size.width;
    _screenHeight = size.height;
    _scaleFactor = (_screenWidth / _designWidth).clamp(0.8, 1.6);
    _verticalScale = (_screenHeight / _designHeight).clamp(0.8, 1.6);
    _textScale = math.min(_scaleFactor, 1.35);
    _initialized = true;
  }

  static double get screenWidth {
    assert(_initialized, 'Call Responsive.init(context) first');
    return _screenWidth;
  }

  static double get screenHeight {
    assert(_initialized, 'Call Responsive.init(context) first');
    return _screenHeight;
  }

  /// Scale a dimension based on screen width.
  static double w(double size) {
    assert(_initialized, 'Call Responsive.init(context) first');
    return size * _scaleFactor;
  }

  /// Scale a dimension based on screen height.
  static double h(double size) {
    assert(_initialized, 'Call Responsive.init(context) first');
    return size * _verticalScale;
  }

  /// Scale font size (slightly less aggressive than width scaling).
  static double sp(double size) {
    assert(_initialized, 'Call Responsive.init(context) first');
    return size * _textScale;
  }

  /// Horizontal padding that adapts to screen width.
  static double get pagePadding => w(20);

  /// Bottom padding to clear the BottomNav.
  static double get bottomNavPadding => h(80);

  /// Scale factor itself for rare manual use.
  static double get scale => _scaleFactor;
}
