import 'dart:math' as math;
import 'package:flutter/material.dart';

/// Responsive sizing utility tuned for target devices:
///
/// | Device              | Logical px   | widthScale | heightScale | textScale |
/// |---------------------|-------------|------------|-------------|-----------|
/// | Samsung S3          | 360 × 640   | 0.96       | 0.79        | 0.92      |
/// | iPhone 13 / 14      | 390 × 844   | 1.04       | 1.04        | 1.04      |
/// | Samsung S25 Ultra   | 412 × 915   | 1.10       | 1.13        | 1.08      |
/// | iPhone 16 Plus      | 430 × 932   | 1.15       | 1.15        | 1.10      |
///
/// Design reference: **375 × 812** (iPhone X / SE-class).
class Responsive {
  Responsive._();

  static late double _screenWidth;
  static late double _screenHeight;
  static late double _scaleFactor;
  static late double _verticalScale;
  static late double _textScale;
  static late double _systemBottomPadding;
  static late _DeviceBucket _bucket;
  static bool _initialized = false;

  static const double _designWidth = 375;
  static const double _designHeight = 812;

  static void init(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    _screenWidth = size.width;
    _screenHeight = size.height;
    _systemBottomPadding = MediaQuery.viewPaddingOf(context).bottom;
    _bucket = _classifyDevice(_screenWidth, _screenHeight);

    final rawW = _screenWidth / _designWidth;
    final rawH = _screenHeight / _designHeight;

    switch (_bucket) {
      case _DeviceBucket.compact:
        // Samsung S3 and similar (≤360w, ≤700h)
        // Tighter clamp, let elements shrink more vertically
        _scaleFactor = rawW.clamp(0.85, 1.0);
        _verticalScale = rawH.clamp(0.70, 0.85);
        _textScale = math.min(rawW, 1.0).clamp(0.85, 1.0);

      case _DeviceBucket.standard:
        // iPhone 13/14 class (375-400w, 800-860h)
        _scaleFactor = rawW.clamp(0.95, 1.12);
        _verticalScale = rawH.clamp(0.95, 1.12);
        _textScale = math.min(rawW, 1.12).clamp(0.95, 1.12);

      case _DeviceBucket.large:
        // Samsung S25 Ultra / iPhone 16 Plus (400-440w, 900+h)
        _scaleFactor = rawW.clamp(1.0, 1.22);
        _verticalScale = rawH.clamp(1.0, 1.22);
        _textScale = math.min(rawW, 1.18).clamp(1.0, 1.18);

      case _DeviceBucket.extraLarge:
        // Tablets and large phablets (440w+)
        _scaleFactor = rawW.clamp(1.0, 1.4);
        _verticalScale = rawH.clamp(1.0, 1.4);
        _textScale = math.min(rawW, 1.25).clamp(1.0, 1.25);
    }

    _initialized = true;
  }

  static _DeviceBucket _classifyDevice(double w, double h) {
    if (w <= 365) return _DeviceBucket.compact;
    if (w <= 400 && h <= 870) return _DeviceBucket.standard;
    if (w <= 445) return _DeviceBucket.large;
    return _DeviceBucket.extraLarge;
  }

  static double get screenWidth {
    assert(_initialized, 'Call Responsive.init(context) first');
    return _screenWidth;
  }

  static double get screenHeight {
    assert(_initialized, 'Call Responsive.init(context) first');
    return _screenHeight;
  }

  /// Whether the device has a short screen (e.g. Samsung S3, ≤700dp).
  static bool get isCompact => _bucket == _DeviceBucket.compact;

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

  /// Scale font size (capped to avoid oversized text on large screens).
  static double sp(double size) {
    assert(_initialized, 'Call Responsive.init(context) first');
    return size * _textScale;
  }

  /// Horizontal padding that adapts to screen width.
  static double get pagePadding => w(20);

  /// System navigation bar height (gesture bar, soft keys, etc.).
  static double get systemBottomInset => _systemBottomPadding;

  /// Bottom padding to clear the BottomNav + system navigation bar.
  static double get bottomNavPadding {
    double navHeight;
    switch (_bucket) {
      case _DeviceBucket.compact:
        navHeight = h(58);
      case _DeviceBucket.standard:
        navHeight = h(70);
      case _DeviceBucket.large:
      case _DeviceBucket.extraLarge:
        navHeight = h(70);
    }
    return navHeight + _systemBottomPadding + h(8);
  }

  /// Scale factor itself for rare manual use.
  static double get scale => _scaleFactor;
}

enum _DeviceBucket { compact, standard, large, extraLarge }
