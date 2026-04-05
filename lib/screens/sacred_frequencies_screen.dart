import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class SacredFrequenciesScreen extends StatelessWidget {
  const SacredFrequenciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
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
              top: Responsive.h(60),
              left: Responsive.w(-60),
              child: Container(
                width: Responsive.w(280),
                height: Responsive.w(280),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.mint.withValues(alpha: 0.14),
                      blurRadius: Responsive.w(140),
                      spreadRadius: Responsive.w(70),
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
                    padding: EdgeInsets.fromLTRB(
                        Responsive.w(20), Responsive.h(16), Responsive.w(20), 0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (Navigator.of(context).canPop()) {
                              Navigator.of(context).pop();
                            }
                          },
                          child: Container(
                            width: Responsive.w(36),
                            height: Responsive.w(36),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.surfaceBorderLight,
                              ),
                            ),
                            child: Icon(
                              LucideIcons.chevronLeft,
                              color: Colors.white,
                              size: Responsive.w(18),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Frecuencias Sagradas',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(17),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
                          width: Responsive.w(36),
                          height: Responsive.w(36),
                          decoration: BoxDecoration(
                            color: AppColors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: AppColors.surfaceBorderLight,
                            ),
                          ),
                          child: Icon(
                            LucideIcons.slidersHorizontal,
                            color: Colors.white,
                            size: Responsive.w(17),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                          Responsive.w(20),
                          Responsive.h(24),
                          Responsive.w(20),
                          Responsive.h(32)),
                      child: Column(
                        children: [
                          // ── Hero image ──────────────────────────────────
                          Container(
                            width: Responsive.w(180),
                            height: Responsive.w(180),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.mint.withValues(alpha: 0.1),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      AppColors.mint.withValues(alpha: 0.2),
                                  blurRadius: Responsive.w(40),
                                  spreadRadius: Responsive.w(8),
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
                          SizedBox(height: Responsive.h(16)),

                          // ── Section label ───────────────────────────────
                          Text(
                            'SOLFEGGIO & BINAURALES',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(11),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              color:
                                  AppColors.mint.withValues(alpha: 0.67),
                            ),
                          ),
                          SizedBox(height: Responsive.h(8)),
                          Text(
                            'Frecuencias sagradas utilizadas durante siglos\npara sanar, despertar y elevar la consciencia\na través del sonido.',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              color: AppColors.textTertiary,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Responsive.h(24)),

                          // ── Frecuencias label ───────────────────────────
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Frecuencias Solfeggio',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(15),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: Responsive.h(12)),

                          // ── Frequency cards ─────────────────────────────
                          ..._frequencies.map((f) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: Responsive.h(8)),
                                child: _FrequencyCard(item: f),
                              )),
                          SizedBox(height: Responsive.h(20)),

                          // ── Stats ────────────────────────────────────────
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(Responsive.w(16)),
                            decoration: BoxDecoration(
                              color:
                                  AppColors.mint.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(
                                  Responsive.w(14)),
                              border: Border.all(
                                color: AppColors.mint
                                    .withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.trendingUp,
                                  color: AppColors.mint,
                                  size: Responsive.w(16),
                                ),
                                SizedBox(width: Responsive.w(8)),
                                Flexible(
                                  child: Text(
                                    '528 Hz es la frecuencia más escuchada este mes',
                                    style: GoogleFonts.urbanist(
                                      fontSize: Responsive.sp(13),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.mint,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Responsive.h(20)),

                          // ── Mint CTA ─────────────────────────────────────
                          GestureDetector(
                            onTap: () => context.push('/healing'),
                            child: Container(
                              width: double.infinity,
                              height: Responsive.h(58),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFF55EFC4),
                                    Color(0xFF00CEC9),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(
                                    Responsive.w(16)),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.mint
                                        .withValues(alpha: 0.4),
                                    blurRadius: Responsive.w(20),
                                    offset:
                                        Offset(0, Responsive.h(8)),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Crear mezcla personalizada',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(16),
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
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: item.isHighlighted
            ? AppColors.mint.withValues(alpha: 0.1)
            : AppColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(Responsive.w(14)),
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
            padding: EdgeInsets.symmetric(
                horizontal: Responsive.w(10), vertical: Responsive.h(6)),
            decoration: BoxDecoration(
              color: AppColors.mint.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(Responsive.w(10)),
              border: Border.all(
                color: AppColors.mint.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              item.hz,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(12),
                fontWeight: FontWeight.w800,
                color: AppColors.mint,
              ),
            ),
          ),
          SizedBox(width: Responsive.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(14),
                    fontWeight: FontWeight.w700,
                    color: accentColor,
                  ),
                ),
                SizedBox(height: Responsive.h(2)),
                Text(
                  item.description,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(12),
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (item.isPro)
            Container(
              margin: EdgeInsets.only(right: Responsive.w(8)),
              padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(8), vertical: Responsive.h(3)),
              decoration: BoxDecoration(
                gradient: AppGradients.primaryButton,
                borderRadius: BorderRadius.circular(Responsive.w(50)),
              ),
              child: Text(
                'PRO',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(10),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          GestureDetector(
            onTap: () => context.push('/player'),
            child: Container(
              width: Responsive.w(36),
              height: Responsive.w(36),
              decoration: BoxDecoration(
                color: AppColors.mint.withValues(alpha: 0.15),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.mint.withValues(alpha: 0.3),
                ),
              ),
              child: Icon(
                LucideIcons.play,
                color: AppColors.mint,
                size: Responsive.w(15),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
