import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class PlaylistDetailScreen extends StatelessWidget {
  const PlaylistDetailScreen({super.key});

  static const List<_Track> _tracks = [
    _Track(1, 'Activación Theta', '528Hz · 8:24', Color(0xFF6C5CE7)),
    _Track(2, 'Abundancia Profunda', '432Hz · 12:10', Color(0xFFFFD700)),
    _Track(3, 'Reparación ADN', '528Hz · 15:33', Color(0xFF55EFC4)),
    _Track(4, 'Ondas Delta', 'Sleep · 30:00', Color(0xFFA29BFE)),
    _Track(5, 'Corazón Abierto', '639Hz · 10:45', Color(0xFFDDA0DD)),
    _Track(6, 'Despertar Interior', '741Hz · 9:18', Color(0xFFC0C0FF)),
  ];

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0C0A20),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0C0A20), Color(0xFF0A0A1A)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // ── Back header ──────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(16), Responsive.w(20), 0),
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
                        'Colección',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(17),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: Responsive.w(36),
                      height: Responsive.w(36),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surfaceBorderLight),
                      ),
                      child: Icon(
                        LucideIcons.moreHorizontal,
                        color: Colors.white,
                        size: Responsive.w(18),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(24), Responsive.w(20), Responsive.h(32)),
                  child: Column(
                    children: [
                      // ── Cover image ────────────────────────────────────
                      Container(
                        width: Responsive.w(280),
                        height: Responsive.w(280),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.35),
                              blurRadius: Responsive.w(40),
                              offset: Offset(0, Responsive.h(16)),
                            ),
                          ],
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/collection_featured.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.5, 1.0],
                                  colors: [
                                    Colors.transparent,
                                    Color(0xCC0C0A20),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Responsive.h(20)),

                      // ── Playlist info ──────────────────────────────────
                      Text(
                        'Activaciones Theta',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(24),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: Responsive.h(8)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.music,
                            color: AppColors.textMuted,
                            size: Responsive.w(14),
                          ),
                          SizedBox(width: Responsive.w(6)),
                          Text(
                            '6 pistas',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              color: AppColors.textTertiary,
                            ),
                          ),
                          SizedBox(width: Responsive.w(16)),
                          Icon(
                            LucideIcons.clock,
                            color: AppColors.textMuted,
                            size: Responsive.w(14),
                          ),
                          SizedBox(width: Responsive.w(6)),
                          Text(
                            '1h 26min',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              color: AppColors.textTertiary,
                            ),
                          ),
                          SizedBox(width: Responsive.w(16)),
                          Icon(
                            LucideIcons.user,
                            color: AppColors.textMuted,
                            size: Responsive.w(14),
                          ),
                          SizedBox(width: Responsive.w(6)),
                          Text(
                            'Mantras App',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.h(20)),

                      // ── Action buttons ─────────────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => context.push('/player-enhanced'),
                              child: Container(
                                height: Responsive.h(48),
                                decoration: BoxDecoration(
                                  gradient: AppGradients.primaryButton,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.4,
                                      ),
                                      blurRadius: Responsive.w(16),
                                      offset: Offset(0, Responsive.h(6)),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      LucideIcons.play,
                                      color: Colors.white,
                                      size: Responsive.w(18),
                                    ),
                                    SizedBox(width: Responsive.w(8)),
                                    Text(
                                      'Reproducir todo',
                                      style: GoogleFonts.urbanist(
                                        fontSize: Responsive.sp(14),
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: Responsive.w(12)),
                          Container(
                            width: Responsive.w(48),
                            height: Responsive.h(48),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.surfaceBorderLight,
                              ),
                            ),
                            child: Icon(
                              LucideIcons.shuffle,
                              color: Colors.white,
                              size: Responsive.w(18),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.h(24)),

                      // ── Track list ─────────────────────────────────────
                      ...List.generate(_tracks.length, (i) {
                        final t = _tracks[i];
                        return GestureDetector(
                          onTap: () => context.push('/player-enhanced'),
                          child: Padding(
                            padding: EdgeInsets.only(bottom: Responsive.h(8)),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Responsive.w(14),
                                vertical: Responsive.h(12),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.white.withValues(alpha: 0.05),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.surfaceBorderLight,
                                ),
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: Responsive.w(24),
                                    child: Text(
                                      '${t.number}',
                                      style: GoogleFonts.urbanist(
                                        fontSize: Responsive.sp(13),
                                        color: AppColors.textMuted,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(width: Responsive.w(10)),
                                  Container(
                                    width: Responsive.w(38),
                                    height: Responsive.w(38),
                                    decoration: BoxDecoration(
                                      color: t.color.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      LucideIcons.music,
                                      color: t.color,
                                      size: Responsive.w(16),
                                    ),
                                  ),
                                  SizedBox(width: Responsive.w(12)),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          t.title,
                                          style: GoogleFonts.urbanist(
                                            fontSize: Responsive.sp(13),
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          t.meta,
                                          style: GoogleFonts.urbanist(
                                            fontSize: Responsive.sp(11),
                                            color: AppColors.textTertiary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    LucideIcons.moreHorizontal,
                                    color: AppColors.textMuted,
                                    size: Responsive.w(16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
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

class _Track {
  final int number;
  final String title;
  final String meta;
  final Color color;

  const _Track(this.number, this.title, this.meta, this.color);
}
