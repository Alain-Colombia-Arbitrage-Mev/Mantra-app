import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

class AstroTab extends StatelessWidget {
  const AstroTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(Responsive.w(16), 0, Responsive.w(16), Responsive.bottomNavPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Responsive.h(16)),

              // ── Header ───────────────────────────────────────────────
              Row(
                children: [
                  Icon(
                    LucideIcons.chevronLeft,
                    color: Colors.white,
                    size: Responsive.w(24),
                  ),
                  SizedBox(width: Responsive.w(12)),
                  Expanded(
                    child: Text(
                      'Mapa de Poder Planetario · Hoy',
                      style: GoogleFonts.urbanist(
                        fontSize: Responsive.sp(20),
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: Responsive.h(24)),

              // ── Active window label ──────────────────────────────────
              Text(
                '⚡ VENTANA DE MANIFESTACIÓN ACTIVA',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              SizedBox(height: Responsive.h(22)),

              // ── Jupiter card ─────────────────────────────────────────
              Container(
                height: Responsive.h(120),
                decoration: BoxDecoration(
                  color: const Color(0x26FFFFFF),
                  borderRadius: BorderRadius.circular(Responsive.w(20)),
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    Positioned(
                      left: Responsive.w(270),
                      top: Responsive.h(20),
                      child: Container(
                        width: Responsive.w(80),
                        height: Responsive.w(80),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.gold.withValues(alpha: 0.5),
                              blurRadius: Responsive.w(40),
                              spreadRadius: Responsive.w(10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: Responsive.w(16),
                      top: Responsive.h(32),
                      child: Container(
                        width: Responsive.w(56),
                        height: Responsive.w(56),
                        decoration: BoxDecoration(
                          color: const Color(0x33F9A826),
                          borderRadius: BorderRadius.circular(Responsive.w(24)),
                        ),
                        child: Icon(
                          LucideIcons.star,
                          color: const Color(0xFFF9A826),
                          size: Responsive.w(28),
                        ),
                      ),
                    ),
                    Positioned(
                      left: Responsive.w(88),
                      top: Responsive.h(24),
                      right: Responsive.w(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '✦ Júpiter · Ahora',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(18),
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFFF9A826),
                            ),
                          ),
                          SizedBox(height: Responsive.h(4)),
                          SizedBox(
                            width: Responsive.w(230),
                            child: Text(
                              '14:32 – 15:48 · Máximo poder para manifestar',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(13),
                                color: const Color(0xCCFFFFFF),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: Responsive.w(16),
                      top: Responsive.h(104),
                      child: SizedBox(
                        width: Responsive.w(326),
                        height: Responsive.h(6),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(Responsive.w(4)),
                          child: Stack(
                            children: [
                              Container(
                                width: Responsive.w(326),
                                height: Responsive.h(6),
                                color: const Color(0x26FFFFFF),
                              ),
                              Container(
                                width: Responsive.w(218),
                                height: Responsive.h(6),
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

              SizedBox(height: Responsive.h(16)),

              // ── Mirror Hours quick link ──────────────────────────────
              GestureDetector(
                onTap: () => context.push('/mirror-hours'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(16),
                    vertical: Responsive.h(12),
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0x1AA29BFE),
                    borderRadius: BorderRadius.circular(Responsive.w(14)),
                    border: Border.all(
                      color: const Color(0x44A29BFE),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.moon,
                        color: const Color(0xFFA29BFE),
                        size: Responsive.w(18),
                      ),
                      SizedBox(width: Responsive.w(10)),
                      Expanded(
                        child: Text(
                          'Horas Espejo · Próxima: 11:11',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(14),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Icon(
                        LucideIcons.chevronRight,
                        color: const Color(0xFFA29BFE),
                        size: Responsive.w(18),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: Responsive.h(28)),

              // ── Codes label ──────────────────────────────────────────
              Text(
                'CÓDIGOS DE ACTIVACIÓN',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              SizedBox(height: Responsive.h(20)),

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
                  SizedBox(width: Responsive.w(12)),
                  Expanded(
                    child: _CodeCard(
                      number: '741852',
                      numberColor: const Color(0xFF6C5CE7),
                      subtitle: 'Frecuencia · Agesta',
                    ),
                  ),
                  SizedBox(width: Responsive.w(12)),
                  Expanded(
                    child: _CodeCard(
                      number: '888',
                      numberColor: const Color(0xFF55EFC4),
                      subtitle: 'Abundancia infinita',
                    ),
                  ),
                ],
              ),

              SizedBox(height: Responsive.h(28)),

              // ── Schedule label ───────────────────────────────────────
              Text(
                'VENTANAS BIO-ENERGÉTICAS HOY',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(12),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              SizedBox(height: Responsive.h(20)),

              // ── Schedule list ────────────────────────────────────────
              _ScheduleCard(
                planetEmoji: '🌙',
                planetLabel: 'Luna',
                planetColor: const Color(0xFFA29BFE),
                time: '12:58 – 14:14',
                trailing: Text(
                  'Intuición · Sueños',
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(12),
                    color: const Color(0x66FFFFFF),
                  ),
                ),
                fill: const Color(0x1AFFFFFF),
              ),

              SizedBox(height: Responsive.h(6)),

              _ScheduleCard(
                planetEmoji: '⚡',
                planetLabel: 'Júpiter',
                planetColor: const Color(0xFFF9A826),
                time: '14:14 – 15:30',
                trailing: Container(
                  width: Responsive.w(54),
                  height: Responsive.h(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF9A826),
                    borderRadius: BorderRadius.circular(Responsive.w(10)),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '✦ AHORA',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(10),
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF12121E),
                    ),
                  ),
                ),
                fill: const Color(0x20F9A826),
              ),

              SizedBox(height: Responsive.h(6)),

              _ScheduleCard(
                planetEmoji: '🔴',
                planetLabel: 'Marte',
                planetColor: const Color(0xFFfd7960),
                time: '15:30 – 16:46',
                trailing: Text(
                  'Acción · Coraje',
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(12),
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
      height: Responsive.h(80),
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(12), vertical: Responsive.h(8)),
      decoration: BoxDecoration(
        color: const Color(0x26FFFFFF),
        borderRadius: BorderRadius.circular(Responsive.w(16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number,
            style: GoogleFonts.urbanist(
              fontSize: Responsive.sp(22),
              fontWeight: FontWeight.w700,
              color: numberColor,
            ),
          ),
          SizedBox(height: Responsive.h(4)),
          Text(
            subtitle,
            style: GoogleFonts.urbanist(
              fontSize: Responsive.sp(11),
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
      height: Responsive.h(48),
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16)),
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(Responsive.w(12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            '$planetEmoji $planetLabel',
            style: GoogleFonts.urbanist(
              fontSize: Responsive.sp(14),
              fontWeight: FontWeight.w700,
              color: planetColor,
            ),
          ),
          const Spacer(),
          Text(
            time,
            style: GoogleFonts.urbanist(
              fontSize: Responsive.sp(13),
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
