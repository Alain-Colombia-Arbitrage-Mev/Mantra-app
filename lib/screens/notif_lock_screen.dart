import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class NotifLockScreen extends StatelessWidget {
  const NotifLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset('assets/images/splash_bg.jpg', fit: BoxFit.cover),
          Container(color: const Color(0xF0060612)),
          Positioned(
            left: Responsive.w(45) - Responsive.w(150),
            top: Responsive.h(200) - Responsive.h(150),
            child: Container(
              width: Responsive.w(300),
              height: Responsive.w(300),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.50),
                    blurRadius: Responsive.w(120),
                    spreadRadius: Responsive.w(40),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: Responsive.w(20)),
              child: Column(
                children: [
                  SizedBox(height: Responsive.h(80)),
                  Text(
                    '11:11',
                    style: GoogleFonts.manrope(
                      fontSize: Responsive.isCompact
                          ? Responsive.sp(64)
                          : Responsive.sp(88),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Responsive.h(20)),
                  Text(
                    'Sábado 21 de Febrero',
                    style: GoogleFonts.manrope(
                      fontSize: Responsive.sp(16),
                      color: const Color(0xAAFFFFFF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Responsive.h(24)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(16),
                      vertical: Responsive.h(12),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0x336C5CE7),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: const Color(0x55A29BFE)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.volume2,
                          color: AppColors.primaryLight,
                          size: Responsive.w(18),
                        ),
                        SizedBox(width: Responsive.w(10)),
                        _WaveformBars(),
                        SizedBox(width: Responsive.w(12)),
                        Text(
                          'Mantra protección · Sonando',
                          style: GoogleFonts.manrope(
                            fontSize: Responsive.sp(13),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: Responsive.w(10)),
                        Container(
                          width: Responsive.w(8),
                          height: Responsive.w(8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF55EFC4),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.h(28)),
                  _NotifCard(
                    borderColor: const Color(0x55A29BFE),
                    gradientColors: const [
                      Color(0xFF2D1B69),
                      Color(0xFF1A0F40),
                    ],
                    appLabel: 'Mantralia ahora',
                    title: 'Hora Espejo 11:11 · Pide un deseo',
                    subtitle:
                        'Puerta de manifestación abierta. Tu afirmación te espera.',
                    iconColor: AppColors.primaryLight,
                    iconBgStart: const Color(0xFF3D2B8A),
                    iconBgEnd: const Color(0xFF2D1B69),
                    icon: LucideIcons.sparkles,
                  ),
                  SizedBox(height: Responsive.h(12)),
                  _NotifCard(
                    borderColor: const Color(0x55F9A826),
                    gradientColors: const [
                      Color(0xFF2D1A00),
                      Color(0xFF1A0F00),
                    ],
                    appLabel: 'Mantralia hace 2 min',
                    title: 'Júpiter · Ventana de poder abierta',
                    subtitle:
                        '14:14 – 15:30 · Máximo poder para manifestar ahora',
                    iconColor: AppColors.amber,
                    iconBgStart: const Color(0xFF5A3300),
                    iconBgEnd: const Color(0xFF3D2200),
                    icon: LucideIcons.zap,
                  ),
                  SizedBox(height: Responsive.h(12)),
                  _NotifCard(
                    borderColor: const Color(0x5555EFC4),
                    gradientColors: const [
                      Color(0xFF001A12),
                      Color(0xFF000F09),
                    ],
                    appLabel: 'Mantralia 06:28',
                    title: 'Tehilim 27 · Tu protección diaria',
                    subtitle:
                        'KD Señor es mi luz y mi salvación · Shajarit en 2 min',
                    iconColor: AppColors.mint,
                    iconBgStart: const Color(0xFF003D22),
                    iconBgEnd: const Color(0xFF002918),
                    icon: LucideIcons.bookOpen,
                  ),
                  SizedBox(height: Responsive.h(12)),
                  _NotifCard(
                    borderColor: const Color(0x55FFEAA7),
                    gradientColors: const [
                      Color(0xFF2D2000),
                      Color(0xFF1A1400),
                    ],
                    appLabel: 'Mantralia',
                    title: 'Mantra de Abundancia · Repite ahora',
                    subtitle: 'Yo atraigo prosperidad y riqueza a mi vida',
                    iconColor: const Color(0xFFFFEAA7),
                    iconBgStart: const Color(0xFF5A4000),
                    iconBgEnd: const Color(0xFF3D2B00),
                    icon: LucideIcons.gem,
                  ),
                  SizedBox(height: Responsive.h(28)),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: Responsive.h(14),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.15),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.x,
                                  color: Colors.white.withValues(alpha: 0.66),
                                  size: Responsive.w(16),
                                ),
                                SizedBox(width: Responsive.w(8)),
                                Text(
                                  'Descartar',
                                  style: GoogleFonts.manrope(
                                    fontSize: Responsive.sp(14),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withValues(alpha: 0.66),
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
                          onTap: () => context.push('/notif-modal'),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: Responsive.h(14),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Abrir ritual',
                                  style: GoogleFonts.manrope(
                                    fontSize: Responsive.sp(14),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: Responsive.w(8)),
                                Icon(
                                  LucideIcons.arrowRight,
                                  color: Colors.white,
                                  size: Responsive.w(16),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.h(32)),
                  Center(
                    child: Container(
                      width: Responsive.w(134),
                      height: Responsive.h(5),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _WaveformBars extends StatelessWidget {
  const _WaveformBars();

  static const List<double> _heights = [6, 10, 14, 10, 16, 8, 12, 7];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: _heights
          .map(
            (h) => Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.w(1.5)),
              child: Container(
                width: Responsive.w(3),
                height: Responsive.h(h),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

class _NotifCard extends StatelessWidget {
  final Color borderColor;
  final List<Color> gradientColors;
  final String appLabel;
  final String title;
  final String subtitle;
  final Color iconColor;
  final Color iconBgStart;
  final Color iconBgEnd;
  final IconData icon;

  const _NotifCard({
    required this.borderColor,
    required this.gradientColors,
    required this.appLabel,
    required this.title,
    required this.subtitle,
    required this.iconColor,
    required this.iconBgStart,
    required this.iconBgEnd,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(Responsive.w(14)),
          decoration: BoxDecoration(
            color: const Color(0x18FFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: Responsive.w(44),
                height: Responsive.w(44),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [iconBgStart, iconBgEnd],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: Responsive.w(20)),
              ),
              SizedBox(width: Responsive.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLabel,
                      style: GoogleFonts.manrope(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    SizedBox(height: Responsive.h(3)),
                    Text(
                      title,
                      style: GoogleFonts.manrope(
                        fontSize: Responsive.sp(14),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: Responsive.h(3)),
                    Text(
                      subtitle,
                      style: GoogleFonts.manrope(
                        fontSize: Responsive.sp(12),
                        color: Colors.white.withValues(alpha: 0.66),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
