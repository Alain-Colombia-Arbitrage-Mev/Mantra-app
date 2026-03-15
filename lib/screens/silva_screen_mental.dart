import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SilvaScreenMentalScreen extends StatelessWidget {
  const SilvaScreenMentalScreen({super.key});

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
                colors: [Color(0xFF3d1a00), Color(0xFF0a0a1a)],
              ),
            ),
          ),

          // ── Orange/red glow ───────────────────────────────────────────
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
                      const Color(0xFFfd7960).withValues(alpha: 0.22),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Content ───────────────────────────────────────────────────
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
                    'PANTALLA MENTAL',
                    style: GoogleFonts.urbanist(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: const Color(0xCCfd7960),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Proyecta tu\nrealidad deseada',
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
                    'En nivel alfa, visualiza en tu pantalla mental\nla realidad que deseas manifestar.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: const Color(0x80FFFFFF),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Screen visual card ────────────────────────────────
                  Container(
                    width: 320,
                    height: 190,
                    decoration: BoxDecoration(
                      color: const Color(0x0AFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0x40fd7960),
                        width: 2,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Scanlines effect
                        ClipRRect(
                          borderRadius: BorderRadius.circular(18),
                          child: Column(
                            children: List.generate(18, (i) {
                              return Container(
                                height: 190 / 18,
                                color: i.isEven
                                    ? const Color(0x05FFFFFF)
                                    : Colors.transparent,
                              );
                            }),
                          ),
                        ),
                        // Icons
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                LucideIcons.projector,
                                color: Color(0xCCfd7960),
                                size: 36,
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    LucideIcons.eye,
                                    color: Color(0x80fd7960),
                                    size: 18,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Tu Pantalla Mental',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: const Color(0xCCFFFFFF),
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

                  const SizedBox(height: 24),

                  // ── Steps ─────────────────────────────────────────────
                  _ScreenStep(
                    number: '1',
                    text: 'Entra en nivel alfa (ojos cerrados)',
                  ),
                  const SizedBox(height: 10),
                  _ScreenStep(
                    number: '2',
                    text: 'Proyecta la situación actual en la pantalla',
                  ),
                  const SizedBox(height: 10),
                  _ScreenStep(
                    number: '3',
                    text: 'Desliza hacia la derecha: tu realidad ideal',
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Visualización guiada · Proyección de objetivos',
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      color: const Color(0x80FFFFFF),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Orange CTA ────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFFfd7960), Color(0xFFc44b30)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFfd7960).withValues(alpha: 0.40),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Activar pantalla mental',
                        style: GoogleFonts.urbanist(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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

class _ScreenStep extends StatelessWidget {
  final String number;
  final String text;

  const _ScreenStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: const Color(0x30fd7960),
            border: Border.all(color: const Color(0xFFfd7960), width: 1),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.urbanist(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFFfd7960),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              text,
              style: GoogleFonts.urbanist(
                fontSize: 14,
                color: const Color(0xCCFFFFFF),
                height: 1.4,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
