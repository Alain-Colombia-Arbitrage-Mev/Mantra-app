import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../utils/responsive.dart';

class SilvaFingersScreen extends StatelessWidget {
  const SilvaFingersScreen({super.key});

  static const List<(String, IconData)> _uses = [
    ('Trabajo', LucideIcons.briefcase),
    ('Exámenes', LucideIcons.bookOpen),
    ('Estrés', LucideIcons.wind),
    ('Hablar', LucideIcons.mic),
  ];

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background ────────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topCenter,
                radius: 1.2,
                colors: [Color(0xFF3d2e00), Color(0xFF0a0a1a)],
              ),
            ),
          ),

          // ── Gold glow ─────────────────────────────────────────────────
          Positioned(
            top: Responsive.h(-80),
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: Responsive.w(300),
                height: Responsive.w(300),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFFF9A826).withValues(alpha: 0.20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  Responsive.w(20), 0, Responsive.w(20), Responsive.h(32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Close
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: Responsive.w(36),
                        height: Responsive.w(36),
                        margin: EdgeInsets.only(top: Responsive.h(12)),
                        decoration: BoxDecoration(
                          color: const Color(0x15FFFFFF),
                          borderRadius:
                              BorderRadius.circular(Responsive.w(10)),
                        ),
                        child: Icon(
                          LucideIcons.x,
                          color: Colors.white,
                          size: Responsive.w(18),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Responsive.h(8)),

                  Text(
                    'LOS 3 DEDOS · ANCLAJE',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(11),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: const Color(0xCCF9A826),
                    ),
                  ),
                  SizedBox(height: Responsive.h(10)),

                  Text(
                    'Tu ancla de\npoder mental',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(28),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.15,
                    ),
                  ),
                  SizedBox(height: Responsive.h(8)),

                  Text(
                    'Une el pulgar, índice y dedo medio.\nEste gesto activa tu estado mental óptimo.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(14),
                      color: const Color(0x80FFFFFF),
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: Responsive.h(24)),

                  // ── Visual hand circle ────────────────────────────────
                  SizedBox(
                    width: Responsive.w(220),
                    height: Responsive.w(220),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: Responsive.w(220),
                          height: Responsive.w(220),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0x20F9A826),
                              width: 1,
                            ),
                          ),
                        ),
                        Container(
                          width: Responsive.w(170),
                          height: Responsive.w(170),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0x40F9A826),
                              width: 1.5,
                            ),
                          ),
                        ),
                        Container(
                          width: Responsive.w(120),
                          height: Responsive.w(120),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0x20F9A826),
                            border: Border.all(
                              color: const Color(0x80F9A826),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            LucideIcons.hand,
                            color: const Color(0xFFF9A826),
                            size: Responsive.w(80),
                          ),
                        ),
                        Positioned(
                          top: Responsive.w(20),
                          right: Responsive.w(20),
                          child: Container(
                            width: Responsive.w(28),
                            height: Responsive.w(28),
                            decoration: const BoxDecoration(
                              color: Color(0x30F9A826),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LucideIcons.zap,
                              color: const Color(0xFFF9A826),
                              size: Responsive.w(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Responsive.h(24)),

                  // ── Uses label ────────────────────────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'USOS PRÁCTICOS',
                      style: GoogleFonts.urbanist(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: const Color(0x80FFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(12)),

                  // ── Use cards horizontal ──────────────────────────────
                  Row(
                    children: List.generate(_uses.length, (i) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: i < _uses.length - 1
                                  ? Responsive.w(8)
                                  : 0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Responsive.h(12),
                                horizontal: Responsive.w(8)),
                            decoration: BoxDecoration(
                              color: const Color(0x15F9A826),
                              borderRadius:
                                  BorderRadius.circular(Responsive.w(12)),
                              border: Border.all(
                                color: const Color(0x30F9A826),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  _uses[i].$2,
                                  color: const Color(0xFFF9A826),
                                  size: Responsive.w(20),
                                ),
                                SizedBox(height: Responsive.h(6)),
                                Text(
                                  _uses[i].$1,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(11),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: Responsive.h(24)),

                  Text(
                    'Sesión guiada · Programación del anclaje',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      color: const Color(0x80FFFFFF),
                    ),
                  ),

                  SizedBox(height: Responsive.h(20)),

                  // ── Gold CTA ──────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    height: Responsive.h(56),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFF9A826), Color(0xFFD4850F)],
                      ),
                      borderRadius:
                          BorderRadius.circular(Responsive.w(16)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF9A826)
                              .withValues(alpha: 0.40),
                          blurRadius: Responsive.w(20),
                          offset: Offset(0, Responsive.h(6)),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Activar tu anclaje',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(18),
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
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
    );
  }
}
