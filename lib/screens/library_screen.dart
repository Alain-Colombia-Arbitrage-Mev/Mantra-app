import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/screen_bg.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      extendBody: true,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(Responsive.pagePadding, Responsive.h(20), Responsive.pagePadding, Responsive.h(48)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Nav ─────────────────────────────────────────────────
                ScreenNav(
                  title: 'Mi Biblioteca',
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
                      LucideIcons.search,
                      color: Colors.white,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Section label ────────────────────────────────────────
                const SectionLabel('GUARDADOS · MIS FAVORITOS'),
                SizedBox(height: Responsive.h(14)),

                // ── Library cards ────────────────────────────────────────
                _LibraryCard(
                  imagePath: 'assets/images/library_card1.jpg',
                  overlayColors: const [Color(0x220F0A2A), Color(0xCC0F0A2A)],
                  title: 'Activa tu Campo Cuántico',
                  subtitle: 'Gamma · Alineación de chakras · 25 min',
                ),
                SizedBox(height: Responsive.h(10)),
                _LibraryCard(
                  imagePath: 'assets/images/library_card2.jpg',
                  overlayColors: const [Color(0x226C5CE7), Color(0xCC1A0A3A)],
                  title: 'Meditación del Alquimista',
                  subtitle: 'Theta 528Hz · Manifestar · 12 min',
                ),
                SizedBox(height: Responsive.h(10)),
                _LibraryCard(
                  imagePath: 'assets/images/collection_featured.jpg',
                  overlayColors: const [Color(0x22FFD700), Color(0xCC1A1000)],
                  title: 'Frecuencia del Amor · 639Hz',
                  subtitle: 'Solfeggio · Conexión · 20 min',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LibraryCard extends StatelessWidget {
  final String imagePath;
  final List<Color> overlayColors;
  final String title;
  final String subtitle;

  const _LibraryCard({
    required this.imagePath,
    required this.overlayColors,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/player'),
      child: ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        height: Responsive.h(156),
        width: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(imagePath, fit: BoxFit.cover),
            // Gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: overlayColors,
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(Responsive.w(18)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(16),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: Responsive.h(4)),
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
                  SizedBox(width: Responsive.w(12)),
                  // Glass play button
                  Container(
                    width: Responsive.w(40),
                    height: Responsive.w(40),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Icon(
                      LucideIcons.play,
                      color: Colors.white,
                      size: Responsive.w(18),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
    );
  }
}
