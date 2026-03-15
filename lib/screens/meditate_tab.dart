import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/screen_bg.dart';

class MeditateTab extends StatelessWidget {
  const MeditateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 54),

              // ── Header ───────────────────────────────────────────────
              Row(
                children: [
                  const Icon(
                    LucideIcons.chevronLeft,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 52),
                  Text(
                    'Meditar',
                    style: GoogleFonts.urbanist(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.push('/search'),
                    child: const Icon(
                      LucideIcons.slidersHorizontal,
                      color: Color(0xCCFFFFFF),
                      size: 24,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 64), // y:118 - y:54 = 64

              // ── Recommended label ────────────────────────────────────
              Text(
                '⚡ RECOMENDADO POR TU PERFIL CEREBRAL',
                style: GoogleFonts.urbanist(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              const SizedBox(height: 22), // y:140 - y:118 = 22

              // ── Featured card ────────────────────────────────────────
              GestureDetector(
                onTap: () => context.push('/player'),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color(0xCC6C5CE7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(LucideIcons.sparkles, color: Color(0xFFFFEAA7), size: 28),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Activa la Abundancia · Ondas Theta',
                              style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '12 min · Theta 4-7Hz · ★4.8 · 2.3k bio-hackers',
                              style: GoogleFonts.urbanist(fontSize: 13, color: const Color(0xCCFFEAA7)),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(color: Color(0x33FFFFFF), shape: BoxShape.circle),
                        child: const Icon(LucideIcons.play, color: Colors.white, size: 18),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 114), // y:254 - y:140 = 114

              // ── Grid label ───────────────────────────────────────────
              Text(
                '¿QUÉ DESEAS REPROGRAMAR HOY?',
                style: GoogleFonts.urbanist(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              const SizedBox(height: 24), // y:278 - y:254 = 24

              // ── Grid Row 1 ───────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _MeditateCard(
                      icon: LucideIcons.sunrise,
                      iconColor: const Color(0xFFF9A826),
                      fill: const Color(0x33F9A826),
                      title: 'Despierta',
                      subtitle: '8 min · Alpha',
                      stateText: 'Vikshipta',
                      stateColor: const Color(0xCCF9A826),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MeditateCard(
                      icon: LucideIcons.crosshair,
                      iconColor: const Color(0xFF00CEC9),
                      fill: const Color(0x3300CEC9),
                      title: 'Enfoca',
                      subtitle: '12 min · Gamma',
                      stateText: 'Ekagra',
                      stateColor: const Color(0xCC00CEC9),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MeditateCard(
                      icon: LucideIcons.heart,
                      iconColor: const Color(0xFF55EFC4),
                      fill: const Color(0x3355EFC4),
                      title: 'Sana',
                      subtitle: '20 min · Delta',
                      stateText: 'Dharana',
                      stateColor: const Color(0xCC55EFC4),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ── Grid Row 2 ────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _MeditateCard(
                      icon: LucideIcons.moon,
                      iconColor: const Color(0xFFA29BFE),
                      fill: const Color(0x1AFFFFFF),
                      title: 'Duerme',
                      subtitle: '30 min · Delta',
                      stateText: 'Niruddha',
                      stateColor: const Color(0xCCA29BFE),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MeditateCard(
                      icon: LucideIcons.infinity,
                      iconColor: const Color(0xFF6C5CE7),
                      fill: const Color(0x336C5CE7),
                      title: 'Trasciende',
                      subtitle: '25 min · Theta',
                      stateText: 'Ekagra',
                      stateColor: const Color(0xCC6C5CE7),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _MeditateCard(
                      icon: LucideIcons.zap,
                      iconColor: const Color(0xFFfd7960),
                      fill: const Color(0x33fd7960),
                      title: 'Express',
                      subtitle: '5 min · Beta',
                      stateText: 'Vikshipta',
                      stateColor: const Color(0xCCfd7960),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Método Silva banner ───────────────────────────────────
              GestureDetector(
                onTap: () => context.push('/silva'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xCC008180), Color(0xCC6C5CE7)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.brain,
                        color: Color(0xFF55EFC4),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Método Silva',
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '6 técnicas de control mental',
                              style: GoogleFonts.urbanist(
                                fontSize: 12,
                                color: const Color(0xCCFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        LucideIcons.chevronRight,
                        color: Colors.white,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MeditateCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color fill;
  final String title;
  final String subtitle;
  final String stateText;
  final Color stateColor;

  const _MeditateCard({
    required this.icon,
    required this.iconColor,
    required this.fill,
    required this.title,
    required this.subtitle,
    required this.stateText,
    required this.stateColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/player'),
      child: Container(
      height: 120,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Icon at (16, 16)
          Positioned(
            left: 16,
            top: 16,
            child: Icon(icon, color: iconColor, size: 28),
          ),
          // Title at (12, 56)
          Positioned(
            left: 12,
            top: 56,
            right: 4,
            child: Text(
              title,
              style: GoogleFonts.urbanist(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Subtitle at (12, 76)
          Positioned(
            left: 12,
            top: 76,
            right: 4,
            child: Text(
              subtitle,
              style: GoogleFonts.urbanist(
                fontSize: 11,
                color: const Color(0xAAFFFFFF),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // State text at (12, 96)
          Positioned(
            left: 12,
            top: 96,
            right: 4,
            child: Text(
              stateText,
              style: GoogleFonts.urbanist(
                fontSize: 10,
                color: stateColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      ),
    );
  }
}
