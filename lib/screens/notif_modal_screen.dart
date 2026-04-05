import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class NotifModalScreen extends StatelessWidget {
  const NotifModalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: const Color(0xF5060612),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: Responsive.h(-60),
            left: MediaQuery.of(context).size.width / 2 - Responsive.w(140),
            child: Container(
              width: Responsive.w(280),
              height: Responsive.w(280),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.35),
                    blurRadius: Responsive.w(140),
                    spreadRadius: Responsive.w(60),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: Responsive.h(-40),
            right: Responsive.w(-40),
            child: Container(
              width: Responsive.w(200),
              height: Responsive.w(200),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.amber.withValues(alpha: 0.20),
                    blurRadius: Responsive.w(100),
                    spreadRadius: Responsive.w(40),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(32)),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        width: Responsive.w(36),
                        height: Responsive.w(36),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surfaceBorderLight,
                          ),
                        ),
                        child: Icon(
                          LucideIcons.x,
                          color: Colors.white,
                          size: Responsive.w(18),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(24)),
                  Container(
                    width: Responsive.w(80),
                    height: Responsive.w(80),
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryButton,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.45),
                          blurRadius: Responsive.w(30),
                          offset: Offset(0, Responsive.h(10)),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        '✦',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(38),
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(16)),
                  Text(
                    'HORA ESPEJO 11:11',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(13),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 2.0,
                      color: AppColors.primaryLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Responsive.h(12)),
                  Text(
                    'Puerta de\nManifestación',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(34),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.15,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: Responsive.h(16)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _TagPill(
                        label: '⚡ Júpiter activo',
                        bgColor: AppColors.primary.withValues(alpha: 0.2),
                        borderColor: AppColors.primary.withValues(alpha: 0.4),
                        textColor: AppColors.primaryLight,
                      ),
                      SizedBox(width: Responsive.w(8)),
                      _TagPill(
                        label: '14 min restantes',
                        bgColor: AppColors.amber.withValues(alpha: 0.15),
                        borderColor: AppColors.amber.withValues(alpha: 0.35),
                        textColor: AppColors.amber,
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.h(20)),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(Responsive.w(18)),
                    decoration: BoxDecoration(
                      color: const Color(0x0DFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0x22FFFFFF),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '«Pide y se te dará, busca y encontrarás,\ntoca y se te abrirá la puerta»',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(15),
                            color: const Color(0xEEFFFFFF),
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: Responsive.h(8)),
                        Text(
                          '— Tehilim 27 · Afirmación del día',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(11),
                            color: const Color(0x55FFFFFF),
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
                      'MANTRAS DEL DÍA',
                      style: GoogleFonts.urbanist(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(12)),
                  Row(
                    children: [
                      Expanded(
                        child: _MantraCard(
                          icon: LucideIcons.gem,
                          iconColor: AppColors.primaryLight,
                          fillColor: const Color(0x206C5CE7),
                          borderColor: const Color(0x446C5CE7),
                          line1: 'Abundan',
                          line2: 'cia',
                        ),
                      ),
                      SizedBox(width: Responsive.w(8)),
                      Expanded(
                        child: _MantraCard(
                          icon: LucideIcons.heart,
                          iconColor: const Color(0xFFE84393),
                          fillColor: const Color(0x20E84393),
                          borderColor: const Color(0x44E84393),
                          line1: 'Amor',
                          line2: '',
                        ),
                      ),
                      SizedBox(width: Responsive.w(8)),
                      Expanded(
                        child: _MantraCard(
                          icon: LucideIcons.leaf,
                          iconColor: AppColors.mint,
                          fillColor: const Color(0x2055EFC4),
                          borderColor: const Color(0x4455EFC4),
                          line1: 'Salud',
                          line2: '',
                        ),
                      ),
                      SizedBox(width: Responsive.w(8)),
                      Expanded(
                        child: _MantraCard(
                          icon: LucideIcons.briefcase,
                          iconColor: AppColors.amber,
                          fillColor: const Color(0x20F9A826),
                          borderColor: const Color(0x44F9A826),
                          line1: 'Trabajo',
                          line2: '',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.h(24)),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'TU RITUAL AHORA',
                      style: GoogleFonts.urbanist(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(14)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _RitualStep(
                        label: 'Afirmar',
                        isActive: true,
                        icon: LucideIcons.sparkles,
                      ),
                      _StepChevron(),
                      _RitualStep(
                        label: 'Tehilim',
                        isActive: false,
                        icon: LucideIcons.bookOpen,
                      ),
                      _StepChevron(),
                      _RitualStep(
                        label: 'Meditar',
                        isActive: false,
                        icon: LucideIcons.brain,
                      ),
                    ],
                  ),
                  SizedBox(height: Responsive.h(24)),
                  GestureDetector(
                    onTap: () => context.push('/tehilim'),
                    child: Container(
                      width: double.infinity,
                      height: Responsive.h(60),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Color(0xFF6C5CE7), Color(0xFF8B7CF8)],
                        ),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.40),
                            blurRadius: Responsive.w(20),
                            offset: Offset(0, Responsive.h(8)),
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
                            'Comenzar mi ritual ahora',
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
                  SizedBox(height: Responsive.h(12)),
                  GestureDetector(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: Responsive.h(52),
                      decoration: BoxDecoration(
                        color: const Color(0x0DFFFFFF),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Recuérdame en 5 min',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(14),
                            fontWeight: FontWeight.w600,
                            color: Colors.white.withValues(alpha: 0.66),
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
    );
  }
}

class _TagPill extends StatelessWidget {
  final String label;
  final Color bgColor;
  final Color borderColor;
  final Color textColor;

  const _TagPill({
    required this.label,
    required this.bgColor,
    required this.borderColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(14), vertical: Responsive.h(7)),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: borderColor),
      ),
      child: Text(
        label,
        style: GoogleFonts.urbanist(
          fontSize: Responsive.sp(12),
          fontWeight: FontWeight.w600,
          color: textColor,
        ),
      ),
    );
  }
}

class _MantraCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color fillColor;
  final Color borderColor;
  final String line1;
  final String line2;

  const _MantraCard({
    required this.icon,
    required this.iconColor,
    required this.fillColor,
    required this.borderColor,
    required this.line1,
    required this.line2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.h(90),
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: Responsive.w(22)),
          SizedBox(height: Responsive.h(6)),
          Text(
            line1,
            style: GoogleFonts.urbanist(
              fontSize: Responsive.sp(11),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          if (line2.isNotEmpty)
            Text(
              line2,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(11),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );
  }
}

class _RitualStep extends StatelessWidget {
  final String label;
  final bool isActive;
  final IconData icon;

  const _RitualStep({
    required this.label,
    required this.isActive,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: Responsive.w(52),
          height: Responsive.w(52),
          decoration: BoxDecoration(
            color: isActive
                ? AppColors.primary
                : Colors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive
                  ? AppColors.primary
                  : Colors.white.withValues(alpha: 0.2),
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: Responsive.w(16),
                      offset: Offset(0, Responsive.h(4)),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.55),
            size: Responsive.w(22),
          ),
        ),
        SizedBox(height: Responsive.h(6)),
        Text(
          label,
          style: GoogleFonts.urbanist(
            fontSize: Responsive.sp(11),
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.white.withValues(alpha: 0.55),
          ),
        ),
      ],
    );
  }
}

class _StepChevron extends StatelessWidget {
  const _StepChevron();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Responsive.h(20)),
      child: Icon(
        LucideIcons.chevronRight,
        color: Colors.white.withValues(alpha: 0.30),
        size: Responsive.w(20),
      ),
    );
  }
}
