import 'package:flutter/material.dart';
import '../theme.dart';
import '../utils/responsive.dart';

/// Full-screen background: splash_bg.jpg with a dark overlay gradient.
/// Wrap all main tab screens with this widget.
class ScreenBg extends StatelessWidget {
  final Widget child;

  const ScreenBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/splash_bg.jpg',
          fit: BoxFit.cover,
        ),
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xCC0F0A2A), Color(0xF50A0A1A)],
            ),
          ),
        ),
        child,
      ],
    );
  }
}

/// Section label — uppercase, spaced, muted
class SectionLabel extends StatelessWidget {
  final String text;
  final Color? color;

  const SectionLabel(this.text, {super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontFamily: 'Urbanist',
        fontSize: Responsive.sp(11),
        fontWeight: FontWeight.w700,
        letterSpacing: 2.0,
        color: color ?? AppColors.textTertiary,
      ),
    );
  }
}

/// Glass card container
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double radius;
  final Color? borderColor;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.radius = 16,
    this.borderColor,
  });

  double get _resolvedRadius => Responsive.w(radius);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(_resolvedRadius),
        border: Border.all(
          color: borderColor ?? AppColors.surfaceBorderLight,
        ),
      ),
      child: child,
    );
  }
}

/// Standard screen top nav bar
class ScreenNav extends StatelessWidget {
  final String title;
  final Widget? trailing;
  final bool showBack;

  const ScreenNav({
    super.key,
    required this.title,
    this.trailing,
    this.showBack = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBack)
          GestureDetector(
            onTap: () {
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
            },
            child: Container(
              width: Responsive.w(36),
              height: Responsive.w(36),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.surfaceBorderLight),
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.white,
                size: Responsive.w(16),
              ),
            ),
          )
        else
          SizedBox(width: Responsive.w(36)),
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: Responsive.sp(17),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        if (trailing != null)
          trailing!
        else
          SizedBox(width: Responsive.w(36)),
      ],
    );
  }
}
