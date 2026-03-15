import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class CollectionsScreen extends StatelessWidget {
  const CollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      extendBody: true,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 48),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Nav ─────────────────────────────────────────────────
                ScreenNav(
                  title: 'Mis Colecciones',
                  showBack: true,
                  trailing: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.4),
                      ),
                    ),
                    child: const Icon(
                      LucideIcons.plus,
                      color: AppColors.primary,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // ── Section label ────────────────────────────────────────
                const SectionLabel('PROGRAMAS DE BIO-HACKING'),
                const SizedBox(height: 14),

                // ── Featured card ────────────────────────────────────────
                GestureDetector(
                  onTap: () => context.push('/playlist-detail'),
                  child: _FeaturedCard(),
                ),
                const SizedBox(height: 24),

                // ── Track list ───────────────────────────────────────────
                _TrackItem(
                  thumbColor: const Color(0x33F9A826),
                  icon: LucideIcons.sparkles,
                  iconColor: AppColors.amber,
                  title: 'Reprograma tu ADN · 528Hz',
                  subtitle: '30 min · Solfeggio · Theta',
                  actionIcon: LucideIcons.playCircle,
                  actionColor: AppColors.primary,
                  isPlaying: false,
                ),
                const SizedBox(height: 10),
                _TrackItem(
                  thumbColor: const Color(0x666C5CE7),
                  icon: LucideIcons.brain,
                  iconColor: AppColors.primaryLight,
                  title: 'Sana a tu Niño Interior',
                  subtitle: '45 min · Delta · Sanar traumas',
                  actionIcon: LucideIcons.pauseCircle,
                  actionColor: AppColors.primaryLight,
                  isPlaying: true,
                ),
                const SizedBox(height: 10),
                _TrackItem(
                  thumbColor: const Color(0x3355EFC4),
                  icon: LucideIcons.zap,
                  iconColor: AppColors.mint,
                  title: 'Activa tu Merkaba · 963Hz',
                  subtitle: '20 min · Gamma · Nivel maestro',
                  actionIcon: LucideIcons.playCircle,
                  actionColor: AppColors.mint,
                  isPlaying: false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: 156,
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'assets/images/collection_featured.jpg',
              fit: BoxFit.cover,
            ),
            // Dark gradient overlay
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0x330F0A2A), Color(0xDD0F0A2A)],
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.all(18),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Activación de Ondas Theta',
                          style: GoogleFonts.urbanist(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Bio-Hacking · 3 sesiones · 95 min',
                          style: GoogleFonts.urbanist(
                            fontSize: 12,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Glass play button
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Icon(
                      LucideIcons.play,
                      color: Colors.white,
                      size: 18,
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

class _TrackItem extends StatelessWidget {
  final Color thumbColor;
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final IconData actionIcon;
  final Color actionColor;
  final bool isPlaying;

  const _TrackItem({
    required this.thumbColor,
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.actionIcon,
    required this.actionColor,
    required this.isPlaying,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/player'),
      child: Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isPlaying
            ? AppColors.primary.withValues(alpha: 0.12)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPlaying
              ? AppColors.primary.withValues(alpha: 0.5)
              : AppColors.surfaceBorderLight,
        ),
      ),
      child: Row(
        children: [
          // Thumbnail
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: thumbColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          // Text
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
          const SizedBox(width: 10),
          Icon(actionIcon, color: actionColor, size: 30),
        ],
      ),
    ),
    );
  }
}
