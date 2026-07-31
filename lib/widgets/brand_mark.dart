import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme.dart';

class BrandMark extends StatelessWidget {
  final double size;
  final bool framed;

  const BrandMark({super.key, required this.size, this.framed = true});

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset(
      'assets/images/logomantra_transparent.png',
      width: size * 0.76,
      height: size * 0.76,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.high,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.spa_rounded,
          size: size * 0.46,
          color: AppColors.primaryLight,
        );
      },
    );

    if (!framed) return logo;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const RadialGradient(
          colors: [Color(0xFF152833), Color(0xFF09131D), Color(0xFF04080E)],
        ),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.34),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.tealMid.withValues(alpha: 0.36),
            blurRadius: 34,
            offset: const Offset(0, 16),
          ),
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.18),
            blurRadius: 22,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(child: logo),
    );
  }
}

class BrandLockup extends StatelessWidget {
  final double markSize;
  final double titleSize;
  final bool centered;

  const BrandLockup({
    super.key,
    required this.markSize,
    required this.titleSize,
    this.centered = true,
  });

  @override
  Widget build(BuildContext context) {
    final text = Text(
      'Mantralia',
      style: GoogleFonts.manrope(
        fontSize: titleSize,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
        height: 1,
      ),
    );

    if (!centered) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          BrandMark(size: markSize),
          const SizedBox(width: 12),
          text,
        ],
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        BrandMark(size: markSize),
        const SizedBox(height: 18),
        text,
      ],
    );
  }
}
