import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class DailyRitualScreen extends StatefulWidget {
  const DailyRitualScreen({super.key});

  @override
  State<DailyRitualScreen> createState() => _DailyRitualScreenState();
}

class _DailyRitualScreenState extends State<DailyRitualScreen> {
  final List<bool> _checked = [false, false, false];

  static const List<_Task> _tasks = [
    _Task(LucideIcons.brain, 'Meditar', '5 min', Color(0xFF6C5CE7)),
    _Task(LucideIcons.sparkles, 'Afirmación', '3 min', Color(0xFFFFD700)),
    _Task(LucideIcons.heart, 'Gratitud', '2 min', Color(0xFF55EFC4)),
  ];

  int get _completedCount => _checked.where((c) => c).length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surfaceBorderLight,
                          ),
                        ),
                        child: const Icon(
                          LucideIcons.chevronLeft,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 28),

                // ── Greeting ─────────────────────────────────────────────
                Text(
                  'Buenos días,',
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Tu Nombre',
                  style: GoogleFonts.urbanist(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 24),

                // ── Today's intention ────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.primary.withValues(alpha: 0.2),
                        AppColors.gold.withValues(alpha: 0.1),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            LucideIcons.sun,
                            color: AppColors.gold,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'INTENCIÓN DEL DÍA',
                            style: GoogleFonts.urbanist(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: AppColors.gold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '"Hoy actúo con gratitud y atraigo todo lo que necesito"',
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.white,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Daily tasks label ────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'RITUAL DE HOY',
                      style: GoogleFonts.urbanist(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        color: AppColors.textTertiary,
                      ),
                    ),
                    Text(
                      '$_completedCount/3',
                      style: GoogleFonts.urbanist(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // ── Tasks ────────────────────────────────────────────────
                ...List.generate(_tasks.length, (i) {
                  final t = _tasks[i];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () => setState(() => _checked[i] = !_checked[i]),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: _checked[i]
                              ? t.color.withValues(alpha: 0.1)
                              : AppColors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: _checked[i]
                                ? t.color.withValues(alpha: 0.4)
                                : AppColors.surfaceBorderLight,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: t.color.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(t.icon, color: t.color, size: 20),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t.title,
                                    style: GoogleFonts.urbanist(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                      decoration: _checked[i]
                                          ? TextDecoration.lineThrough
                                          : null,
                                      decorationColor: AppColors.textTertiary,
                                    ),
                                  ),
                                  Text(
                                    t.duration,
                                    style: GoogleFonts.urbanist(
                                      fontSize: 12,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: _checked[i]
                                    ? t.color
                                    : Colors.transparent,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: _checked[i]
                                      ? t.color
                                      : AppColors.surfaceBorderLight,
                                  width: 2,
                                ),
                              ),
                              child: _checked[i]
                                  ? const Icon(
                                      LucideIcons.check,
                                      color: Colors.white,
                                      size: 13,
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),

                // ── Stats row ────────────────────────────────────────────
                Row(
                  children: [
                    Expanded(
                      child: _StatCard(
                        icon: LucideIcons.flame,
                        iconColor: AppColors.amber,
                        value: '14',
                        label: 'Días racha',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: LucideIcons.clock,
                        iconColor: AppColors.primaryLight,
                        value: '10',
                        label: 'Min hoy',
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _StatCard(
                        icon: LucideIcons.star,
                        iconColor: AppColors.gold,
                        value: '98',
                        label: 'Total min',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // ── CTA ──────────────────────────────────────────────────
                GestureDetector(
                  onTap: () => context.push('/player'),
                  child: Container(
                    width: double.infinity,
                    height: 58,
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryButton,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          LucideIcons.play,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Comenzar ritual matutino',
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
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

class _Task {
  final IconData icon;
  final String title;
  final String duration;
  final Color color;

  const _Task(this.icon, this.title, this.duration, this.color);
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.iconColor,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Column(
        children: [
          Icon(icon, color: iconColor, size: 20),
          const SizedBox(height: 6),
          Text(
            value,
            style: GoogleFonts.urbanist(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Colors.white,
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
      ),
    );
  }
}
