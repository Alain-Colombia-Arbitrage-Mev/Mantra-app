import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class LunarRitualsScreen extends StatefulWidget {
  const LunarRitualsScreen({super.key});

  @override
  State<LunarRitualsScreen> createState() => _LunarRitualsScreenState();
}

class _LunarRitualsScreenState extends State<LunarRitualsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedPhase = 3;
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulseAnim;

  static const List<String> _phases = [
    'Nueva',
    'Creciente',
    'Cuarto C.',
    'Llena',
    'Menguante',
    'Balsámica',
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F0A2A), Color(0xFF0A0A1A)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: Responsive.h(80),
              left: Responsive.w(-60),
              child: Container(
                width: Responsive.w(260),
                height: Responsive.w(260),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lunar.withValues(alpha: 0.14),
                      blurRadius: Responsive.w(130),
                      spreadRadius: Responsive.w(65),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Responsive.w(20), Responsive.h(16), Responsive.w(20), 0,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            width: Responsive.w(36),
                            height: Responsive.w(36),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.surfaceBorderLight,
                              ),
                            ),
                            child: Icon(
                              LucideIcons.chevronLeft,
                              color: Colors.white,
                              size: Responsive.w(18),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Rituales Lunares',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(17),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: Responsive.w(36),
                          height: Responsive.w(36),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.surfaceBorderLight,
                            ),
                          ),
                          child: Icon(
                            LucideIcons.bell,
                            color: Colors.white,
                            size: Responsive.w(17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        Responsive.w(20), Responsive.h(24), Responsive.w(20), Responsive.h(32),
                      ),
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: Responsive.w(210),
                                height: Responsive.w(210),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.lunar.withValues(
                                      alpha: 0.15,
                                    ),
                                    width: 1,
                                  ),
                                ),
                              ),
                              Container(
                                width: Responsive.w(192),
                                height: Responsive.w(192),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.lunar.withValues(
                                      alpha: 0.25,
                                    ),
                                    width: 1,
                                  ),
                                ),
                              ),
                              Container(
                                width: Responsive.w(180),
                                height: Responsive.w(180),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.lunar.withValues(
                                        alpha: 0.25,
                                      ),
                                      blurRadius: Responsive.w(30),
                                      spreadRadius: Responsive.w(8),
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/lunar_hero.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: Responsive.h(20)),
                          Text(
                            'FASE ACTUAL',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(11),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              color: AppColors.lunar.withValues(alpha: 0.67),
                            ),
                          ),
                          SizedBox(height: Responsive.h(6)),
                          Text(
                            'Luna Llena 🌕',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(28),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: Responsive.h(8)),
                          Text(
                            'La luna llena amplifica la energía, intuición\ny emociones. Momento ideal para rituales\nde gratitud y liberación.',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              color: AppColors.textTertiary,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Responsive.h(20)),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(_phases.length, (i) {
                                final isSelected = i == _selectedPhase;
                                return GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedPhase = i),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    margin: EdgeInsets.only(right: Responsive.w(8)),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: Responsive.w(14),
                                      vertical: Responsive.h(8),
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.lunar.withValues(
                                              alpha: 0.2,
                                            )
                                          : AppColors.surfaceLight,
                                      borderRadius: BorderRadius.circular(Responsive.w(50)),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.lunar
                                            : AppColors.surfaceBorderLight,
                                      ),
                                    ),
                                    child: Text(
                                      _phases[i],
                                      style: GoogleFonts.urbanist(
                                        fontSize: Responsive.sp(12),
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? AppColors.lunar
                                            : AppColors.textTertiary,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          SizedBox(height: Responsive.h(24)),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Rituales recomendados',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(15),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: Responsive.h(12)),
                          _RitualCard(
                            icon: LucideIcons.heart,
                            iconColor: AppColors.mint,
                            title: 'Ritual de gratitud',
                            subtitle: '15 min · Meditación guiada',
                            isPro: false,
                          ),
                          SizedBox(height: Responsive.h(8)),
                          _RitualCard(
                            icon: LucideIcons.flame,
                            iconColor: AppColors.amber,
                            title: 'Ceremonia de liberación',
                            subtitle: '25 min · Meditación + sonido',
                            isPro: true,
                          ),
                          SizedBox(height: Responsive.h(8)),
                          _RitualCard(
                            icon: LucideIcons.moon,
                            iconColor: AppColors.lunar,
                            title: 'Baño de luna',
                            subtitle: '30 min · Práctica física',
                            isPro: false,
                          ),
                          SizedBox(height: Responsive.h(20)),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.w(16),
                              vertical: Responsive.h(12),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lunar.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(Responsive.w(14)),
                              border: Border.all(
                                color: AppColors.lunar.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedBuilder(
                                  animation: _pulseAnim,
                                  builder: (_, __) => Container(
                                    width: Responsive.w(8),
                                    height: Responsive.w(8),
                                    decoration: BoxDecoration(
                                      color: AppColors.lunar.withValues(
                                        alpha: _pulseAnim.value,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                SizedBox(width: Responsive.w(10)),
                                Text(
                                  '1,203 personas meditando bajo la luna',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(13),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lunar,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Responsive.h(20)),
                          GestureDetector(
                            onTap: () => context.push('/notifications-settings'),
                            child: Container(
                              width: double.infinity,
                              height: Responsive.h(58),
                              decoration: BoxDecoration(
                                gradient: AppGradients.primaryButton,
                                borderRadius: BorderRadius.circular(Responsive.w(16)),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: Responsive.w(20),
                                    offset: Offset(0, Responsive.h(8)),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Activar recordatorios lunares',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(16),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RitualCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isPro;

  const _RitualCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isPro,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(Responsive.w(14)),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.w(44),
            height: Responsive.w(44),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Responsive.w(12)),
              border: Border.all(color: iconColor.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: iconColor, size: Responsive.w(20)),
          ),
          SizedBox(width: Responsive.w(12)),
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
          if (isPro)
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(8), vertical: Responsive.h(3),
              ),
              decoration: BoxDecoration(
                gradient: AppGradients.primaryButton,
                borderRadius: BorderRadius.circular(Responsive.w(50)),
              ),
              child: Text(
                'PRO',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(10),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          SizedBox(width: Responsive.w(8)),
          Icon(LucideIcons.chevronRight, color: AppColors.textMuted, size: Responsive.w(18)),
        ],
      ),
    );
  }
}
