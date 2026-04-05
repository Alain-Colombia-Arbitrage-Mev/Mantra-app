import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

class MeditateTab extends StatelessWidget {
  const MeditateTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(Responsive.w(16), 0, Responsive.w(16), Responsive.bottomNavPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.h(16)),

              // ── Header ───────────────────────────────────────────────
              Row(
                children: [
                  Icon(
                    LucideIcons.chevronLeft,
                    color: Colors.white,
                    size: Responsive.w(24),
                  ),
                  SizedBox(width: Responsive.w(52)),
                  Text(
                    'Meditar',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(24),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.push('/search'),
                    child: Icon(
                      LucideIcons.slidersHorizontal,
                      color: const Color(0xCCFFFFFF),
                      size: Responsive.w(24),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Responsive.h(24)),

              // ── Recommended label ────────────────────────────────────
              Text(
                '⚡ RECOMENDADO POR TU PERFIL CEREBRAL',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              SizedBox(height: Responsive.h(22)),

              // ── Featured card ────────────────────────────────────────
              GestureDetector(
                onTap: () => context.push('/player'),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: Responsive.w(16), vertical: Responsive.h(20)),
                  decoration: BoxDecoration(
                    color: const Color(0xCC6C5CE7),
                    borderRadius: BorderRadius.circular(Responsive.w(20)),
                  ),
                  child: Row(
                    children: [
                      Icon(LucideIcons.sparkles, color: const Color(0xFFFFEAA7), size: Responsive.w(28)),
                      SizedBox(width: Responsive.w(14)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Activa la Abundancia · Ondas Theta',
                              style: GoogleFonts.urbanist(fontSize: Responsive.sp(15), fontWeight: FontWeight.w700, color: Colors.white),
                            ),
                            SizedBox(height: Responsive.h(4)),
                            Text(
                              '12 min · Theta 4-7Hz · ★4.8 · 2.3k bio-hackers',
                              style: GoogleFonts.urbanist(fontSize: Responsive.sp(13), color: const Color(0xCCFFEAA7)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: Responsive.w(10)),
                      Container(
                        width: Responsive.w(36),
                        height: Responsive.w(36),
                        decoration: const BoxDecoration(color: Color(0x33FFFFFF), shape: BoxShape.circle),
                        child: Icon(LucideIcons.play, color: Colors.white, size: Responsive.w(18)),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: Responsive.h(28)),

              // ── Grid label ───────────────────────────────────────────
              Text(
                '¿QUÉ DESEAS REPROGRAMAR HOY?',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              SizedBox(height: Responsive.h(24)),

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
                  SizedBox(width: Responsive.w(12)),
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
                  SizedBox(width: Responsive.w(12)),
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

              SizedBox(height: Responsive.h(12)),

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
                  SizedBox(width: Responsive.w(12)),
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
                  SizedBox(width: Responsive.w(12)),
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
              SizedBox(height: Responsive.h(24)),

              // ── Método Silva banner ───────────────────────────────────
              GestureDetector(
                onTap: () => context.push('/silva'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(16), vertical: Responsive.h(14)),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Color(0xCC008180), Color(0xCC6C5CE7)],
                    ),
                    borderRadius: BorderRadius.circular(Responsive.w(16)),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.brain,
                        color: const Color(0xFF55EFC4),
                        size: Responsive.w(24),
                      ),
                      SizedBox(width: Responsive.w(12)),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Método Silva',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(15),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              '6 técnicas de control mental',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(12),
                                color: const Color(0xCCFFFFFF),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(
                        LucideIcons.chevronRight,
                        color: Colors.white,
                        size: Responsive.w(18),
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
      height: Responsive.h(120),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(Responsive.w(20)),
      ),
      child: Stack(
        children: [
          Positioned(
            left: Responsive.w(16),
            top: Responsive.h(16),
            child: Icon(icon, color: iconColor, size: Responsive.w(28)),
          ),
          Positioned(
            left: Responsive.w(12),
            top: Responsive.h(56),
            right: Responsive.w(4),
            child: Text(
              title,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(14),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            left: Responsive.w(12),
            top: Responsive.h(76),
            right: Responsive.w(4),
            child: Text(
              subtitle,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(11),
                color: const Color(0xAAFFFFFF),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Positioned(
            left: Responsive.w(12),
            top: Responsive.h(96),
            right: Responsive.w(4),
            child: Text(
              stateText,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(10),
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
