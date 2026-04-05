import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../utils/responsive.dart';

class SilvaWaterScreen extends StatelessWidget {
  const SilvaWaterScreen({super.key});

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
                colors: [Color(0xFF004040), Color(0xFF0a0a1a)],
              ),
            ),
          ),

          // ── Teal glow ────────────────────────────────────────────────
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
                    'VASO DE AGUA',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(11),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: const Color(0xCC00CEC9),
                    ),
                  ),
                  SizedBox(height: Responsive.h(10)),

                  Text(
                    'Programa tus\nsueños',
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
                    'Antes de dormir, toma un vaso de agua\ncon una intención clara en tu mente.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(14),
                      color: const Color(0x80FFFFFF),
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: Responsive.h(24)),

                  // ── Visual glass ──────────────────────────────────────
                  Container(
                    width: Responsive.w(200),
                    height: Responsive.h(220),
                    decoration: BoxDecoration(
                      color: const Color(0x0AFFFFFF),
                      borderRadius:
                          BorderRadius.circular(Responsive.w(20)),
                      border: Border.all(
                        color: const Color(0x3000CEC9),
                        width: 1.5,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.droplets,
                          color: const Color(0xFF00CEC9),
                          size: Responsive.w(64),
                        ),
                        SizedBox(height: Responsive.h(10)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.moon,
                                color: const Color(0xCCA29BFE),
                                size: Responsive.w(16)),
                            SizedBox(width: Responsive.w(6)),
                            Text(
                              'noche',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(12),
                                color: const Color(0xCCA29BFE),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Responsive.w(24),
                              vertical: Responsive.h(8)),
                          child: Divider(
                            color: const Color(0x3000CEC9),
                            thickness: 1,
                          ),
                        ),
                        Text(
                          '½',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(40),
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF00CEC9),
                            height: 1.0,
                          ),
                        ),
                        SizedBox(height: Responsive.h(8)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(LucideIcons.sun,
                                color: const Color(0xCCF9A826),
                                size: Responsive.w(16)),
                            SizedBox(width: Responsive.w(6)),
                            Text(
                              'mañana',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(12),
                                color: const Color(0xCCF9A826),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: Responsive.h(24)),

                  // ── Steps ─────────────────────────────────────────────
                  _WaterStep(
                    number: '1',
                    text: 'Bebe medio vaso de agua antes de dormir',
                  ),
                  SizedBox(height: Responsive.h(10)),
                  _WaterStep(
                    number: '2',
                    text: 'Al despertar, bebe la otra mitad',
                  ),
                  SizedBox(height: Responsive.h(10)),
                  _WaterStep(
                    number: '3',
                    text: 'Tu subconsciente te dará la respuesta',
                  ),

                  SizedBox(height: Responsive.h(24)),

                  Text(
                    'Sesión guiada · 10 min antes de dormir',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      color: const Color(0x80FFFFFF),
                    ),
                  ),

                  SizedBox(height: Responsive.h(20)),

                  // ── Teal CTA ──────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    height: Responsive.h(56),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF00CEC9), Color(0xFF008180)],
                      ),
                      borderRadius:
                          BorderRadius.circular(Responsive.w(16)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00CEC9)
                              .withValues(alpha: 0.40),
                          blurRadius: Responsive.w(20),
                          offset: Offset(0, Responsive.h(6)),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Comenzar ritual nocturno',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(18),
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
          width: Responsive.w(28),
          height: Responsive.w(28),
          decoration: BoxDecoration(
            color: const Color(0x2000CEC9),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFF00CEC9), width: 1),
          ),
          child: Center(
            child: Text(
              number,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(12),
                fontWeight: FontWeight.w700,
                color: const Color(0xFF00CEC9),
              ),
            ),
          ),
        ),
        SizedBox(width: Responsive.w(12)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: Responsive.h(4)),
            child: Text(
              text,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(14),
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
