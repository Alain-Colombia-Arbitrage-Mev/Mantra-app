import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
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
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Nav ─────────────────────────────────────────────────
                ScreenNav(
                  title: 'Healing · Bio-Resonancia',
                  showBack: true,
                  trailing: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surfaceBorderLight),
                    ),
                    child: const Icon(
                      LucideIcons.moreHorizontal,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ── Section label ────────────────────────────────────────
                const SectionLabel('TU SESIÓN DE BIO-RESONANCIA'),
                const SizedBox(height: 28),

                // ── Healing orb ──────────────────────────────────────────
                Center(
                  child: Container(
                    width: 180,
                    height: 180,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const RadialGradient(
                        colors: [Color(0x3355EFC4), Color(0xAA00CEC9)],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF55EFC4).withValues(alpha: 0.4),
                          blurRadius: 60,
                          spreadRadius: 20,
                        ),
                      ],
                    ),
                    child: const Icon(
                      LucideIcons.heartPulse,
                      color: AppColors.mint,
                      size: 64,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Timer ────────────────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      Text(
                        '25:00',
                        style: GoogleFonts.urbanist(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Tiempo de Resonancia Restante',
                        style: GoogleFonts.urbanist(
                          fontSize: 12,
                          color: AppColors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Frequency chips ──────────────────────────────────────
                Center(
                  child: Wrap(
                    spacing: 10,
                    children: List.generate(_chips.length, (i) {
                      final isSelected = i == _selectedChip;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedChip = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.mint.withValues(alpha: 0.15)
                                : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.mint
                                  : AppColors.surfaceBorderLight,
                            ),
                          ),
                          child: Text(
                            _chips[i],
                            style: GoogleFonts.urbanist(
                              fontSize: 13,
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
                const SizedBox(height: 32),

                // ── Green CTA ────────────────────────────────────────────
                Center(
                  child: Container(
                    width: 280,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: AppGradients.greenButton,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.mint.withValues(alpha: 0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          LucideIcons.play,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Iniciar Sesión de Sanación',
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ── Info card ────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(16),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Las frecuencias Solfeggio actúan directamente sobre el ADN y los campos electromagnéticos del cuerpo, induciendo estados profundos de reparación celular y coherencia biológica. La frecuencia 528Hz es conocida como la "Frecuencia del Amor" y está asociada con la regeneración del ADN.',
                        style: GoogleFonts.urbanist(
                          fontSize: 13,
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
