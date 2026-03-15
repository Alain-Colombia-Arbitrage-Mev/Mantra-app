import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class AgendaScreen extends StatelessWidget {
  const AgendaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: ScreenBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
                ScreenNav(
                  title: 'Mi Agenda de Sesiones',
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
                      LucideIcons.calendar,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Esta semana ──────────────────────────────────────────
                const SectionLabel('ESTA SEMANA'),
                const SizedBox(height: 12),

                _UpcomingCard(
                  timeLabel: 'Hoy · 10:00 AM',
                  title: 'Meditación Theta · Maestro David',
                  detail: '45 min · Zoom',
                  accentColor: AppColors.primary,
                  badge: 'Hoy',
                  badgeColor: AppColors.mint,
                  isToday: true,
                ),
                const SizedBox(height: 8),
                _UpcomingCard(
                  timeLabel: 'Miércoles · 14:00',
                  title: 'Bio-Resonancia · Dra. Sarah',
                  detail: '30 min · Presencial',
                  accentColor: AppColors.mint,
                  badge: null,
                  badgeColor: Colors.transparent,
                  isToday: false,
                ),
                const SizedBox(height: 8),
                _UpcomingCard(
                  timeLabel: 'Viernes · 09:00',
                  title: 'Tehilim · Rav Moisés',
                  detail: '20 min · Zoom',
                  accentColor: AppColors.gold,
                  badge: null,
                  badgeColor: Colors.transparent,
                  isToday: false,
                ),
                const SizedBox(height: 24),

                // ── Historial reciente ───────────────────────────────────
                const SectionLabel('HISTORIAL RECIENTE'),
                const SizedBox(height: 12),

                _PastCard(
                  dateLabel: 'Lunes 10 Mar · Completada',
                  title: 'Meditación · 45 min',
                  completed: true,
                ),
                const SizedBox(height: 8),
                _PastCard(
                  dateLabel: 'Sábado 8 Mar · Completada',
                  title: 'Healing · 30 min',
                  completed: true,
                ),
                const SizedBox(height: 8),
                _PastCard(
                  dateLabel: 'Jueves 6 Mar · Cancelada',
                  title: 'Tehilim · 20 min',
                  completed: false,
                ),
                const SizedBox(height: 24),

                // ── Stats row ────────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.surfaceBorderLight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _StatItem(value: '12', label: 'sesiones'),
                      _Divider(),
                      _StatItem(value: '4', label: 'semanas racha'),
                      _Divider(),
                      _StatItem(value: '8.5h', label: 'total'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _UpcomingCard extends StatelessWidget {
  final String timeLabel;
  final String title;
  final String detail;
  final Color accentColor;
  final String? badge;
  final Color badgeColor;
  final bool isToday;

  const _UpcomingCard({
    required this.timeLabel,
    required this.title,
    required this.detail,
    required this.accentColor,
    required this.badge,
    required this.badgeColor,
    required this.isToday,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.primary.withValues(alpha: 0.1)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isToday
              ? AppColors.primary.withValues(alpha: 0.3)
              : AppColors.surfaceBorderLight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left accent bar
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          timeLabel,
                          style: GoogleFonts.urbanist(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textTertiary,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          title,
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Row(
                          children: [
                            Icon(
                              LucideIcons.clock,
                              size: 12,
                              color: AppColors.textTertiary,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              detail,
                              style: GoogleFonts.urbanist(
                                fontSize: 12,
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  if (badge != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: badgeColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        badge!,
                        style: GoogleFonts.urbanist(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: badgeColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PastCard extends StatelessWidget {
  final String dateLabel;
  final String title;
  final bool completed;

  const _PastCard({
    required this.dateLabel,
    required this.title,
    required this.completed,
  });

  @override
  Widget build(BuildContext context) {
    final accentColor =
        completed ? AppColors.mint : AppColors.danger;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Left accent bar
          Container(
            width: 4,
            decoration: BoxDecoration(
              color: accentColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              dateLabel,
                              style: GoogleFonts.urbanist(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textMuted,
                              ),
                            ),
                            if (completed) ...[
                              const SizedBox(width: 4),
                              Icon(
                                LucideIcons.checkCircle,
                                size: 13,
                                color: AppColors.mint
                                    .withValues(alpha: 0.7),
                              ),
                            ],
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          title,
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.urbanist(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: AppColors.primaryLight,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: GoogleFonts.urbanist(
            fontSize: 11,
            color: AppColors.textTertiary,
          ),
        ),
      ],
    );
  }
}

class _Divider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 36,
      color: AppColors.surfaceBorderLight,
    );
  }
}
