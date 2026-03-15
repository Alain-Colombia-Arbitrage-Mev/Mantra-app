import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: Column(
              children: [
                // ── Header ──────────────────────────────────────────────
                ScreenNav(
                  title: 'Mi Perfil',
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
                      LucideIcons.pencil,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 32),

                // ── Avatar ───────────────────────────────────────────────
                Container(
                  width: 94,
                  height: 94,
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
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Icon(LucideIcons.user, color: Colors.white, size: 42),
                ),
                const SizedBox(height: 16),
                Text(
                  'Tu Nombre',
                  style: GoogleFonts.urbanist(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Exploradora de frecuencias · MANTRAS Pro',
                  style: GoogleFonts.urbanist(
                    fontSize: 13,
                    color: const Color(0xCCFFFFFF),
                  ),
                ),
                const SizedBox(height: 14),

                // ── Plan badge ───────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryButton,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    'Plan Pro · Activo',
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Stats ────────────────────────────────────────────────
                Row(
                  children: [
                    _StatCard(value: '47', label: 'Sesiones'),
                    const SizedBox(width: 10),
                    _StatCard(value: '128h', label: 'Meditadas'),
                    const SizedBox(width: 10),
                    _StatCard(value: '21', label: 'Días streak'),
                  ],
                ),
                const SizedBox(height: 28),

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
                      title: 'Suscripción · Pro',
                      trailingExtra: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.mint.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Activo',
                          style: GoogleFonts.urbanist(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppColors.mint,
                          ),
                        ),
                      ),
                      onTap: () => context.push('/more-collections'),
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
                const SizedBox(height: 28),

                // ── Sign out ─────────────────────────────────────────────
                GestureDetector(
                  onTap: () => context.go('/'),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
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
                        const Icon(
                          LucideIcons.logOut,
                          color: AppColors.danger,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Cerrar Sesión',
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
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
        padding: const EdgeInsets.symmetric(vertical: 14),
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
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: GoogleFonts.urbanist(
                fontSize: 11,
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
        const SizedBox(height: 10),
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 17),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: GoogleFonts.urbanist(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            if (trailingExtra != null) ...[
              trailingExtra!,
              const SizedBox(width: 8),
            ],
            const Icon(
              LucideIcons.chevronRight,
              color: AppColors.textTertiary,
              size: 18,
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
      margin: const EdgeInsets.only(left: 66),
      color: AppColors.white.withValues(alpha: 0.07),
    );
  }
}
