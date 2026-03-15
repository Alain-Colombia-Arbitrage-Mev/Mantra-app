import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
            top: -80,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Close
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          color: const Color(0x15FFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          LucideIcons.x,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'LOS 3 DEDOS · ANCLAJE',
                    style: GoogleFonts.urbanist(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: const Color(0xCCF9A826),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Tu ancla de\npoder mental',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Une el pulgar, índice y dedo medio.\nEste gesto activa tu estado mental óptimo.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: const Color(0x80FFFFFF),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Visual hand circle ────────────────────────────────
                  SizedBox(
                    width: 220,
                    height: 220,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Outer pulse ring
                        Container(
                          width: 220,
                          height: 220,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0x20F9A826),
                              width: 1,
                            ),
                          ),
                        ),
                        // Inner ring
                        Container(
                          width: 170,
                          height: 170,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: const Color(0x40F9A826),
                              width: 1.5,
                            ),
                          ),
                        ),
                        // Center circle
                        Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0x20F9A826),
                            border: Border.all(
                              color: const Color(0x80F9A826),
                              width: 2,
                            ),
                          ),
                          child: const Icon(
                            LucideIcons.hand,
                            color: Color(0xFFF9A826),
                            size: 80,
                          ),
                        ),
                        // Zap icon top-right
                        Positioned(
                          top: 20,
                          right: 20,
                          child: Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: const Color(0x30F9A826),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              LucideIcons.zap,
                              color: Color(0xFFF9A826),
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Uses label ────────────────────────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'USOS PRÁCTICOS',
                      style: GoogleFonts.urbanist(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: const Color(0x80FFFFFF),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Use cards horizontal ──────────────────────────────
                  Row(
                    children: List.generate(_uses.length, (i) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: i < _uses.length - 1 ? 8 : 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x15F9A826),
                              borderRadius: BorderRadius.circular(12),
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
                                  size: 20,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _uses[i].$1,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 11,
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

                  const SizedBox(height: 24),

                  Text(
                    'Sesión guiada · Programación del anclaje',
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      color: const Color(0x80FFFFFF),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Gold CTA ──────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFF9A826), Color(0xFFD4850F)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF9A826).withValues(alpha: 0.40),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Activar tu anclaje',
                        style: GoogleFonts.urbanist(
                          fontSize: 18,
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
