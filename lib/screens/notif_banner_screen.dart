import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class NotifBannerScreen extends StatelessWidget {
  const NotifBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/splash_bg.jpg', fit: BoxFit.cover),
          Container(color: const Color(0xAA121212)),
          Positioned(
            top: Responsive.h(120),
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  '23:24',
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(72),
                    fontWeight: FontWeight.w700,
                    color: const Color(0x33FFFFFF),
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: Responsive.h(6)),
                Text(
                  'Sábado 21 de Febrero',
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(16),
                    color: const Color(0x22FFFFFF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Container(color: Colors.black.withValues(alpha: 0.25)),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.w(20), vertical: Responsive.h(8)),
              child: Row(
                children: [
                  Text(
                    '11:11',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(15),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      Icon(LucideIcons.wifi, color: Colors.white, size: Responsive.w(16)),
                      SizedBox(width: Responsive.w(8)),
                      Icon(
                        LucideIcons.battery,
                        color: Colors.white,
                        size: Responsive.w(16),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: Responsive.h(200),
            left: Responsive.w(20),
            right: Responsive.w(20),
            child: _BannerCard(
              gradientColors: const [Color(0xFF1A1235), Color(0xFF2D1B69)],
              borderColor: const Color(0xCCA29BFE),
              iconBgColors: const [Color(0xFF3D2B8A), Color(0xFF2D1B69)],
              icon: LucideIcons.sparkles,
              iconColor: AppColors.primaryLight,
              title: 'Hora Espejo 11:11',
              subtitle: 'Puerta abierta · Activa tu afirmación ahora',
            ),
          ),
          Positioned(
            top: Responsive.h(310),
            left: Responsive.w(20),
            right: Responsive.w(20),
            child: _BannerCard(
              gradientColors: const [Color(0xFF2D1A00), Color(0xFF5A3300)],
              borderColor: const Color(0xCCFFEAA7),
              iconBgColors: const [Color(0xFF6B4500), Color(0xFF4A3000)],
              icon: LucideIcons.gem,
              iconColor: Color(0xFFFFEAA7),
              title: 'Mantra de Abundancia · Activo',
              subtitle: 'Yo atraigo prosperidad · Repite tu mantra ahora',
            ),
          ),
          Positioned(
            top: Responsive.h(420),
            left: Responsive.w(20),
            right: Responsive.w(20),
            child: _BannerCard(
              gradientColors: const [Color(0xFF1F1200), Color(0xFF3D2600)],
              borderColor: const Color(0xCCF9A826),
              iconBgColors: const [Color(0xFF5A3800), Color(0xFF3D2600)],
              icon: LucideIcons.zap,
              iconColor: AppColors.amber,
              title: 'Júpiter está activo · Ventana de poder',
              subtitle: '14:14 – 15:30 · Máximo poder para manifestar',
            ),
          ),
          Positioned(
            top: Responsive.h(530),
            left: Responsive.w(20),
            right: Responsive.w(20),
            child: _BannerCard(
              gradientColors: const [Color(0xFF001A12), Color(0xFF003D22)],
              borderColor: const Color(0xCC55EFC4),
              iconBgColors: const [Color(0xFF005C33), Color(0xFF003D22)],
              icon: LucideIcons.bookOpen,
              iconColor: AppColors.mint,
              title: 'Tehilim 27 · Shajarit · 06:30',
              subtitle: 'El Señor es mi luz · Tu ritual matutino te espera',
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: Responsive.w(16), top: Responsive.h(48)),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      width: Responsive.w(36),
                      height: Responsive.w(36),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surfaceBorderLight,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: Responsive.w(16),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BannerCard extends StatelessWidget {
  final List<Color> gradientColors;
  final Color borderColor;
  final List<Color> iconBgColors;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _BannerCard({
    required this.gradientColors,
    required this.borderColor,
    required this.iconBgColors,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          height: Responsive.h(80),
          padding: EdgeInsets.symmetric(horizontal: Responsive.w(14)),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: gradientColors,
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor, width: 1.5),
          ),
          child: Row(
            children: [
              Container(
                width: Responsive.w(44),
                height: Responsive.w(44),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: iconBgColors,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: Responsive.w(20)),
              ),
              SizedBox(width: Responsive.w(12)),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.urbanist(
                        fontSize: Responsive.sp(14),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: Responsive.h(3)),
                    Text(
                      subtitle,
                      style: GoogleFonts.urbanist(
                        fontSize: Responsive.sp(12),
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: Responsive.w(8)),
              Icon(
                LucideIcons.chevronRight,
                color: Colors.white.withValues(alpha: 0.55),
                size: Responsive.w(18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
