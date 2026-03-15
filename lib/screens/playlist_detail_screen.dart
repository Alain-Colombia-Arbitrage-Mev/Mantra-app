import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';

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
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surfaceBorderLight,
                          ),
                        ),
                        child: const Icon(
                          LucideIcons.chevronLeft,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Colección',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surfaceBorderLight),
                      ),
                      child: const Icon(
                        LucideIcons.moreHorizontal,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  child: Column(
                    children: [
                      // ── Cover image ────────────────────────────────────
                      Container(
                        width: 280,
                        height: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.35),
                              blurRadius: 40,
                              offset: const Offset(0, 16),
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
                      const SizedBox(height: 20),

                      // ── Playlist info ──────────────────────────────────
                      Text(
                        'Activaciones Theta',
                        style: GoogleFonts.urbanist(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.music,
                            color: AppColors.textMuted,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '6 pistas',
                            style: GoogleFonts.urbanist(
                              fontSize: 13,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            LucideIcons.clock,
                            color: AppColors.textMuted,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '1h 26min',
                            style: GoogleFonts.urbanist(
                              fontSize: 13,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Icon(
                            LucideIcons.user,
                            color: AppColors.textMuted,
                            size: 14,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Mantras App',
                            style: GoogleFonts.urbanist(
                              fontSize: 13,
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // ── Action buttons ─────────────────────────────────
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => context.push('/player-enhanced'),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  gradient: AppGradients.primaryButton,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary.withValues(
                                        alpha: 0.4,
                                      ),
                                      blurRadius: 16,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      LucideIcons.play,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Reproducir todo',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 48,
                            height: 48,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.surfaceBorderLight,
                              ),
                            ),
                            child: const Icon(
                              LucideIcons.shuffle,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // ── Track list ─────────────────────────────────────
                      ...List.generate(_tracks.length, (i) {
                        final t = _tracks[i];
                        return GestureDetector(
                          onTap: () => context.push('/player-enhanced'),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 14,
                                vertical: 12,
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
                                    width: 24,
                                    child: Text(
                                      '${t.number}',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 13,
                                        color: AppColors.textMuted,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    width: 38,
                                    height: 38,
                                    decoration: BoxDecoration(
                                      color: t.color.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(
                                      LucideIcons.music,
                                      color: t.color,
                                      size: 16,
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          t.title,
                                          style: GoogleFonts.urbanist(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          t.meta,
                                          style: GoogleFonts.urbanist(
                                            fontSize: 11,
                                            color: AppColors.textTertiary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Icon(
                                    LucideIcons.moreHorizontal,
                                    color: AppColors.textMuted,
                                    size: 16,
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
