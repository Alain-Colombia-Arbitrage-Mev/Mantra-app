import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../services/revenuecat_service.dart';
import '../utils/responsive.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(Responsive.pagePadding, Responsive.h(20), Responsive.pagePadding, Responsive.bottomNavPadding),
          child: Column(
            children: [
              // ── Nav ─────────────────────────────────────────────────
              const ScreenNav(title: 'Yo'),
              SizedBox(height: Responsive.h(32)),

              // ── Avatar ──────────────────────────────────────────────
              Container(
                width: Responsive.w(90),
                height: Responsive.w(90),
                decoration: BoxDecoration(
                  gradient: AppGradients.primaryButton,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: Responsive.w(20),
                      offset: Offset(0, Responsive.h(8)),
                    ),
                  ],
                ),
                child: Icon(LucideIcons.user, color: Colors.white, size: Responsive.w(40)),
              ),
              SizedBox(height: Responsive.h(16)),

              Text(
                'Tu Nombre',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(24),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: Responsive.h(6)),
              Text(
                RevenueCatService.instance.isPro
                    ? 'Plan Pro · 🔥 47 días de racha'
                    : 'Plan Gratuito · 🔥 47 días de racha',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(14),
                  color: const Color(0xCCFFFFFF),
                ),
              ),
              SizedBox(height: Responsive.h(32)),

              // ── Plan section ─────────────────────────────────────────
              _SectionBlock(
                label: 'MI PLAN',
                children: [
                  _SettingsRow(
                    icon: LucideIcons.crown,
                    iconColor: AppColors.gold,
                    title: RevenueCatService.instance.isPro
                        ? 'Plan Pro · Activo'
                        : 'Plan Gratuito',
                    subtitle: RevenueCatService.instance.isPro
                        ? 'Gestionar tu suscripción'
                        : 'Actualizar a Pro',
                    onTap: () => context.push('/customer-center'),
                    trailing: Icon(
                      LucideIcons.chevronRight,
                      color: AppColors.textTertiary,
                      size: Responsive.w(18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.h(20)),

              // ── Settings section ─────────────────────────────────────
              _SectionBlock(
                label: 'CONFIGURACIÓN',
                children: [
                  _SettingsRow(
                    icon: LucideIcons.messageCircle,
                    iconColor: AppColors.mint,
                    title: 'WhatsApp',
                    subtitle: 'Conectado · +52 555 123 4567',
                    onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Próximamente',
                          style: GoogleFonts.urbanist(),
                        ),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Responsive.w(12)),
                        ),
                      ),
                    ),
                    trailing: Icon(
                      LucideIcons.chevronRight,
                      color: AppColors.textTertiary,
                      size: Responsive.w(18),
                    ),
                  ),
                  const _Divider(),
                  _SettingsRow(
                    icon: LucideIcons.mic,
                    iconColor: AppColors.primary,
                    title: 'Mi Voz Clonada',
                    subtitle: 'Entrenando · 82% calidad',
                    onTap: () => context.push('/alchemist'),
                    trailing: Icon(
                      LucideIcons.chevronRight,
                      color: AppColors.textTertiary,
                      size: Responsive.w(18),
                    ),
                  ),
                  const _Divider(),
                  _SettingsRow(
                    icon: LucideIcons.creditCard,
                    iconColor: AppColors.chakra,
                    title: 'Suscripción',
                    subtitle: RevenueCatService.instance.isPro
                        ? 'Gestionar tu plan Pro'
                        : 'Actualizar a Pro',
                    onTap: () => context.push('/customer-center'),
                    trailing: Icon(
                      LucideIcons.chevronRight,
                      color: AppColors.textTertiary,
                      size: Responsive.w(18),
                    ),
                  ),
                  const _Divider(),
                  _SettingsRow(
                    icon: LucideIcons.settings,
                    iconColor: AppColors.textTertiary,
                    title: 'Ajustes',
                    subtitle: 'Notificaciones, idioma y más',
                    onTap: () => context.push('/my-profile'),
                    trailing: Icon(
                      LucideIcons.chevronRight,
                      color: AppColors.textTertiary,
                      size: Responsive.w(18),
                    ),
                  ),
                ],
              ),
              SizedBox(height: Responsive.h(24)),

              // ── Sign out ─────────────────────────────────────────────
              GestureDetector(
                onTap: () => context.go('/'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: Responsive.h(16)),
                  decoration: BoxDecoration(
                    color: AppColors.danger.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(Responsive.w(50)),
                    border: Border.all(
                      color: AppColors.danger.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.logOut,
                        color: AppColors.danger,
                        size: Responsive.w(18),
                      ),
                      SizedBox(width: Responsive.w(10)),
                      Text(
                        'Cerrar sesión',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(16),
                          fontWeight: FontWeight.w700,
                          color: AppColors.danger,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionBlock extends StatelessWidget {
  final String label;
  final List<Widget> children;

  const _SectionBlock({required this.label, required this.children});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(label),
        SizedBox(height: Responsive.h(10)),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surfaceLight,
            borderRadius: BorderRadius.circular(Responsive.w(16)),
            border: Border.all(color: AppColors.surfaceBorderLight),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _SettingsRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final Widget trailing;
  final VoidCallback? onTap;

  const _SettingsRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16), vertical: Responsive.h(14)),
      child: Row(
        children: [
          Container(
            width: Responsive.w(38),
            height: Responsive.w(38),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.18),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: Responsive.w(18)),
          ),
          SizedBox(width: Responsive.w(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(15),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
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
          trailing,
        ],
      ),
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.only(left: Responsive.w(68)),
      color: AppColors.white.withValues(alpha: 0.07),
    );
  }
}
