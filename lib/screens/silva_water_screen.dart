import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SilvaWaterScreen extends StatelessWidget {
  const SilvaWaterScreen({super.key});

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
                colors: [Color(0xFF004040), Color(0xFF0a0a1a)],
              ),
            ),
          ),

          // ── Teal glow ────────────────────────────────────────────────
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
                      const Color(0xFF00CEC9).withValues(alpha: 0.20),
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
                    'VASO DE AGUA',
                    style: GoogleFonts.urbanist(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: const Color(0xCC00CEC9),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Programa tus\nsueños',
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
                    'Antes de dormir, toma un vaso de agua\ncon una intención clara en tu mente.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: const Color(0x80FFFFFF),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Visual glass ──────────────────────────────────────
                  Container(
                    width: 200,
                    height: 220,
                    decoration: BoxDecoration(
                      color: const Color(0x0AFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0x3000CEC9),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          LucideIcons.droplets,
                          color: Color(0xFF00CEC9),
                          size: 64,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.moon,
                                color: Color(0xCCA29BFE), size: 16),
                            const SizedBox(width: 6),
                            Text(
                              'noche',
                              style: GoogleFonts.urbanist(
                                fontSize: 12,
                                color: const Color(0xCCA29BFE),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 8),
                          child: Divider(
                            color: const Color(0x3000CEC9),
                            thickness: 1,
                          ),
                        ),
                        Text(
                          '½',
                          style: GoogleFonts.urbanist(
                            fontSize: 40,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF00CEC9),
                            height: 1.0,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(LucideIcons.sun,
                                color: Color(0xCCF9A826), size: 16),
                            const SizedBox(width: 6),
                            Text(
                              'mañana',
                              style: GoogleFonts.urbanist(
                                fontSize: 12,
                                color: const Color(0xCCF9A826),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Steps ─────────────────────────────────────────────
                  _WaterStep(
                    number: '1',
                    text: 'Bebe medio vaso de agua antes de dormir',
                  ),
                  const SizedBox(height: 10),
                  _WaterStep(
                    number: '2',
                    text: 'Al despertar, bebe la otra mitad',
                  ),
                  const SizedBox(height: 10),
                  _WaterStep(
                    number: '3',
                    text: 'Tu subconsciente te dará la respuesta',
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Sesión guiada · 10 min antes de dormir',
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      color: const Color(0x80FFFFFF),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Teal CTA ──────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF00CEC9), Color(0xFF008180)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00CEC9).withValues(alpha: 0.40),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Comenzar ritual nocturno',
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

class _WaterStep extends StatelessWidget {
  final String number;
  final String text;

  const _WaterStep({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: const Color(0x2000CEC9),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF00CEC9), width: 1),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.urbanist(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF00CEC9),
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
