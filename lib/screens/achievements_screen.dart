import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

class AchievementsScreen extends StatelessWidget {
  const AchievementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenNav(
                  title: 'Mis Logros',
                  showBack: true,
                  trailing: Container(
                    width: Responsive.w(36),
                    height: Responsive.w(36),
                    decoration: BoxDecoration(
                      color: AppColors.amber.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.amber.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Icon(
                      LucideIcons.trophy,
                      color: AppColors.amber,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(24)),
                Container(
                  padding: EdgeInsets.all(Responsive.w(20)),
                  decoration: BoxDecoration(
                    color: AppColors.amber.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(Responsive.w(20)),
                    border: Border.all(
                      color: AppColors.amber.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: Responsive.w(48),
                            height: Responsive.w(48),
                            decoration: BoxDecoration(
                              color: AppColors.amber.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LucideIcons.flame,
                              color: AppColors.amber,
                              size: Responsive.w(22),
                            ),
                          ),
                          SizedBox(width: Responsive.w(16)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '21 días',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(28),
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Racha activa · Tu récord: 34 días',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(13),
                                    color: const Color(0xCCFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.w(10),
                              vertical: Responsive.h(5),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.amber.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(Responsive.w(20)),
                            ),
                            child: Text(
                              '62% al récord',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(12),
                                fontWeight: FontWeight.w700,
                                color: AppColors.amber,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(16)),
                Row(
                  children: [
                    _MiniStat(value: '47', label: 'Sesiones'),
                    SizedBox(width: Responsive.w(10)),
                    _MiniStat(value: '128h', label: 'Meditadas'),
                    SizedBox(width: Responsive.w(10)),
                    _MiniStat(value: '2.3k', label: 'Comunidad'),
                  ],
                ),
                SizedBox(height: Responsive.h(28)),
                const SectionLabel('TUS INSIGNIAS'),
                SizedBox(height: Responsive.h(14)),
                GridView.count(
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: Responsive.w(10),
                  mainAxisSpacing: Responsive.h(10),
                  children: const [
                    _BadgeCard(
                      name: 'Newbie',
                      subtitle: '01 logrado',
                      color: AppColors.mint,
                      icon: LucideIcons.star,
                      earned: true,
                    ),
                    _BadgeCard(
                      name: 'Soul Walker',
                      subtitle: 'x7 sesiones',
                      color: AppColors.primary,
                      icon: LucideIcons.footprints,
                      earned: true,
                    ),
                    _BadgeCard(
                      name: 'Sanador',
                      subtitle: '528 freq',
                      color: AppColors.tealMid,
                      icon: LucideIcons.heart,
                      earned: true,
                    ),
                    _BadgeCard(
                      name: 'Luna llena',
                      subtitle: '0/03 noches',
                      color: AppColors.textTertiary,
                      icon: LucideIcons.moon,
                      earned: false,
                    ),
                    _BadgeCard(
                      name: 'Bio-Hacker',
                      subtitle: '05/21 días',
                      color: AppColors.textTertiary,
                      icon: LucideIcons.brain,
                      earned: false,
                    ),
                    _BadgeCard(
                      name: 'Maestro',
                      subtitle: '19/50 horas',
                      color: AppColors.textTertiary,
                      icon: LucideIcons.graduationCap,
                      earned: false,
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(28)),
                const SectionLabel('PRÓXIMO LOGRO'),
                SizedBox(height: Responsive.h(14)),
                Container(
                  padding: EdgeInsets.all(Responsive.w(18)),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(Responsive.w(16)),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: Responsive.w(44),
                            height: Responsive.w(44),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LucideIcons.brain,
                              color: AppColors.primaryLight,
                              size: Responsive.w(20),
                            ),
                          ),
                          SizedBox(width: Responsive.w(14)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Bio-Hacker · Nivel 1',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(15),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  'Completa 21 días seguidos de meditación',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(12),
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.h(14)),
                      Row(
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Responsive.w(4)),
                              child: LinearProgressIndicator(
                                value: 0.64,
                                backgroundColor:
                                    AppColors.white.withValues(alpha: 0.1),
                                valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.primary,
                                ),
                                minHeight: Responsive.h(6),
                              ),
                            ),
                          ),
                          SizedBox(width: Responsive.w(12)),
                          Text(
                            '64%',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryLight,
                            ),
                          ),
                        ],
                      ),
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

class _MiniStat extends StatelessWidget {
  final String value;
  final String label;

  const _MiniStat({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          border: Border.all(color: AppColors.surfaceBorderLight),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(18),
                fontWeight: FontWeight.w800,
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
      ),
    );
  }
}

class _BadgeCard extends StatelessWidget {
  final String name;
  final String subtitle;
  final Color color;
  final IconData icon;
  final bool earned;

  const _BadgeCard({
    required this.name,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.earned,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(12)),
      decoration: BoxDecoration(
        color: earned
            ? color.withValues(alpha: 0.12)
            : AppColors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(
          color: earned
              ? color.withValues(alpha: 0.35)
              : AppColors.white.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: Responsive.w(44),
                height: Responsive.w(44),
                decoration: BoxDecoration(
                  color: earned
                      ? color.withValues(alpha: 0.2)
                      : AppColors.white.withValues(alpha: 0.06),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: earned ? color : AppColors.textMuted,
                  size: Responsive.w(20),
                ),
              ),
              if (!earned)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: Responsive.w(18),
                    height: Responsive.w(18),
                    decoration: BoxDecoration(
                      color: AppColors.backgroundEnd,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.lock,
                      color: AppColors.textTertiary,
                      size: Responsive.w(10),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: Responsive.h(8)),
          Text(
            name,
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              fontSize: Responsive.sp(12),
              fontWeight: FontWeight.w700,
              color: earned ? Colors.white : AppColors.textTertiary,
            ),
          ),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: GoogleFonts.urbanist(
              fontSize: Responsive.sp(10),
              color: earned
                  ? color.withValues(alpha: 0.85)
                  : AppColors.textMuted,
            ),
          ),
        ],
      ),
    );
  }
}
