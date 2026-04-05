import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../utils/responsive.dart';

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
    Responsive.init(context);
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
                padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(20), vertical: Responsive.h(12)),
                child: Row(
                  children: [
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: Responsive.w(36),
                        height: Responsive.w(36),
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
                  ],
                ),
              ),

              // ── Label ──────────────────────────────────────────────────
              Text(
                'NIVEL ALFA · 8-12 Hz',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(11),
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                  color: const Color(0xCC55EFC4),
                ),
              ),

              SizedBox(height: Responsive.h(24)),

              // ── Countdown ──────────────────────────────────────────────
              Text(
                '3',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(160),
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF55EFC4),
                  height: 1.0,
                ),
              ),

              SizedBox(height: Responsive.h(16)),

              // ── Instructions ───────────────────────────────────────────
              Text(
                'Cierra los ojos...\nRelaja tu cuerpo...\nSiente la calma...',
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(18),
                  color: const Color(0x9AFFFFFF),
                  height: 1.8,
                ),
              ),

              SizedBox(height: Responsive.h(28)),

              // ── Waveform ───────────────────────────────────────────────
              SizedBox(
                height: Responsive.h(60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: List.generate(_waveHeights.length, (i) {
                    return Container(
                      width: Responsive.w(4),
                      height: Responsive.h(_waveHeights[i]),
                      margin: EdgeInsets.symmetric(
                          horizontal: Responsive.w(3)),
                      decoration: BoxDecoration(
                        color: const Color(0xFF55EFC4)
                            .withValues(alpha: _waveOpacities[i]),
                        borderRadius:
                            BorderRadius.circular(Responsive.w(2)),
                      ),
                    );
                  }),
                ),
              ),

              SizedBox(height: Responsive.h(16)),

              // ── Timer ──────────────────────────────────────────────────
              Text(
                '12:00',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(14),
                  color: const Color(0x66FFFFFF),
                ),
              ),

              const Spacer(),

              // ── Controls ───────────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    LucideIcons.skipBack,
                    color: const Color(0x99FFFFFF),
                    size: Responsive.w(28),
                  ),
                  SizedBox(width: Responsive.w(32)),
                  GestureDetector(
                    onTap: () => setState(() => _isPlaying = !_isPlaying),
                    child: Container(
                      width: Responsive.w(80),
                      height: Responsive.w(80),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF008180), Color(0xFF55EFC4)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF55EFC4)
                                .withValues(alpha: 0.35),
                            blurRadius: Responsive.w(24),
                            spreadRadius: Responsive.w(2),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isPlaying ? LucideIcons.pause : LucideIcons.play,
                        color: Colors.white,
                        size: Responsive.w(32),
                      ),
                    ),
                  ),
                  SizedBox(width: Responsive.w(32)),
                  Icon(
                    LucideIcons.skipForward,
                    color: const Color(0x99FFFFFF),
                    size: Responsive.w(28),
                  ),
                ],
              ),

              SizedBox(height: Responsive.h(20)),

              // ── Session label ──────────────────────────────────────────
              Text(
                'Sesión guiada · Relajación profunda',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(13),
                  color: const Color(0x80FFFFFF),
                ),
              ),

              SizedBox(height: Responsive.h(6)),

              Text(
                'Basado en el Método Silva de Control Mental',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(11),
                  color: const Color(0x4DFFFFFF),
                ),
              ),

              SizedBox(height: Responsive.h(32)),
            ],
          ),
        ),
      ),
    );
  }
}
