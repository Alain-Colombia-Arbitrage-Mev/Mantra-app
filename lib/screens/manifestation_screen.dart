import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class ManifestationScreen extends StatelessWidget {
  const ManifestationScreen({super.key});

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
            Positioned(
              top: Responsive.h(50),
              right: Responsive.w(-40),
              child: Container(
                width: Responsive.w(260),
                height: Responsive.w(260),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.gold.withValues(alpha: 0.14),
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
                  Padding(
                    padding: EdgeInsets.fromLTRB(
                      Responsive.w(20), Responsive.h(16), Responsive.w(20), 0,
                    ),
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
                            'Manifestación',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(17),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.push('/gratitude-journal'),
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
                              LucideIcons.plus,
                              color: Colors.white,
                              size: Responsive.w(18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        Responsive.w(20), Responsive.h(24), Responsive.w(20), Responsive.h(32),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: Responsive.w(180),
                            height: Responsive.w(180),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.gold.withValues(alpha: 0.1),
                                width: 2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.gold.withValues(alpha: 0.18),
                                  blurRadius: Responsive.w(40),
                                  spreadRadius: Responsive.w(8),
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
                          SizedBox(height: Responsive.h(24)),
                          Text(
                            'TU INTENCIÓN DE HOY',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(11),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              color: AppColors.gold.withValues(alpha: 0.67),
                            ),
                          ),
                          SizedBox(height: Responsive.h(16)),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(Responsive.w(20)),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withValues(alpha: 0.07),
                              borderRadius: BorderRadius.circular(Responsive.w(20)),
                              border: Border.all(
                                color: AppColors.gold.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  '"Soy merecedor de abundancia y todo lo bueno fluye hacia mí"',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(20),
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: Responsive.h(12)),
                                Text(
                                  'Repite esta afirmación 3 veces con intención plena',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(13),
                                    color: AppColors.white.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Responsive.h(24)),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Técnicas de manifestación',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(15),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: Responsive.h(12)),
                          _TechniqueCard(
                            icon: LucideIcons.bookOpen,
                            iconColor: AppColors.mint,
                            title: 'Diario de gratitud',
                            subtitle: '5 min · Escritura consciente',
                            isNew: true,
                            onTap: () => context.push('/gratitude-journal'),
                          ),
                          SizedBox(height: Responsive.h(8)),
                          _TechniqueCard(
                            icon: LucideIcons.eye,
                            iconColor: AppColors.primaryLight,
                            title: 'Visualización creativa',
                            subtitle: '15 min · Meditación guiada',
                            isNew: false,
                            onTap: () => context.push('/player'),
                          ),
                          SizedBox(height: Responsive.h(8)),
                          _TechniqueCard(
                            icon: LucideIcons.hash,
                            iconColor: AppColors.gold,
                            title: 'Afirmaciones 369',
                            subtitle: '10 min · Técnica de Nikola Tesla',
                            isNew: true,
                            onTap: () {},
                          ),
                          SizedBox(height: Responsive.h(20)),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(Responsive.w(16)),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(Responsive.w(14)),
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
                                  size: Responsive.w(16),
                                ),
                                SizedBox(width: Responsive.w(8)),
                                Text(
                                  '3,456 intenciones manifestadas hoy',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(13),
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.gold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: Responsive.h(20)),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              height: Responsive.h(58),
                              decoration: BoxDecoration(
                                gradient: AppGradients.goldButton,
                                borderRadius: BorderRadius.circular(Responsive.w(16)),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.gold.withValues(alpha: 0.4),
                                    blurRadius: Responsive.w(20),
                                    offset: Offset(0, Responsive.h(8)),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Crear mi intención',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(16),
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
        padding: EdgeInsets.all(Responsive.w(16)),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(Responsive.w(14)),
          border: Border.all(color: AppColors.surfaceBorderLight),
        ),
        child: Row(
          children: [
            Container(
              width: Responsive.w(44),
              height: Responsive.w(44),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(Responsive.w(12)),
                border: Border.all(color: iconColor.withValues(alpha: 0.3)),
              ),
              child: Icon(icon, color: iconColor, size: Responsive.w(20)),
            ),
            SizedBox(width: Responsive.w(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(14),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Responsive.h(3)),
                  Text(
                    subtitle,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (isNew)
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: Responsive.w(8), vertical: Responsive.h(3),
                ),
                decoration: BoxDecoration(
                  color: AppColors.mint.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(Responsive.w(50)),
                  border: Border.all(
                    color: AppColors.mint.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  'Nuevo',
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(10),
                    fontWeight: FontWeight.w700,
                    color: AppColors.mint,
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
      ),
    );
  }
}
