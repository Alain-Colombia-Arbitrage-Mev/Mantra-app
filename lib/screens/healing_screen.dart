import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/screen_bg.dart';

class HealingScreen extends StatefulWidget {
  const HealingScreen({super.key});

  @override
  State<HealingScreen> createState() => _HealingScreenState();
}

class _HealingScreenState extends State<HealingScreen> {
  int _selectedChip = 0;

  static const List<String> _chips = ['528 Hz', 'Solfeggio', 'Theta'];

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      extendBody: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xF0060612), Color(0xF00A1A1A)],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
                Responsive.w(20),
                Responsive.h(20),
                Responsive.w(20),
                Responsive.h(48)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Nav ─────────────────────────────────────────────────
                ScreenNav(
                  title: 'Healing · Bio-Resonancia',
                  showBack: true,
                  trailing: Container(
                    width: Responsive.w(36),
                    height: Responsive.w(36),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border:
                          Border.all(color: AppColors.surfaceBorderLight),
                    ),
                    child: Icon(
                      LucideIcons.moreHorizontal,
                      color: Colors.white,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Section label ────────────────────────────────────────
                const SectionLabel('TU SESIÓN DE BIO-RESONANCIA'),
                SizedBox(height: Responsive.h(28)),

                // ── Healing orb ──────────────────────────────────────────
                Center(
                  child: Container(
                    width: Responsive.w(180),
                    height: Responsive.w(180),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [Color(0x3355EFC4), Color(0xAA00CEC9)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF55EFC4)
                              .withValues(alpha: 0.4),
                          blurRadius: Responsive.w(60),
                          spreadRadius: Responsive.w(20),
                        ),
                      ],
                    ),
                    child: Icon(
                      LucideIcons.heartPulse,
                      color: AppColors.mint,
                      size: Responsive.w(64),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(28)),

                // ── Timer ────────────────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      Text(
                        '25:00',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(40),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: Responsive.h(6)),
                      Text(
                        'Tiempo de Resonancia Restante',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(12),
                          color: AppColors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Frequency chips ──────────────────────────────────────
                Center(
                  child: Wrap(
                    spacing: Responsive.w(10),
                    children: List.generate(_chips.length, (i) {
                      final isSelected = i == _selectedChip;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedChip = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.w(16),
                            vertical: Responsive.h(8),
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.mint
                                    .withValues(alpha: 0.15)
                                : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(
                                Responsive.w(50)),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.mint
                                  : AppColors.surfaceBorderLight,
                            ),
                          ),
                          child: Text(
                            _chips[i],
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? AppColors.mint
                                  : AppColors.textTertiary,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: Responsive.h(32)),

                // ── Green CTA ────────────────────────────────────────────
                Center(
                  child: GestureDetector(
                    onTap: () => context.push('/player'),
                    child: Container(
                      width: Responsive.w(280),
                      height: Responsive.h(56),
                      decoration: BoxDecoration(
                        gradient: AppGradients.greenButton,
                        borderRadius:
                            BorderRadius.circular(Responsive.w(28)),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.mint
                                .withValues(alpha: 0.35),
                            blurRadius: Responsive.w(20),
                            offset: Offset(0, Responsive.h(6)),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.play,
                            color: Colors.white,
                            size: Responsive.w(20),
                          ),
                          SizedBox(width: Responsive.w(10)),
                          Text(
                            'Iniciar Sesión de Sanación',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(16),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Info card ────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Responsive.w(18)),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.05),
                    borderRadius:
                        BorderRadius.circular(Responsive.w(16)),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: 0.1),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Reparación celular con frecuencias Solfeggio',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(14),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: Responsive.h(8)),
                      Text(
                        'Las frecuencias Solfeggio actúan directamente sobre el ADN y los campos electromagnéticos del cuerpo, induciendo estados profundos de reparación celular y coherencia biológica. La frecuencia 528Hz es conocida como la "Frecuencia del Amor" y está asociada con la regeneración del ADN.',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(13),
                          color: AppColors.textTertiary,
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
