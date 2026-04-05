import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class ChakrasScreen extends StatelessWidget {
  const ChakrasScreen({super.key});

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
            // Plum glow
            Positioned(
              top: Responsive.h(60),
              right: Responsive.w(-60),
              child: Container(
                width: Responsive.w(280),
                height: Responsive.w(280),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.chakra.withValues(alpha: 0.18),
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
                            'Chakras',
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
                            LucideIcons.bell,
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
                            width: Responsive.w(200),
                            height: Responsive.w(200),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.chakra
                                    .withValues(alpha: 0.2),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.chakra
                                      .withValues(alpha: 0.2),
                                  blurRadius: Responsive.w(40),
                                  spreadRadius: Responsive.w(10),
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/chakras_hero.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: Responsive.h(16)),

                          // ── Section label ───────────────────────────────
                          Text(
                            'Centros de energía vital',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(14),
                              fontWeight: FontWeight.w600,
                              color: AppColors.chakra,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Responsive.h(8)),
                          Text(
                            'Los chakras son centros de energía en el cuerpo\nque regulan el flujo vital y el equilibrio mental,\nemocional y espiritual.',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              color: AppColors.textTertiary,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: Responsive.h(24)),

                          // ── Chakra cards ─────────────────────────────────
                          ..._chakras.map((c) => Padding(
                                padding: EdgeInsets.only(
                                    bottom: Responsive.h(8)),
                                child: _ChakraCard(item: c),
                              )),
                          SizedBox(height: Responsive.h(20)),

                          // ── Stats ────────────────────────────────────────
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(Responsive.w(16)),
                            decoration: BoxDecoration(
                              color: AppColors.chakra
                                  .withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(
                                  Responsive.w(14)),
                              border: Border.all(
                                color: AppColors.chakra
                                    .withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.users,
                                  color: AppColors.chakra,
                                  size: Responsive.w(16),
                                ),
                                SizedBox(width: Responsive.w(8)),
                                Flexible(
                                  child: Text(
                                    '12,847 sesiones de chakras completadas esta semana',
                                    style: GoogleFonts.urbanist(
                                      fontSize: Responsive.sp(12),
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.chakra,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Responsive.h(20)),

                          // ── CTA ──────────────────────────────────────────
                          GestureDetector(
                            onTap: () => context.push('/player'),
                            child: Container(
                              width: double.infinity,
                              height: Responsive.h(58),
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Color(0xFFDDA0DD),
                                    Color(0xFFA29BFE),
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(
                                    Responsive.w(16)),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.chakra.withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: Responsive.w(20),
                                    offset:
                                        Offset(0, Responsive.h(8)),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Iniciar alineación guiada',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(16),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
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

class _ChakraData {
  final Color dot;
  final String name;
  final String subtitle;
  final bool isPro;

  const _ChakraData(this.dot, this.name, this.subtitle, {this.isPro = false});
}

const List<_ChakraData> _chakras = [
  _ChakraData(Color(0xFFFF4444), 'Muladhara', 'Raíz'),
  _ChakraData(Color(0xFFFF8C00), 'Svadhisthana', 'Sacro', isPro: true),
  _ChakraData(Color(0xFFFFD700), 'Manipura', 'Plexo Solar', isPro: true),
  _ChakraData(Color(0xFF55EFC4), 'Anahata', 'Corazón'),
  _ChakraData(Color(0xFF6C5CE7), 'Vishuddha', 'Garganta'),
  _ChakraData(Color(0xFFA29BFE), 'Ajna', 'Tercer Ojo', isPro: true),
  _ChakraData(Color(0xFFDDA0DD), 'Sahasrara', 'Corona'),
];

class _ChakraCard extends StatelessWidget {
  final _ChakraData item;

  const _ChakraCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: Responsive.w(16), vertical: Responsive.h(14)),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(Responsive.w(14)),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Row(
        children: [
          // Colored dot
          Container(
            width: Responsive.w(12),
            height: Responsive.w(12),
            decoration: BoxDecoration(
              color: item.dot,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: item.dot.withValues(alpha: 0.5),
                  blurRadius: Responsive.w(8),
                  spreadRadius: Responsive.w(2),
                ),
              ],
            ),
          ),
          SizedBox(width: Responsive.w(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(14),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Responsive.h(2)),
                Text(
                  item.subtitle,
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
          SizedBox(width: Responsive.w(8)),
          Icon(
            LucideIcons.chevronRight,
            color: AppColors.textMuted,
            size: Responsive.w(18),
          ),
        ],
      ),
    );
  }
}
