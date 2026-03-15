import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';

class NotifLockScreen extends StatelessWidget {
  const NotifLockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset('assets/images/splash_bg.jpg', fit: BoxFit.cover),
          // Very dark overlay
          Container(color: const Color(0xF0060612)),
          // Purple glow ellipse
          Positioned(
            left: 45 - 150,
            top: 200 - 150,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF6C5CE7).withValues(alpha: 0.50),
                    blurRadius: 120,
                    spreadRadius: 40,
                  ),
                ],
              ),
            ),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 80),
                  // 11:11 time
                  Text(
                    '11:11',
                    style: GoogleFonts.urbanist(
                      fontSize: 88,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  // Date
                  Text(
                    'Sábado 21 de Febrero',
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      color: const Color(0xAAFFFFFF),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  // Audio autoplay bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
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
                        const Icon(
                          LucideIcons.volume2,
                          color: AppColors.primaryLight,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        _WaveformBars(),
                        const SizedBox(width: 12),
                        Text(
                          'Mantra protección · Sonando',
                          style: GoogleFonts.urbanist(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF55EFC4),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 28),
                  // Notification cards
                  const _NotifCard(
                    borderColor: Color(0x55A29BFE),
                    gradientColors: [Color(0xFF2D1B69), Color(0xFF1A0F40)],
                    appLabel: 'MANTRAS ahora',
                    title: 'Hora Espejo 11:11 · Pide un deseo',
                    subtitle:
                        'Puerta de manifestación abierta. Tu afirmación te espera.',
                    iconColor: AppColors.primaryLight,
                    iconBgStart: Color(0xFF3D2B8A),
                    iconBgEnd: Color(0xFF2D1B69),
                    icon: LucideIcons.sparkles,
                  ),
                  const SizedBox(height: 12),
                  const _NotifCard(
                    borderColor: Color(0x55F9A826),
                    gradientColors: [Color(0xFF2D1A00), Color(0xFF1A0F00)],
                    appLabel: 'MANTRAS hace 2 min',
                    title: 'Júpiter · Ventana de poder abierta',
                    subtitle:
                        '14:14 – 15:30 · Máximo poder para manifestar ahora',
                    iconColor: AppColors.amber,
                    iconBgStart: Color(0xFF5A3300),
                    iconBgEnd: Color(0xFF3D2200),
                    icon: LucideIcons.zap,
                  ),
                  const SizedBox(height: 12),
                  const _NotifCard(
                    borderColor: Color(0x5555EFC4),
                    gradientColors: [Color(0xFF001A12), Color(0xFF000F09)],
                    appLabel: 'MANTRAS 06:28',
                    title: 'Tehilim 27 · Tu protección diaria',
                    subtitle:
                        'KD Señor es mi luz y mi salvación · Shajarit en 2 min',
                    iconColor: AppColors.mint,
                    iconBgStart: Color(0xFF003D22),
                    iconBgEnd: Color(0xFF002918),
                    icon: LucideIcons.bookOpen,
                  ),
                  const SizedBox(height: 12),
                  const _NotifCard(
                    borderColor: Color(0x55FFEAA7),
                    gradientColors: [Color(0xFF2D2000), Color(0xFF1A1400)],
                    appLabel: 'MANTRAS',
                    title: 'Mantra de Abundancia · Repite ahora',
                    subtitle: 'Yo atraigo prosperidad y riqueza a mi vida',
                    iconColor: Color(0xFFFFEAA7),
                    iconBgStart: Color(0xFF5A4000),
                    iconBgEnd: Color(0xFF3D2B00),
                    icon: LucideIcons.gem,
                  ),
                  const SizedBox(height: 28),
                  // Bottom actions row
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
                            padding: const EdgeInsets.symmetric(vertical: 14),
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
                                  color:
                                      Colors.white.withValues(alpha: 0.66),
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Descartar',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white
                                        .withValues(alpha: 0.66),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.push('/notif-modal'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Abrir ritual',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Icon(
                                  LucideIcons.arrowRight,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  // Unlock bar
                  Center(
                    child: Container(
                      width: 134,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.55),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
              padding: const EdgeInsets.symmetric(horizontal: 1.5),
              child: Container(
                width: 3,
                height: h,
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
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0x18FFFFFF),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: borderColor),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon frame
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [iconBgStart, iconBgEnd],
                  ),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appLabel,
                      style: GoogleFonts.urbanist(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                        color: Colors.white.withValues(alpha: 0.55),
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
                    Text(
                      subtitle,
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
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
