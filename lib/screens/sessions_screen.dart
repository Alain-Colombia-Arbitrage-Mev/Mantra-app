import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

class SessionsScreen extends StatelessWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(32),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ScreenNav(
                  title: 'Sesiones Privadas',
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
                      LucideIcons.calendar,
                      color: Colors.white,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(28)),
                const SectionLabel('GUÍAS ESPIRITUALES DISPONIBLES'),
                SizedBox(height: Responsive.h(12)),
                _GuideCard(
                  avatarColor: AppColors.primary,
                  icon: LucideIcons.user,
                  name: 'Maestro David',
                  subtitle: 'Cábala · Meditación · 15 años',
                  badgeText: 'Disponible hoy',
                  badgeColor: AppColors.mint,
                  pulsing: false,
                ),
                SizedBox(height: Responsive.h(10)),
                _GuideCard(
                  avatarColor: AppColors.mint,
                  icon: LucideIcons.user,
                  name: 'Dra. Sarah',
                  subtitle: 'Bio-Resonancia · Healing · 12 años',
                  badgeText: 'Próxima: Mañana',
                  badgeColor: AppColors.amber,
                  pulsing: false,
                ),
                SizedBox(height: Responsive.h(10)),
                _GuideCard(
                  avatarColor: AppColors.gold,
                  icon: LucideIcons.user,
                  name: 'Rav Moisés',
                  subtitle: 'Tehilim · Rituales · 20 años',
                  badgeText: 'Disponible ahora',
                  badgeColor: AppColors.mint,
                  pulsing: true,
                ),
                SizedBox(height: Responsive.h(24)),
                const SectionLabel('TU PRÓXIMA SESIÓN'),
                SizedBox(height: Responsive.h(12)),
                GlassCard(
                  padding: EdgeInsets.zero,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: Responsive.w(4),
                        decoration: BoxDecoration(
                          gradient: AppGradients.primaryButton,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(Responsive.w(16)),
                            bottomLeft: Radius.circular(Responsive.w(16)),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(Responsive.w(16)),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Meditación Theta Guiada',
                                      style: GoogleFonts.urbanist(
                                        fontSize: Responsive.sp(15),
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    SizedBox(height: Responsive.h(4)),
                                    Text(
                                      'Con Maestro David · Mañana 10:00 AM',
                                      style: GoogleFonts.urbanist(
                                        fontSize: Responsive.sp(13),
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                    SizedBox(height: Responsive.h(8)),
                                    Row(
                                      children: [
                                        Icon(
                                          LucideIcons.clock,
                                          size: Responsive.w(13),
                                          color: AppColors.primaryLight,
                                        ),
                                        SizedBox(width: Responsive.w(4)),
                                        Text(
                                          '45 min · Zoom',
                                          style: GoogleFonts.urbanist(
                                            fontSize: Responsive.sp(12),
                                            fontWeight: FontWeight.w600,
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
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(24)),
                Container(
                  width: double.infinity,
                  height: Responsive.h(56),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryButton,
                    borderRadius: BorderRadius.circular(Responsive.w(16)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: Responsive.w(20),
                        offset: Offset(0, Responsive.h(8)),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(Responsive.w(16)),
                      onTap: () => context.push('/book-session'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Reservar nueva sesión',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(16),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: Responsive.w(10)),
                          Icon(
                            LucideIcons.calendar,
                            color: Colors.white,
                            size: Responsive.w(18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(16)),
                Center(
                  child: Text(
                    'Sesiones completadas: 12 · Racha: 4 semanas',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      color: AppColors.textSecondary,
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

class _GuideCard extends StatelessWidget {
  final Color avatarColor;
  final IconData icon;
  final String name;
  final String subtitle;
  final String badgeText;
  final Color badgeColor;
  final bool pulsing;

  const _GuideCard({
    required this.avatarColor,
    required this.icon,
    required this.name,
    required this.subtitle,
    required this.badgeText,
    required this.badgeColor,
    required this.pulsing,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/book-session'),
      child: GlassCard(
      child: Row(
        children: [
          Container(
            width: Responsive.w(48),
            height: Responsive.w(48),
            decoration: BoxDecoration(
              color: avatarColor.withValues(alpha: 0.25),
              shape: BoxShape.circle,
              border: Border.all(
                color: avatarColor.withValues(alpha: 0.5),
              ),
            ),
            child: Icon(icon, color: avatarColor, size: Responsive.w(22)),
          ),
          SizedBox(width: Responsive.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
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
                    fontSize: Responsive.sp(12),
                    color: AppColors.textTertiary,
                  ),
                ),
                SizedBox(height: Responsive.h(6)),
                Row(
                  children: [
                    if (pulsing)
                      _PulsingDot(color: badgeColor)
                    else
                      const SizedBox.shrink(),
                    if (pulsing) SizedBox(width: Responsive.w(6)),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: Responsive.w(8),
                        vertical: Responsive.h(3),
                      ),
                      decoration: BoxDecoration(
                        color: badgeColor.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(Responsive.w(50)),
                        border: Border.all(
                          color: badgeColor.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        badgeText,
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(11),
                          fontWeight: FontWeight.w600,
                          color: badgeColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: Responsive.w(8)),
          Icon(
            LucideIcons.chevronRight,
            color: AppColors.textMuted,
            size: Responsive.w(20),
          ),
        ],
      ),
    ),
    );
  }
}

class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, _) => Container(
        width: Responsive.w(8),
        height: Responsive.w(8),
        decoration: BoxDecoration(
          color: widget.color.withValues(alpha: _anim.value),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
