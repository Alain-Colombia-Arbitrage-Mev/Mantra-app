import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/cta_button.dart';

// ─── Slide data matching .pen design exactly ─────────────────────────────────

final List<_SlideData> _slides = [
  // 02 · Splash Intro 1 — woman meditating on mountain
  _SlideData(
    image: 'assets/images/intro1_bg.jpg',
    overlayOpacity: 0.0,
    // Bottom gradient for text readability
    bottomGradient: true,
    text: 'Tu santuario personal te espera',
    fontWeight: FontWeight.w400,
  ),
  // 03 · Splash Intro 2 — man meditating at window
  _SlideData(
    image: 'assets/images/intro2_bg.jpg',
    overlayOpacity: 0.45,
    bottomGradient: true,
    text: 'La mejor medicina no se compra en ninguna farmacia',
    fontWeight: FontWeight.w400,
  ),
  // 04 · Splash Intro 3 — balancing stones
  _SlideData(
    image: 'assets/images/intro3_bg.jpg',
    overlayOpacity: 0.33,
    bottomGradient: true,
    text: '5 minutos al día que lo cambian todo',
    fontWeight: FontWeight.w700,
  ),
  // 05 · Splash Intro 4 — 3D spheres
  _SlideData(
    image: 'assets/images/intro4_bg.jpg',
    overlayOpacity: 0.54,
    bottomGradient: true,
    text: 'Existe una mejor versión de ti, Conócela',
    fontWeight: FontWeight.w700,
  ),
];

class _SlideData {
  final String image;
  final double overlayOpacity;
  final bool bottomGradient;
  final String text;
  final FontWeight fontWeight;

  const _SlideData({
    required this.image,
    required this.overlayOpacity,
    required this.bottomGradient,
    required this.text,
    required this.fontWeight,
  });
}

// ─── Intro Screen ────────────────────────────────────────────────────────────

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  static const int _totalPages = 5; // 4 intros + 1 final

  void _next() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (page) => setState(() => _currentPage = page),
        itemCount: _totalPages,
        itemBuilder: (context, index) {
          if (index < 4) {
            return _IntroPage(
              slide: _slides[index],
              pageIndex: index,
              totalPages: _totalPages,
              onNext: _next,
            );
          }
          return _FinalPage(totalPages: _totalPages);
        },
      ),
    );
  }
}

// ─── Intro Slide Pages 02–05 ─────────────────────────────────────────────────

class _IntroPage extends StatelessWidget {
  final _SlideData slide;
  final int pageIndex;
  final int totalPages;
  final VoidCallback onNext;

  const _IntroPage({
    required this.slide,
    required this.pageIndex,
    required this.totalPages,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Background image ──
        Image.asset(slide.image, fit: BoxFit.cover),

        // ── Dark tint overlay ──
        if (slide.overlayOpacity > 0)
          Container(
            color: Colors.black.withValues(alpha: slide.overlayOpacity),
          ),

        // ── Bottom gradient for text readability ──
        if (slide.bottomGradient)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 500,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0x00000000),
                    Color(0x80000000),
                    Color(0xDD000000),
                  ],
                  stops: [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),

        // ── Text content ──
        Positioned(
          left: 16,
          right: 16,
          bottom: 140,
          child: Text(
            slide.text,
            style: GoogleFonts.urbanist(
              fontSize: 64,
              fontWeight: slide.fontWeight,
              color: AppColors.white,
              height: 1.0,
              letterSpacing: -1,
            ),
          ),
        ),

        // ── Bottom bar: dots + next button ──
        Positioned(
          left: 16,
          right: 16,
          bottom: 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _ProgressDots(
                current: pageIndex,
                total: totalPages,
                activeWidth: 25,
                inactiveWidth: 14,
                height: 5,
              ),
              _NextButton(onTap: onNext),
            ],
          ),
        ),
      ],
    );
  }
}

// ─── Final Page 06 ───────────────────────────────────────────────────────────

class _FinalPage extends StatelessWidget {
  final int totalPages;

  const _FinalPage({required this.totalPages});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Background image ──
        Image.asset('assets/images/intro4_bg.jpg', fit: BoxFit.cover),

        // ── Heavy dark overlay ──
        Container(color: const Color(0x9A000000)),

        // ── Dark solid gradient from bottom ──
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 500,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x000A0A1A),
                  Color(0xFF0A0A1A),
                ],
                stops: [0.0, 0.25],
              ),
            ),
          ),
        ),

        // ── Content ──
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),

                // MANTRAS tagline
                Text(
                  'MANTRAS',
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryLight,
                    letterSpacing: 4,
                  ),
                ),
                const SizedBox(height: 12),

                // Main title
                Text(
                  'Tu mejor versión\ncomienza hoy',
                  style: GoogleFonts.urbanist(
                    fontSize: 52,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    height: 1.05,
                    letterSpacing: -0.5,
                  ),
                ),

                const Spacer(),

                // Features subtitle
                Text(
                  'Alarmas biológicas · Frecuencias sagradas\nRituales personales',
                  style: GoogleFonts.urbanist(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white.withValues(alpha: 0.93),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 32),

                // CTA Button
                CtaButton(
                  label: 'Comenzar mi viaje',
                  onTap: () => context.go('/onboarding'),
                ),
                const SizedBox(height: 18),

                // Login link
                Center(
                  child: GestureDetector(
                    onTap: () => context.go('/home'),
                    child: Text.rich(
                      TextSpan(
                        text: '¿Ya tienes cuenta? ',
                        style: GoogleFonts.urbanist(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: AppColors.white.withValues(alpha: 0.87),
                        ),
                        children: [
                          TextSpan(
                            text: 'Iniciar sesión',
                            style: GoogleFonts.urbanist(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // Progress dots (5 dots, last active)
                _ProgressDots(
                  current: 4,
                  total: totalPages,
                  activeWidth: 25,
                  inactiveWidth: 14,
                  height: 5,
                ),
                const SizedBox(height: 28),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Progress Dots ───────────────────────────────────────────────────────────
// Design: rounded rects, active=white 25px, inactive=white50% 14px,
// gap=3, height=5, cornerRadius=100

class _ProgressDots extends StatelessWidget {
  final int current;
  final int total;
  final double activeWidth;
  final double inactiveWidth;
  final double height;

  const _ProgressDots({
    required this.current,
    required this.total,
    required this.activeWidth,
    required this.inactiveWidth,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final isActive = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.only(right: i < total - 1 ? 3 : 0),
          width: isActive ? activeWidth : inactiveWidth,
          height: height,
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.white
                : AppColors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(100),
          ),
        );
      }),
    );
  }
}

// ─── Next Button ─────────────────────────────────────────────────────────────
// Design: frosted pill 126x64, white circle 48px inside with arrow

class _NextButton extends StatelessWidget {
  final VoidCallback onTap;
  const _NextButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 13, sigmaY: 13),
          child: Container(
            width: 126,
            height: 64,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Row(
              children: [
                const SizedBox(width: 8),
                // Arrow circle button
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 12,
                        offset: const Offset(5, 0),
                        spreadRadius: 9,
                      ),
                    ],
                  ),
                  child: const Icon(
                    LucideIcons.arrowRight,
                    color: AppColors.backgroundEnd,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
                // Triple chevrons (decreasing opacity)
                Icon(LucideIcons.chevronRight,
                    color: AppColors.white.withValues(alpha: 0.4), size: 14),
                Icon(LucideIcons.chevronRight,
                    color: AppColors.white.withValues(alpha: 0.6), size: 14),
                Icon(LucideIcons.chevronRight,
                    color: AppColors.white, size: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
