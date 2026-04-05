import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/audio_service.dart';
import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/screen_bg.dart';

// Free royalty-free ambient meditation audio from Pixabay.
const _kDemoAudioUrl =
    'https://cdn.pixabay.com/audio/2022/05/27/audio_1808fbf07a.mp3';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final _audio = MantrasAudioService.instance;

  @override
  void initState() {
    super.initState();
    _startPlayback();
  }

  Future<void> _startPlayback() async {
    try {
      await _audio.playUrl(_kDemoAudioUrl);
    } catch (_) {
      // Silently ignore network or codec errors — the UI degrades gracefully
      // because all controls are driven by streams that emit nothing when idle.
    }
  }

  @override
  void dispose() {
    _audio.stop();
    super.dispose();
  }

  // Format a Duration to mm:ss string.
  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

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
                  title: 'Reproductor',
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
                      LucideIcons.moreVertical,
                      color: Colors.white,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(32)),

                // ── Album art + glow ────────────────────────────────────
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: Responsive.w(310),
                        height: Responsive.w(310),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.45),
                              blurRadius: 48,
                              spreadRadius: 8,
                              offset: const Offset(0, 20),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset(
                            'assets/images/player_art.jpg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(8)),
                      // Purple glow ellipse below art
                      Container(
                        width: Responsive.w(200),
                        height: Responsive.h(20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x666C5CE7),
                              blurRadius: 30,
                              spreadRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(28)),

                // ── Track info row ──────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Activación Theta · Abundancia',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(18),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: Responsive.h(4)),
                          Text(
                            '528Hz · Estado Theta · Bio-hacking',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              color: AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Responsive.w(12)),
                    Icon(
                      LucideIcons.heart,
                      color: AppColors.primary,
                      size: Responsive.w(24),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Progress bar (driven by position + duration streams) ─
                StreamBuilder<Duration?>(
                  stream: _audio.durationStream,
                  builder: (context, durationSnap) {
                    final duration = durationSnap.data ?? Duration.zero;
                    return StreamBuilder<Duration>(
                      stream: _audio.positionStream,
                      builder: (context, posSnap) {
                        final position = posSnap.data ?? Duration.zero;
                        // Clamp ratio 0..1 to avoid overflow when no file loaded.
                        final ratio = (duration.inMilliseconds > 0)
                            ? (position.inMilliseconds /
                                    duration.inMilliseconds)
                                .clamp(0.0, 1.0)
                            : 0.0;

                        return LayoutBuilder(
                          builder: (context, constraints) {
                            final trackWidth = constraints.maxWidth;
                            final filled = trackWidth * ratio;
                            final dotLeft = (filled - 6).clamp(0.0, trackWidth - 12);

                            return Column(
                              children: [
                                // Seekable progress bar
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTapDown: (details) {
                                    if (duration > Duration.zero) {
                                      final tapRatio = (details.localPosition.dx /
                                              trackWidth)
                                          .clamp(0.0, 1.0);
                                      final seekTo = Duration(
                                        milliseconds: (duration.inMilliseconds *
                                                tapRatio)
                                            .round(),
                                      );
                                      _audio.seek(seekTo);
                                    }
                                  },
                                  onHorizontalDragUpdate: (details) {
                                    if (duration > Duration.zero) {
                                      final tapRatio = (details.localPosition.dx /
                                              trackWidth)
                                          .clamp(0.0, 1.0);
                                      final seekTo = Duration(
                                        milliseconds: (duration.inMilliseconds *
                                                tapRatio)
                                            .round(),
                                      );
                                      _audio.seek(seekTo);
                                    }
                                  },
                                  child: SizedBox(
                                    height: Responsive.h(20),
                                    child: Stack(
                                      alignment: Alignment.centerLeft,
                                      children: [
                                        // Background track
                                        Container(
                                          width: double.infinity,
                                          height: Responsive.h(4),
                                          decoration: BoxDecoration(
                                            color: AppColors.white
                                                .withValues(alpha: 0.15),
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                        // Filled portion
                                        Container(
                                          width: filled,
                                          height: Responsive.h(4),
                                          decoration: BoxDecoration(
                                            gradient: AppGradients.primaryButton,
                                            borderRadius:
                                                BorderRadius.circular(2),
                                          ),
                                        ),
                                        // Dot indicator
                                        Positioned(
                                          left: dotLeft,
                                          child: Container(
                                            width: Responsive.w(12),
                                            height: Responsive.w(12),
                                            decoration: const BoxDecoration(
                                              color: Colors.white,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: Responsive.h(8)),
                                // Time row
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _fmt(position),
                                      style: GoogleFonts.urbanist(
                                        fontSize: Responsive.sp(12),
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                    Text(
                                      _fmt(duration),
                                      style: GoogleFonts.urbanist(
                                        fontSize: Responsive.sp(12),
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                ),
                SizedBox(height: Responsive.h(28)),

                // ── Controls row (driven by playerStateStream) ───────────
                StreamBuilder<PlayerState>(
                  stream: _audio.playerStateStream,
                  builder: (context, snap) {
                    final playing = snap.data?.playing ?? false;
                    return Center(
                      child: SizedBox(
                        width: Responsive.w(280),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              LucideIcons.shuffle,
                              color: AppColors.white.withValues(alpha: 0.4),
                              size: Responsive.w(22),
                            ),
                            Icon(
                              LucideIcons.skipBack,
                              color: Colors.white,
                              size: Responsive.w(28),
                            ),
                            // Play/pause circle
                            GestureDetector(
                              onTap: () {
                                if (playing) {
                                  _audio.pause();
                                } else {
                                  _audio.resume();
                                }
                              },
                              child: Container(
                                width: Responsive.w(56),
                                height: Responsive.w(56),
                                decoration: BoxDecoration(
                                  gradient: AppGradients.primaryButton,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.primary
                                          .withValues(alpha: 0.5),
                                      blurRadius: 20,
                                      offset: const Offset(0, 6),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  playing
                                      ? LucideIcons.pause
                                      : LucideIcons.play,
                                  color: Colors.white,
                                  size: Responsive.w(24),
                                ),
                              ),
                            ),
                            Icon(
                              LucideIcons.skipForward,
                              color: Colors.white,
                              size: Responsive.w(28),
                            ),
                            Icon(
                              LucideIcons.repeat,
                              color: AppColors.white.withValues(alpha: 0.4),
                              size: Responsive.w(22),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: Responsive.h(32)),

                // ── Frequency chip ──────────────────────────────────────
                Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(16),
                      vertical: Responsive.h(8),
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: Responsive.w(6),
                          height: Responsive.w(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryLight,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: Responsive.w(8)),
                        Text(
                          'Onda Theta · 528 Hz activa',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(13),
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryLight,
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
