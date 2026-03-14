import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';

class NotifBannerScreen extends StatelessWidget {
  const NotifBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset('assets/images/splash_bg.jpg', fit: BoxFit.cover),
          // #121212 at 66% overlay
          Container(color: const Color(0xAA121212)),
          // Dimmed clock behind content
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Text(
                  '23:24',
                  style: GoogleFonts.urbanist(
                    fontSize: 72,
                    fontWeight: FontWeight.w700,
                    color: const Color(0x33FFFFFF),
                    height: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 6),
                Text(
                  'Sábado 21 de Febrero',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    color: const Color(0x22FFFFFF),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          // Additional dim overlay for depth
          Container(color: Colors.black.withValues(alpha: 0.25)),
          // Status bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Row(
                children: [
                  Text(
                    '11:11',
                    style: GoogleFonts.urbanist(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      const Icon(LucideIcons.wifi, color: Colors.white, size: 16),
                      const SizedBox(width: 8),
                      const Icon(
                        LucideIcons.battery,
                        color: Colors.white,
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // Floating banners
          Positioned(
            top: 200,
            left: 20,
            right: 20,
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
            top: 310,
            left: 20,
            right: 20,
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
            top: 420,
            left: 20,
            right: 20,
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
            top: 530,
            left: 20,
            right: 20,
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
          // Back button
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 16, top: 48),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.surfaceBorderLight,
                        ),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 16,
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
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 14),
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
              // Icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: iconBgColors,
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.urbanist(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.75),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                LucideIcons.chevronRight,
                color: Colors.white.withValues(alpha: 0.55),
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
