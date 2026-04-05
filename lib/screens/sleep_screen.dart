import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

class SleepScreen extends StatelessWidget {
  const SleepScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
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
            padding: EdgeInsets.fromLTRB(
              Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(48),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenNav(
                  title: 'Duerme · Delta',
                  showBack: true,
                  trailing: Container(
                    width: Responsive.w(36),
                    height: Responsive.w(36),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surfaceBorderLight),
                    ),
                    child: Icon(
                      LucideIcons.settings,
                      color: Colors.white,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(24)),
                const SectionLabel('SESIÓN DE SUEÑO BIO-HAK'),
                SizedBox(height: Responsive.h(14)),
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
                    SizedBox(width: Responsive.w(10)),
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
                    SizedBox(width: Responsive.w(10)),
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
                SizedBox(height: Responsive.h(20)),
                Container(
                  width: double.infinity,
                  height: Responsive.h(160),
                  padding: EdgeInsets.all(Responsive.w(16)),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(Responsive.w(20)),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SectionLabel('ONDAS CEREBRALES · ESTA NOCHE'),
                      SizedBox(height: Responsive.h(16)),
                      Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            width: double.infinity,
                            height: Responsive.h(6),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(Responsive.w(3)),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.67,
                            child: Container(
                              height: Responsive.h(6),
                              decoration: BoxDecoration(
                                gradient: AppGradients.primaryButton,
                                borderRadius: BorderRadius.circular(Responsive.w(3)),
                              ),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.67,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                width: Responsive.w(14),
                                height: Responsive.w(14),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primaryLight
                                          .withValues(alpha: 0.6),
                                      blurRadius: Responsive.w(8),
                                      spreadRadius: Responsive.w(2),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.h(12)),
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
                SizedBox(height: Responsive.h(24)),
                const SectionLabel('PROGRAMA ESTA NOCHE'),
                SizedBox(height: Responsive.h(12)),
                _ProgramCard(
                  icon: LucideIcons.moon,
                  iconColor: AppColors.primaryLight,
                  title: 'Inducción al Sueño Profundo',
                  subtitle: 'Delta 0.3-4Hz · 8 Horas · Activa ahora',
                  fillColor: AppColors.primary.withValues(alpha: 0.2),
                  borderColor: AppColors.primary,
                  isActive: true,
                ),
                SizedBox(height: Responsive.h(8)),
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
        fontSize: Responsive.sp(11),
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
      height: Responsive.h(88),
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(12), vertical: Responsive.h(14),
      ),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: Responsive.w(20)),
          SizedBox(height: Responsive.h(6)),
          Text(
            value,
            style: GoogleFonts.urbanist(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
          Text(
            label,
            style: GoogleFonts.urbanist(
              fontSize: Responsive.sp(11),
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
    return GestureDetector(
      onTap: () => context.push('/player'),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(16)),
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(Responsive.w(16)),
          border: Border.all(color: borderColor),
        ),
        child: Row(
          children: [
            Container(
              width: Responsive.w(44),
              height: Responsive.w(44),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(Responsive.w(12)),
              ),
              child: Icon(icon, color: iconColor, size: Responsive.w(22)),
            ),
            SizedBox(width: Responsive.w(14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(14),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Responsive.h(3)),
                  Text(
                    subtitle,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (isActive) ...[
              SizedBox(width: Responsive.w(10)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(10), vertical: Responsive.h(4),
                ),
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryButton,
                  borderRadius: BorderRadius.circular(Responsive.w(20)),
                ),
                child: Text(
                  'ON',
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(11),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
