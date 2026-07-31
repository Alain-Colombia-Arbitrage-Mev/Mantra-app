import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/brand_mark.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _textController;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<double> _textOpacity;
  late final Animation<Offset> _textSlide;
  Timer? _textTimer;
  Timer? _navigationTimer;

  @override
  void initState() {
    super.initState();

    // Logo: scale up + fade in
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _logoScale = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = CurvedAnimation(
      parent: _logoController,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );

    // Text: fade + slide up (delayed)
    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _textOpacity = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );
    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _textController, curve: Curves.easeOut));

    // Start the experience independently from asset decoding. If the logo cannot
    // be decoded, BrandMark renders its fallback without blocking navigation.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      _logoController.forward();
      _textTimer = Timer(const Duration(milliseconds: 600), () {
        if (mounted) _textController.forward();
      });
      _navigationTimer = Timer(const Duration(seconds: 6), () {
        if (mounted) context.go('/intro');
      });
    });
  }

  @override
  void dispose() {
    _textTimer?.cancel();
    _navigationTimer?.cancel();
    _logoController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset('assets/images/splash_bg.jpg', fit: BoxFit.cover),
          // Subtle dark vignette overlay
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.2),
                radius: 1.2,
                colors: [
                  Colors.transparent,
                  AppColors.backgroundEnd.withValues(alpha: 0.4),
                ],
              ),
            ),
          ),
          // Logo + wordmark
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _logoScale,
                  child: FadeTransition(
                    opacity: _logoOpacity,
                    child: BrandMark(
                      size: Responsive.isCompact
                          ? Responsive.w(164)
                          : Responsive.w(208),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(28)),
                SlideTransition(
                  position: _textSlide,
                  child: FadeTransition(
                    opacity: _textOpacity,
                    child: Text(
                      'mantralia',
                      style: GoogleFonts.manrope(
                        fontSize: Responsive.isCompact
                            ? Responsive.sp(52)
                            : Responsive.sp(70),
                        fontWeight: FontWeight.w800,
                        color: AppColors.white,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
