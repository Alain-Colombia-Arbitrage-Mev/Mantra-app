import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xF0060612), Color(0xF00F0A2A)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Nav ─────────────────────────────────────────────────
                ScreenNav(
                  title: 'Duerme · Delta',
                  showBack: true,
                  trailing: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surfaceBorderLight),
                    ),
                    child: const Icon(
                      LucideIcons.settings,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ── Section label ────────────────────────────────────────
                const SectionLabel('SESIÓN DE SUEÑO BIO-HAK'),
                const SizedBox(height: 14),

                // ── 3 stat cards ─────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: LucideIcons.moon,
                        iconColor: AppColors.primaryLight,
                        value: '5h 30m',
                        label: 'Sueño',
                        fillColor: AppColors.white.withValues(alpha: 0.1),
                        borderColor: AppColors.surfaceBorderLight,
                        isSelected: false,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        icon: LucideIcons.zap,
                        iconColor: AppColors.primary,
                        value: '1h 10m',
                        label: 'Theta',
                        fillColor: AppColors.primary.withValues(alpha: 0.2),
                        borderColor: AppColors.primary,
                        isSelected: true,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _StatCard(
                        icon: LucideIcons.star,
                        iconColor: AppColors.amber,
                        value: '3h 30m',
                        label: 'Calidad',
                        fillColor: AppColors.white.withValues(alpha: 0.1),
                        borderColor: AppColors.surfaceBorderLight,
                        isSelected: false,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // ── Brain waves chart card ───────────────────────────────
                Container(
                  width: double.infinity,
                  height: 160,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionLabel('ONDAS CEREBRALES · ESTA NOCHE'),
                      const SizedBox(height: 16),
                      // Progress bar
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.67,
                            child: Container(
                              height: 6,
                              decoration: BoxDecoration(
                                gradient: AppGradients.primaryButton,
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ),
                          // Glowing dot at 67%
                          FractionallySizedBox(
                            widthFactor: 0.67,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: 14,
                                height: 14,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryLight
                                          .withValues(alpha: 0.6),
                                      blurRadius: 8,
                                      spreadRadius: 2,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      // Time labels
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _timeLabel('22:00'),
                          _timeLabel('00:00'),
                          _timeLabel('03:00'),
                          _timeLabel('06:30'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Program label ────────────────────────────────────────
                const SectionLabel('PROGRAMA ESTA NOCHE'),
                const SizedBox(height: 12),

                // Program card 1 — active
                _ProgramCard(
                  icon: LucideIcons.moon,
                  iconColor: AppColors.primaryLight,
                  title: 'Inducción al Sueño Profundo',
                  subtitle: 'Delta 0.3-4Hz · 8 Horas · Activa ahora',
                  fillColor: AppColors.primary.withValues(alpha: 0.2),
                  borderColor: AppColors.primary,
                  isActive: true,
                ),
                const SizedBox(height: 8),

                // Program card 2 — inactive
                _ProgramCard(
                  icon: LucideIcons.brain,
                  iconColor: AppColors.white.withValues(alpha: 0.5),
                  title: 'Reparación Celular · 528Hz',
                  subtitle: 'Solfeggio · 02:00 – 04:00 · Bio-Hack',
                  fillColor: AppColors.white.withValues(alpha: 0.05),
                  borderColor: AppColors.surfaceBorderLight,
                  isActive: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _timeLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.urbanist(
        fontSize: 11,
        color: AppColors.textTertiary,
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;
  final Color fillColor;
  final Color borderColor;
  final bool isSelected;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
    required this.fillColor,
    required this.borderColor,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.urbanist(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.urbanist(
              fontSize: 11,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgramCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Color fillColor;
  final Color borderColor;
  final bool isActive;

  const _ProgramCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.fillColor,
    required this.borderColor,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (isActive) ...[
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                gradient: AppGradients.primaryButton,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'ON',
                style: GoogleFonts.urbanist(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
