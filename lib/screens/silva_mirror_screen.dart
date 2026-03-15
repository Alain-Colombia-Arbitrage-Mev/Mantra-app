import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SilvaMirrorScreen extends StatelessWidget {
  const SilvaMirrorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background gradient ──────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1a0f3a), Color(0xFF0a0a1a)],
              ),
            ),
          ),

          // ── Purple glow ─────────────────────────────────────────────
          Positioned(
            top: -60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 340,
                height: 340,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF6C5CE7).withValues(alpha: 0.25),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Content ─────────────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Close button
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

                  // Label
                  Text(
                    'ESPEJO DE LA MENTE',
                    style: GoogleFonts.urbanist(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: const Color(0xCCA29BFE),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Title
                  Text(
                    'Visualiza tu\ntransformación',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Imagina el problema a la izquierda.\nAhora desliza y visualiza la solución.',
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: const Color(0x80FFFFFF),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Two cards ─────────────────────────────────────────
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // ANTES card
                      Expanded(
                        child: Container(
                          height: 280,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0x0AFFFFFF),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0x40FF6B6B),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ANTES',
                                style: GoogleFonts.urbanist(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                  color: const Color(0xFFFF6B6B),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Icon(
                                LucideIcons.cloudRain,
                                color: Color(0xFFFF6B6B),
                                size: 32,
                              ),
                              const Spacer(),
                              Text(
                                'El problema que quieres resolver',
                                style: GoogleFonts.urbanist(
                                  fontSize: 12,
                                  color: const Color(0x80FFFFFF),
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0x15FF6B6B),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Toca para describir',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 11,
                                      color: const Color(0xCCFF6B6B),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // Arrow
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: const Color(0x20FFFFFF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            LucideIcons.arrowRight,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),

                      // DESPUÉS card
                      Expanded(
                        child: Container(
                          height: 280,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0x0AFFFFFF),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: const Color(0x4055EFC4),
                              width: 1.5,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'DESPUÉS',
                                style: GoogleFonts.urbanist(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                  color: const Color(0xFF55EFC4),
                                ),
                              ),
                              const SizedBox(height: 12),
                              const Icon(
                                LucideIcons.checkCircle,
                                color: Color(0xFF55EFC4),
                                size: 32,
                              ),
                              const Spacer(),
                              Text(
                                'La solución ya resuelta en tu mente',
                                style: GoogleFonts.urbanist(
                                  fontSize: 12,
                                  color: const Color(0x80FFFFFF),
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8),
                                decoration: BoxDecoration(
                                  color: const Color(0x1555EFC4),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    'Toca para visualizar',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 11,
                                      color: const Color(0xCC55EFC4),
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

                  const SizedBox(height: 20),

                  // Step label
                  Text(
                    'PASO 1 DE 3',
                    style: GoogleFonts.urbanist(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.5,
                      color: const Color(0x80FFFFFF),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Visualiza con claridad el estado actual.\nDéjate sentir las emociones sin resistencia.',
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      color: const Color(0x80FFFFFF),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // CTA
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF6C5CE7), Color(0xFFA29BFE)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C5CE7).withValues(alpha: 0.45),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Comenzar visualización',
                        style: GoogleFonts.urbanist(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  Center(
                    child: Text(
                      'Técnica del Espejo de la Mente · José Silva',
                      style: GoogleFonts.urbanist(
                        fontSize: 11,
                        color: const Color(0x40FFFFFF),
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
