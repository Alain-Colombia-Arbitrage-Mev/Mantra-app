import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SilvaAlfaScreen extends StatefulWidget {
  const SilvaAlfaScreen({super.key});

  @override
  State<SilvaAlfaScreen> createState() => _SilvaAlfaScreenState();
}

class _SilvaAlfaScreenState extends State<SilvaAlfaScreen> {
  bool _isPlaying = false;

  static const List<double> _waveHeights = [
    18, 28, 40, 32, 22, 36, 48, 30, 20, 38,
    44, 26, 34, 50, 28, 40, 22, 36, 30, 18,
  ];

  static const List<double> _waveOpacities = [
    0.3, 0.5, 0.8, 0.6, 0.4, 0.7, 1.0, 0.5, 0.35, 0.75,
    0.9, 0.45, 0.65, 1.0, 0.5, 0.8, 0.4, 0.7, 0.55, 0.3,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.4,
            colors: [Color(0xFF00413f), Color(0xFF0a0a1a)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Top bar ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
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
                  ],
                ),
              ),

              // ── Label ──────────────────────────────────────────────────
              Text(
                'NIVEL ALFA · 8-12 Hz',
                style: GoogleFonts.urbanist(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: const Color(0xCC55EFC4),
                ),
              ),

              const SizedBox(height: 24),

              // ── Countdown ──────────────────────────────────────────────
              Text(
                '3',
                style: GoogleFonts.urbanist(
                  fontSize: 160,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF55EFC4),
                  height: 1.0,
                ),
              ),

              const SizedBox(height: 16),

              // ── Instructions ───────────────────────────────────────────
              Text(
                'Cierra los ojos...\nRelaja tu cuerpo...\nSiente la calma...',
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontSize: 18,
                  color: const Color(0x9AFFFFFF),
                  height: 1.8,
                ),
              ),

              const SizedBox(height: 28),

              // ── Waveform ───────────────────────────────────────────────
              SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(_waveHeights.length, (i) {
                    return Container(
                      width: 4,
                      height: _waveHeights[i],
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                        color: const Color(0xFF55EFC4)
                            .withValues(alpha: _waveOpacities[i]),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }),
                ),
              ),

              const SizedBox(height: 16),

              // ── Timer ──────────────────────────────────────────────────
              Text(
                '12:00',
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  color: const Color(0x66FFFFFF),
                ),
              ),

              const Spacer(),

              // ── Controls ───────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(
                    LucideIcons.skipBack,
                    color: Color(0x99FFFFFF),
                    size: 28,
                  ),
                  const SizedBox(width: 32),
                  GestureDetector(
                    onTap: () => setState(() => _isPlaying = !_isPlaying),
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF008180), Color(0xFF55EFC4)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF55EFC4).withValues(alpha: 0.35),
                            blurRadius: 24,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: Icon(
                        _isPlaying ? LucideIcons.pause : LucideIcons.play,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                  const Icon(
                    LucideIcons.skipForward,
                    color: Color(0x99FFFFFF),
                    size: 28,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Session label ──────────────────────────────────────────
              Text(
                'Sesión guiada · Relajación profunda',
                style: GoogleFonts.urbanist(
                  fontSize: 13,
                  color: const Color(0x80FFFFFF),
                ),
              ),

              const SizedBox(height: 6),

              Text(
                'Basado en el Método Silva de Control Mental',
                style: GoogleFonts.urbanist(
                  fontSize: 11,
                  color: const Color(0x4DFFFFFF),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
