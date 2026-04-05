import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../services/revenuecat_service.dart';
import '../utils/responsive.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(40)),
            child: Column(
              children: [
                // ── Header ──────────────────────────────────────────────
                ScreenNav(
                  title: 'Mi Perfil',
                  showBack: true,
                  trailing: Container(
                    width: Responsive.w(36),
                    height: Responsive.w(36),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surfaceBorderLight),
                    ),
                    child: Icon(
                      LucideIcons.pencil,
                      color: Colors.white,
                      size: Responsive.w(16),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(32)),

                // ── Avatar ───────────────────────────────────────────────
                Container(
                  width: Responsive.w(94),
                  height: Responsive.w(94),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.amber],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: Responsive.w(24),
                        offset: Offset(0, Responsive.h(8)),
                      ),
                    ],
                  ),
                  child: Icon(LucideIcons.user, color: Colors.white, size: Responsive.w(42)),
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
                SizedBox(height: Responsive.h(4)),
                Text(
                  'Exploradora de frecuencias · MANTRAS Pro',
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(13),
                    color: const Color(0xCCFFFFFF),
                  ),
                ),
                SizedBox(height: Responsive.h(14)),

                // ── Plan badge ───────────────────────────────────────────
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(20),
                    vertical: Responsive.h(8),
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryButton,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: Responsive.w(12),
                        offset: Offset(0, Responsive.h(4)),
                      ),
                    ],
                  ),
                  child: Text(
                    RevenueCatService.instance.isPro
                        ? 'Plan Pro · Activo'
                        : 'Plan Gratuito',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(13),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(28)),

                // ── Stats ────────────────────────────────────────────────
                Row(
                  children: [
                    _StatCard(value: '47', label: 'Sesiones'),
                    SizedBox(width: Responsive.w(10)),
                    _StatCard(value: '128h', label: 'Meditadas'),
                    SizedBox(width: Responsive.w(10)),
                    _StatCard(value: '21', label: 'Días streak'),
                  ],
                ),
                SizedBox(height: Responsive.h(28)),

                // ── Settings ─────────────────────────────────────────────
                _SectionBlock(
                  label: 'CONFIGURACIÓN',
                  children: [
                    _ProfileRow(
                      icon: LucideIcons.bell,
                      iconColor: AppColors.primaryLight,
                      title: 'Notificaciones',
                      onTap: () => context.push('/notifications-settings'),
                    ),
                    const _RowDivider(),
                    _ProfileRow(
                      icon: LucideIcons.globe,
                      iconColor: AppColors.mint,
                      title: 'Idioma',
                      onTap: () => context.push('/language'),
                    ),
                    const _RowDivider(),
                    _ProfileRow(
                      icon: LucideIcons.fileText,
                      iconColor: AppColors.amber,
                      title: 'Términos y Condiciones',
                      onTap: () => context.push('/terms'),
                    ),
                    const _RowDivider(),
                    _ProfileRow(
                      icon: LucideIcons.crown,
                      iconColor: AppColors.primary,
                      title: RevenueCatService.instance.isPro
                          ? 'Suscripción · Pro'
                          : 'Suscripción · Gratis',
                      trailingExtra: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(8),
                          vertical: Responsive.h(3),
                        ),
                        decoration: BoxDecoration(
                          color: RevenueCatService.instance.isPro
                              ? AppColors.mint.withValues(alpha: 0.2)
                              : AppColors.textMuted.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          RevenueCatService.instance.isPro ? 'Activo' : 'Gratis',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(11),
                            fontWeight: FontWeight.w700,
                            color: RevenueCatService.instance.isPro
                                ? AppColors.mint
                                : AppColors.textTertiary,
                          ),
                        ),
                      ),
                      onTap: () => context.push('/customer-center'),
                    ),
                    const _RowDivider(),
                    _ProfileRow(
                      icon: LucideIcons.mic,
                      iconColor: AppColors.primaryLight,
                      title: 'Mi Voz · Alquimista',
                      onTap: () => context.push('/alchemist'),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(28)),

                // ── Sign out ─────────────────────────────────────────────
                GestureDetector(
                  onTap: () => context.go('/'),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Responsive.h(16)),
                    decoration: BoxDecoration(
                      color: AppColors.danger.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(50),
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
                          'Cerrar Sesión',
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
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String value;
  final String label;

  const _StatCard({required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: Responsive.h(14)),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.surfaceBorderLight),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(22),
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            SizedBox(height: Responsive.h(2)),
            Text(
              label,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(11),
                color: const Color(0x60FFFFFF),
              ),
            ),
          ],
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
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.surfaceBorderLight),
          ),
          child: Column(children: children),
        ),
      ],
    );
  }
}

class _ProfileRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final Widget? trailingExtra;
  final VoidCallback? onTap;

  const _ProfileRow({
    required this.icon,
    required this.iconColor,
    required this.title,
    this.trailingExtra,
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
              width: Responsive.w(36),
              height: Responsive.w(36),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: Responsive.w(17)),
            ),
            SizedBox(width: Responsive.w(14)),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(15),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            if (trailingExtra != null) ...[
              trailingExtra!,
              SizedBox(width: Responsive.w(8)),
            ],
            Icon(
              LucideIcons.chevronRight,
              color: AppColors.textTertiary,
              size: Responsive.w(18),
            ),
          ],
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  const _RowDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: EdgeInsets.only(left: Responsive.w(66)),
      color: AppColors.white.withValues(alpha: 0.07),
    );
  }
}
