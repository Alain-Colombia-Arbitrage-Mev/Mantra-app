import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

class InviteFriendsScreen extends StatelessWidget {
  const InviteFriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              Responsive.w(20),
              Responsive.h(20),
              Responsive.w(20),
              Responsive.h(40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
                ScreenNav(
                  title: 'Invitar Amigos',
                  showBack: true,
                  trailing: Container(
                    width: Responsive.w(36),
                    height: Responsive.w(36),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.35),
                      ),
                    ),
                    child: Icon(
                      LucideIcons.gift,
                      color: AppColors.primaryLight,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(12)),

                // ── Purple glow ──────────────────────────────────────────
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: Responsive.w(200),
                    height: Responsive.h(120),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          blurRadius: Responsive.w(80),
                          spreadRadius: Responsive.w(20),
                        ),
                      ],
                    ),
                  ),
                ),

                // ── Icon ─────────────────────────────────────────────────
                Center(
                  child: Container(
                    width: Responsive.w(80),
                    height: Responsive.w(80),
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryButton,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.45),
                          blurRadius: Responsive.w(24),
                          offset: Offset(0, Responsive.h(8)),
                        ),
                      ],
                    ),
                    child: Icon(
                      LucideIcons.sparkles,
                      color: Colors.white,
                      size: Responsive.w(32),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(20)),

                // ── Title ────────────────────────────────────────────────
                Center(
                  child: Text(
                    'Semana gratis',
                    style: GoogleFonts.manrope(
                      fontSize: Responsive.sp(28),
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(6)),
                Center(
                  child: Text(
                    'por cada amigo que se una',
                    style: GoogleFonts.manrope(
                      fontSize: Responsive.sp(15),
                      color: const Color(0xCCFFFFFF),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(20)),

                // ── Stats pill ───────────────────────────────────────────
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(18),
                      vertical: Responsive.h(10),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: AppColors.surfaceBorderLight),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '0 / 1 amigos se han unido',
                          style: GoogleFonts.manrope(
                            fontSize: Responsive.sp(13),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: Responsive.w(10)),
                        Text(
                          '+7 días gratis',
                          style: GoogleFonts.manrope(
                            fontSize: Responsive.sp(13),
                            fontWeight: FontWeight.w700,
                            color: AppColors.mint,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(28)),

                // ── Code ─────────────────────────────────────────────────
                const SectionLabel('TU CÓDIGO PERSONAL'),
                SizedBox(height: Responsive.h(12)),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(20),
                    vertical: Responsive.h(18),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'MANTRALIA-XK29M',
                            style: GoogleFonts.manrope(
                              fontSize: Responsive.sp(22),
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(width: Responsive.w(12)),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: Responsive.w(36),
                              height: Responsive.w(36),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                LucideIcons.copy,
                                color: Colors.white,
                                size: Responsive.w(16),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.h(4)),
                      Text(
                        'Toca para copiar',
                        style: GoogleFonts.manrope(
                          fontSize: Responsive.sp(12),
                          color: const Color(0x50FFFFFF),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(28)),

                // ── How it works ─────────────────────────────────────────
                const SectionLabel('¿CÓMO FUNCIONA?'),
                SizedBox(height: Responsive.h(14)),
                _StepCard(number: 1, text: 'Comparte tu código con un amigo'),
                SizedBox(height: Responsive.h(10)),
                _StepCard(
                  number: 2,
                  text: 'Tu amigo descarga Mantralia y se registra',
                ),
                SizedBox(height: Responsive.h(10)),
                _StepCard(number: 3, text: '¡Ambos reciben 7 días gratis!'),
                SizedBox(height: Responsive.h(32)),

                // ── CTA ───────────────────────────────────────────────────
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Responsive.h(16)),
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryButton,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: Responsive.w(20),
                          offset: Offset(0, Responsive.h(8)),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.share2,
                          color: Colors.white,
                          size: Responsive.w(18),
                        ),
                        SizedBox(width: Responsive.w(10)),
                        Text(
                          'Compartir en WhatsApp · Telegram',
                          style: GoogleFonts.manrope(
                            fontSize: Responsive.sp(15),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(20)),

                // ── Share icons ───────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _ShareIcon(
                      icon: LucideIcons.messageCircle,
                      color: const Color(0xFF25D366),
                    ),
                    SizedBox(width: Responsive.w(16)),
                    _ShareIcon(
                      icon: LucideIcons.send,
                      color: const Color(0xFF229ED9),
                    ),
                    SizedBox(width: Responsive.w(16)),
                    _ShareIcon(
                      icon: LucideIcons.moreHorizontal,
                      color: AppColors.textTertiary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  final int number;
  final String text;

  const _StepCard({required this.number, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(16),
        vertical: Responsive.h(14),
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.w(32),
            height: Responsive.w(32),
            decoration: BoxDecoration(
              gradient: AppGradients.primaryButton,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '$number',
                style: GoogleFonts.manrope(
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: Responsive.w(14)),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.manrope(
                fontSize: Responsive.sp(14),
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ShareIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _ShareIcon({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Responsive.w(52),
      height: Responsive.w(52),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Icon(icon, color: color, size: Responsive.w(22)),
    );
  }
}
