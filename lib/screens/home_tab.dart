import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';
import '../services/clock_service.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  static String _formatTime(DateTime now) {
    final h = now.hour.toString().padLeft(2, '0');
    final m = now.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  static String _formatDate(DateTime now) {
    const weekdays = [
      'Lunes', 'Martes', 'Miércoles', 'Jueves',
      'Viernes', 'Sábado', 'Domingo',
    ];
    const months = [
      'Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
      'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre',
    ];
    final weekday = weekdays[now.weekday - 1];
    final month = months[now.month - 1];
    return '$weekday, ${now.day} De $month';
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(Responsive.pagePadding, Responsive.h(20), Responsive.pagePadding, Responsive.bottomNavPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ──────────────────────────────────────────────
              Row(
                children: [
                  Image.asset(
                    'assets/images/logomantra.png',
                    width: Responsive.w(32),
                    height: Responsive.w(32),
                  ),
                  SizedBox(width: Responsive.w(8)),
                  Text(
                    'Mantras',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(20),
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => context.push('/mirror-hours'),
                    child: Container(
                      width: Responsive.w(40),
                      height: Responsive.w(40),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.08),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surfaceBorderLight),
                      ),
                      child: Icon(
                        LucideIcons.timer,
                        color: Colors.white,
                        size: Responsive.w(18),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.h(32)),

              // ── Clock ───────────────────────────────────────────────
              ValueListenableBuilder<DateTime>(
                valueListenable: ClockService.instance.now,
                builder: (context, now, _) {
                  return Column(
                    children: [
                      Center(
                        child: Text(
                          _formatTime(now),
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(72),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.0,
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(4)),
                      Center(
                        child: Text(
                          _formatDate(now),
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(16),
                            color: const Color(0xCCFFFFFF),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: Responsive.h(28)),

              // ── Session Card ────────────────────────────────────────
              GestureDetector(
              onTap: () => context.push('/daily-ritual'),
              child: Container(
                padding: EdgeInsets.all(Responsive.w(18)),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF2D1B69), Color(0xFF1A0F40)],
                  ),
                  borderRadius: BorderRadius.circular(Responsive.w(18)),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: Responsive.w(44),
                      height: Responsive.w(44),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.sparkles,
                        color: AppColors.primaryLight,
                        size: Responsive.w(22),
                      ),
                    ),
                    SizedBox(width: Responsive.w(14)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tu sesión de bio-hacking te espera',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(15),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: Responsive.h(3)),
                          Text(
                            '3 min · Ondas Theta · Manifiesta ahora',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      LucideIcons.chevronRight,
                      color: AppColors.primaryLight,
                      size: Responsive.w(20),
                    ),
                  ],
                ),
              ),
              ),
              SizedBox(height: Responsive.h(16)),

              // ── Stats Row ───────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.push('/sleep'),
                      child: GlassCard(
                        padding: EdgeInsets.all(Responsive.w(14)),
                        child: Row(
                          children: [
                            Container(
                              width: Responsive.w(36),
                              height: Responsive.w(36),
                              decoration: BoxDecoration(
                                color: AppColors.lunar.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                LucideIcons.brain,
                                color: AppColors.lunar,
                                size: Responsive.w(18),
                              ),
                            ),
                            SizedBox(width: Responsive.w(10)),
                            Expanded(
                              child: Text(
                                '12.5h en\nondas Theta',
                                style: GoogleFonts.urbanist(
                                  fontSize: Responsive.sp(13),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.w(12)),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.push('/agenda'),
                      child: GlassCard(
                        padding: EdgeInsets.all(Responsive.w(14)),
                        child: Row(
                          children: [
                            Container(
                              width: Responsive.w(36),
                              height: Responsive.w(36),
                              decoration: BoxDecoration(
                                color: AppColors.amber.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                LucideIcons.zap,
                                color: AppColors.amber,
                                size: Responsive.w(18),
                              ),
                            ),
                            SizedBox(width: Responsive.w(10)),
                            Expanded(
                              child: Text(
                                '47 días de\nracha activa',
                                style: GoogleFonts.urbanist(
                                  fontSize: Responsive.sp(13),
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  height: 1.3,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.h(24)),

              // ── Quick Actions ───────────────────────────────────────
              const SectionLabel('ACCIONES RÁPIDAS'),
              SizedBox(height: Responsive.h(12)),

              _ActionCard(
                title: 'El Alquimista',
                subtitle: 'Genera tu audio con IA · Voz clonada',
                icon: LucideIcons.mic,
                accentColor: AppColors.primary,
                onTap: () => context.push('/alchemist'),
              ),
              SizedBox(height: Responsive.h(10)),
              _ActionCard(
                title: 'Marketplace',
                subtitle: '8 nuevos audios · Mercado social',
                icon: LucideIcons.shoppingBag,
                accentColor: AppColors.mint,
                onTap: () => context.push('/marketplace'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;
  final VoidCallback? onTap;

  const _ActionCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.w(42),
            height: Responsive.w(42),
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: accentColor, size: Responsive.w(20)),
          ),
          SizedBox(width: Responsive.w(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(15),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Responsive.h(2)),
                Text(
                  subtitle,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(13),
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            LucideIcons.chevronRight,
            color: AppColors.textTertiary,
            size: Responsive.w(18),
          ),
        ],
      ),
    ),
    );
  }
}
