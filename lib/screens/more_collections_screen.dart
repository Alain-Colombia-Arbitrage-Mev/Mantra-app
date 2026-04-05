import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

const List<_CollectionData> _popularCollections = [
  _CollectionData('Abundancia Total', '8 audios · 2h 30m', Color(0xFFFFD700)),
  _CollectionData('Sanación Profunda', '6 audios · 1h 45m', Color(0xFF55EFC4)),
  _CollectionData('Despertar Espiritual', '10 audios · 3h 15m', Color(0xFF6C5CE7)),
  _CollectionData('Sueño Reparador', '5 audios · 4h 00m', Color(0xFF74B9FF)),
];

const List<_UserCollection> _userCollections = [
  _UserCollection('Mis Mantras', '4 audios', LucideIcons.music),
  _UserCollection('Rutina Matutina', '3 audios', LucideIcons.sun),
];

class MoreCollectionsScreen extends StatelessWidget {
  const MoreCollectionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: const Color(0xEE0A0A1A),
      body: ScreenBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(32)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
                ScreenNav(
                  title: 'Más Colecciones',
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
                      LucideIcons.slidersHorizontal,
                      color: Colors.white,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(28)),

                // ── Popular collections ──────────────────────────────────
                const SectionLabel('COLECCIONES POPULARES'),
                SizedBox(height: Responsive.h(12)),

                ..._popularCollections.map((c) => Padding(
                      padding: EdgeInsets.only(bottom: Responsive.h(10)),
                      child: _PopularCard(data: c),
                    )),
                SizedBox(height: Responsive.h(20)),

                // ── User collections ─────────────────────────────────────
                const SectionLabel('CREADOS POR TI'),
                SizedBox(height: Responsive.h(12)),

                ..._userCollections.map((c) => Padding(
                      padding: EdgeInsets.only(bottom: Responsive.h(10)),
                      child: _UserCollectionCard(data: c),
                    )),
                SizedBox(height: Responsive.h(20)),

                // ── CTA ──────────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  height: Responsive.h(56),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryButton,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: Responsive.w(20),
                        offset: Offset(0, Responsive.h(8)),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Próximamente',
                            style: GoogleFonts.urbanist(),
                          ),
                          backgroundColor: AppColors.primary,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Crear nueva colección',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(16),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: Responsive.w(10)),
                          Icon(
                            LucideIcons.plus,
                            color: Colors.white,
                            size: Responsive.w(20),
                          ),
                        ],
                      ),
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

class _CollectionData {
  final String title;
  final String meta;
  final Color accent;
  const _CollectionData(this.title, this.meta, this.accent);
}

class _UserCollection {
  final String title;
  final String count;
  final IconData icon;
  const _UserCollection(this.title, this.count, this.icon);
}

class _PopularCard extends StatelessWidget {
  final _CollectionData data;
  const _PopularCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/collections'),
      child: Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: Responsive.w(4),
            decoration: BoxDecoration(
              color: data.accent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(14),
                bottomLeft: Radius.circular(14),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Responsive.w(16), vertical: Responsive.h(14)),
              child: Row(
                children: [
                  Container(
                    width: Responsive.w(44),
                    height: Responsive.w(44),
                    decoration: BoxDecoration(
                      color: data.accent.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: data.accent.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Icon(
                      LucideIcons.listMusic,
                      color: data.accent,
                      size: Responsive.w(20),
                    ),
                  ),
                  SizedBox(width: Responsive.w(12)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.title,
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(15),
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: Responsive.h(3)),
                        Text(
                          data.meta,
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(12),
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    LucideIcons.chevronRight,
                    color: AppColors.textMuted,
                    size: Responsive.w(20),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}

class _UserCollectionCard extends StatelessWidget {
  final _UserCollection data;
  const _UserCollectionCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16), vertical: Responsive.h(14)),
      child: Row(
        children: [
          Container(
            width: Responsive.w(44),
            height: Responsive.w(44),
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.primaryLight.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(data.icon, color: AppColors.primaryLight, size: Responsive.w(20)),
          ),
          SizedBox(width: Responsive.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.title,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(15),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Responsive.h(2)),
                Text(
                  data.count,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(12),
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          Icon(LucideIcons.chevronRight, color: AppColors.textMuted, size: Responsive.w(20)),
        ],
      ),
    );
  }
}
