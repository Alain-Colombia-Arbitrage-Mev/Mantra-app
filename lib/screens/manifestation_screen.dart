import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';

class ManifestationScreen extends StatelessWidget {
  const ManifestationScreen({super.key});

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
            // Gold glow
            Positioned(
              top: 50,
              right: -40,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.14),
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
                            'Manifestación',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/gratitude-journal'),
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
                              LucideIcons.plus,
                              color: Colors.white,
                              size: 18,
                            ),
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
                                color: AppColors.gold.withValues(alpha: 0.1),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gold.withValues(alpha: 0.18),
                                  blurRadius: 40,
                                  spreadRadius: 8,
                                ),
                              ],
                            ),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/images/manifestation_hero.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // ── Intention label ─────────────────────────────
                          Text(
                            'TU INTENCIÓN DE HOY',
                            style: GoogleFonts.urbanist(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              color: AppColors.gold.withValues(alpha: 0.67),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // ── Quote card ──────────────────────────────────
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withValues(alpha: 0.07),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.gold.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '"Soy merecedor de abundancia y todo lo bueno fluye hacia mí"',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'Repite esta afirmación 3 veces con intención plena',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 13,
                                    color: AppColors.white.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),

                          // ── Técnicas label ──────────────────────────────
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Técnicas de manifestación',
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // ── Technique cards ─────────────────────────────
                          _TechniqueCard(
                            icon: LucideIcons.bookOpen,
                            iconColor: AppColors.mint,
                            title: 'Diario de gratitud',
                            subtitle: '5 min · Escritura consciente',
                            isNew: true,
                            onTap: () => context.push('/gratitude-journal'),
                          ),
                          const SizedBox(height: 8),
                          _TechniqueCard(
                            icon: LucideIcons.eye,
                            iconColor: AppColors.primaryLight,
                            title: 'Visualización creativa',
                            subtitle: '15 min · Meditación guiada',
                            isNew: false,
                            onTap: () => context.push('/player'),
                          ),
                          const SizedBox(height: 8),
                          _TechniqueCard(
                            icon: LucideIcons.hash,
                            iconColor: AppColors.gold,
                            title: 'Afirmaciones 369',
                            subtitle: '10 min · Técnica de Nikola Tesla',
                            isNew: true,
                            onTap: () {},
                          ),
                          const SizedBox(height: 20),

                          // ── Stats ────────────────────────────────────────
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.gold.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.sparkles,
                                  color: AppColors.gold,
                                  size: 16,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  '3,456 intenciones manifestadas hoy',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.gold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ── Gold CTA ─────────────────────────────────────
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: AppGradients.goldButton,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.gold.withValues(alpha: 0.4),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Crear mi intención',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1A0A00),
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

class _TechniqueCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isNew;
  final VoidCallback onTap;

  const _TechniqueCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isNew,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.surfaceBorderLight),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: iconColor.withValues(alpha: 0.3)),
              ),
              child: Icon(icon, color: iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (isNew)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.mint.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColors.mint.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  'Nuevo',
                  style: GoogleFonts.urbanist(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: AppColors.mint,
                  ),
                ),
              ),
            const SizedBox(width: 8),
            Icon(
              LucideIcons.chevronRight,
              color: AppColors.textMuted,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}
