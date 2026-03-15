import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';

class SacredFrequenciesScreen extends StatelessWidget {
  const SacredFrequenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F0A2A), Color(0xFF0A0A1A)],
          ),
        ),
        child: Stack(
          children: [
            // Mint glow
            Positioned(
              top: 60,
              left: -60,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mint.withValues(alpha: 0.14),
                      blurRadius: 140,
                      spreadRadius: 70,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // ── Header ──────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.surfaceBorderLight,
                              ),
                            ),
                            child: const Icon(
                              LucideIcons.chevronLeft,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Frecuencias Sagradas',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.surfaceBorderLight,
                            ),
                          ),
                          child: const Icon(
                            LucideIcons.slidersHorizontal,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                      child: Column(
                        children: [
                          // ── Hero image ──────────────────────────────────
                          Container(
                            width: 180,
                            height: 180,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.mint.withValues(alpha: 0.1),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.mint.withValues(alpha: 0.2),
                                  blurRadius: 40,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/frequencies_hero.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // ── Section label ───────────────────────────────
                          Text(
                            'SOLFEGGIO & BINAURALES',
                            style: GoogleFonts.urbanist(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              color: AppColors.mint.withValues(alpha: 0.67),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Frecuencias sagradas utilizadas durante siglos\npara sanar, despertar y elevar la consciencia\na través del sonido.',
                            style: GoogleFonts.urbanist(
                              fontSize: 13,
                              color: AppColors.textTertiary,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 24),

                          // ── Frecuencias label ───────────────────────────
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Frecuencias Solfeggio',
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // ── Frequency cards ─────────────────────────────
                          ..._frequencies.map((f) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: _FrequencyCard(item: f),
                          )),
                          const SizedBox(height: 20),

                          // ── Stats ────────────────────────────────────────
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.mint.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.mint.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.trendingUp,
                                  color: AppColors.mint,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    '528 Hz es la frecuencia más escuchada este mes',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.mint,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ── Mint CTA ─────────────────────────────────────
                          GestureDetector(
                            onTap: () => context.push('/healing'),
                            child: Container(
                              width: double.infinity,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF55EFC4),
                                    Color(0xFF00CEC9),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.mint.withValues(alpha: 0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Crear mezcla personalizada',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF001A17),
                                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}

class _FreqData {
  final String hz;
  final String name;
  final String description;
  final bool isHighlighted;
  final bool isPro;

  const _FreqData(
    this.hz,
    this.name,
    this.description, {
    this.isHighlighted = false,
    this.isPro = false,
  });
}

const List<_FreqData> _frequencies = [
  _FreqData('396 Hz', 'Liberación', 'Elimina el miedo y la culpa'),
  _FreqData('432 Hz', 'Armonía', 'Sintoniza con el universo', isPro: true),
  _FreqData(
    '528 Hz',
    'Transformación',
    'Reparación del ADN y amor',
    isHighlighted: true,
  ),
  _FreqData('639 Hz', 'Conexión', 'Relaciones y comunicación', isPro: true),
  _FreqData('741 Hz', 'Despertar', 'Intuición y consciencia'),
];

class _FrequencyCard extends StatelessWidget {
  final _FreqData item;

  const _FrequencyCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final accentColor = item.isHighlighted ? AppColors.mint : AppColors.white;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: item.isHighlighted
            ? AppColors.mint.withValues(alpha: 0.1)
            : AppColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: item.isHighlighted
              ? AppColors.mint.withValues(alpha: 0.3)
              : AppColors.surfaceBorderLight,
          width: item.isHighlighted ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          // Hz badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.mint.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.mint.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              item.hz,
              style: GoogleFonts.urbanist(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppColors.mint,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.description,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (item.isPro)
            Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                gradient: AppGradients.primaryButton,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'PRO',
                style: GoogleFonts.urbanist(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          GestureDetector(
            onTap: () => context.push('/player'),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.mint.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.mint.withValues(alpha: 0.3),
                ),
              ),
              child: const Icon(
                LucideIcons.play,
                color: AppColors.mint,
                size: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
