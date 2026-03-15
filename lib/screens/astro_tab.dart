import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class AstroTab extends StatelessWidget {
  const AstroTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 54),

              // ── Header ───────────────────────────────────────────────
              Row(
                children: [
                  const Icon(
                    LucideIcons.chevronLeft,
                    color: Colors.white,
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Mapa de Poder Planetario · Hoy',
                      style: GoogleFonts.urbanist(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 64), // y:118 - y:54 = 64

              // ── Active window label ──────────────────────────────────
              Text(
                '⚡ VENTANA DE MANIFESTACIÓN ACTIVA',
                style: GoogleFonts.urbanist(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              const SizedBox(height: 22), // y:140 - y:118 = 22

              // ── Jupiter card ─────────────────────────────────────────
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0x26FFFFFF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    // Gold glow ellipse at (270, 20)
                    Positioned(
                      left: 270,
                      top: 20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gold.withValues(alpha: 0.5),
                              blurRadius: 40,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Planet icon frame at (16, 32): 56x56
                    Positioned(
                      left: 16,
                      top: 32,
                      child: Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: const Color(0x33F9A826),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          LucideIcons.star,
                          color: Color(0xFFF9A826),
                          size: 28,
                        ),
                      ),
                    ),
                    // Text column at (88, 24)
                    Positioned(
                      left: 88,
                      top: 24,
                      right: 16,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '✦ Júpiter · Ahora',
                            style: GoogleFonts.urbanist(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFF9A826),
                            ),
                          ),
                          const SizedBox(height: 4),
                          SizedBox(
                            width: 230,
                            child: Text(
                              '14:32 – 15:48 · Máximo poder para manifestar',
                              style: GoogleFonts.urbanist(
                                fontSize: 13,
                                color: const Color(0xCCFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Progress bar at (16, 104): total width 326, fill 218
                    Positioned(
                      left: 16,
                      top: 104,
                      child: SizedBox(
                        width: 326,
                        height: 6,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: Stack(
                            children: [
                              Container(
                                width: 326,
                                height: 6,
                                color: const Color(0x26FFFFFF),
                              ),
                              Container(
                                width: 218,
                                height: 6,
                                decoration: const BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFF9A826),
                                      Color(0xFFFFEAA7),
                                    ],
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
              ),

              const SizedBox(height: 16),

              // ── Mirror Hours quick link ──────────────────────────────
              GestureDetector(
                onTap: () => context.push('/mirror-hours'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x1AA29BFE),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: const Color(0x44A29BFE),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.moon,
                        color: Color(0xFFA29BFE),
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Horas Espejo · Próxima: 11:11',
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const Icon(
                        LucideIcons.chevronRight,
                        color: Color(0xFFA29BFE),
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 90),

              // ── Codes label ──────────────────────────────────────────
              Text(
                'CÓDIGOS DE ACTIVACIÓN',
                style: GoogleFonts.urbanist(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              const SizedBox(height: 20), // y:298 - y:278 = 20

              // ── Codes row ────────────────────────────────────────────
              Row(
                children: [
                  Expanded(
                    child: _CodeCard(
                      number: '520',
                      numberColor: const Color(0xFFF9A826),
                      subtitle: 'Amor propio · Grabovoi',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CodeCard(
                      number: '741852',
                      numberColor: const Color(0xFF6C5CE7),
                      subtitle: 'Frecuencia · Agesta',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _CodeCard(
                      number: '888',
                      numberColor: const Color(0xFF55EFC4),
                      subtitle: 'Abundancia infinita',
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 98), // y:396 - y:298 = 98

              // ── Schedule label ───────────────────────────────────────
              Text(
                'VENTANAS BIO-ENERGÉTICAS HOY',
                style: GoogleFonts.urbanist(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              const SizedBox(height: 20), // y:416 - y:396 = 20

              // ── Schedule list ────────────────────────────────────────
              _ScheduleCard(
                planetEmoji: '🌙',
                planetLabel: 'Luna',
                planetColor: const Color(0xFFA29BFE),
                time: '12:58 – 14:14',
                trailing: Text(
                  'Intuición · Sueños',
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: const Color(0x66FFFFFF),
                  ),
                ),
                fill: const Color(0x1AFFFFFF),
              ),

              const SizedBox(height: 6),

              _ScheduleCard(
                planetEmoji: '⚡',
                planetLabel: 'Júpiter',
                planetColor: const Color(0xFFF9A826),
                time: '14:14 – 15:30',
                trailing: Container(
                  width: 54,
                  height: 20,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9A826),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '✦ AHORA',
                    style: GoogleFonts.urbanist(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF12121E),
                    ),
                  ),
                ),
                fill: const Color(0x20F9A826),
              ),

              const SizedBox(height: 6),

              _ScheduleCard(
                planetEmoji: '🔴',
                planetLabel: 'Marte',
                planetColor: const Color(0xFFfd7960),
                time: '15:30 – 16:46',
                trailing: Text(
                  'Acción · Coraje',
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: const Color(0x66FFFFFF),
                  ),
                ),
                fill: const Color(0x1AFFFFFF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Code card ─────────────────────────────────────────────────────────────────

class _CodeCard extends StatelessWidget {
  final String number;
  final Color numberColor;
  final String subtitle;

  const _CodeCard({
    required this.number,
    required this.numberColor,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0x26FFFFFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: GoogleFonts.urbanist(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: numberColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: GoogleFonts.urbanist(
              fontSize: 11,
              color: const Color(0xCCFFFFFF),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ── Schedule card ──────────────────────────────────────────────────────────────

class _ScheduleCard extends StatelessWidget {
  final String planetEmoji;
  final String planetLabel;
  final Color planetColor;
  final String time;
  final Widget trailing;
  final Color fill;

  const _ScheduleCard({
    required this.planetEmoji,
    required this.planetLabel,
    required this.planetColor,
    required this.time,
    required this.trailing,
    required this.fill,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$planetEmoji $planetLabel',
            style: GoogleFonts.urbanist(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: planetColor,
            ),
          ),
          const Spacer(),
          Text(
            time,
            style: GoogleFonts.urbanist(
              fontSize: 13,
              color: const Color(0xCCFFFFFF),
            ),
          ),
          const Spacer(),
          trailing,
        ],
      ),
    );
  }
}
