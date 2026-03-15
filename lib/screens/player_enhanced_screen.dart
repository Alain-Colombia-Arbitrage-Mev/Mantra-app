import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../services/audio_service.dart';
import '../theme.dart';

// Same demo track used by PlayerScreen.
const _kDemoAudioUrl =
    'https://cdn.pixabay.com/audio/2022/05/27/audio_1808fbf07a.mp3';

class PlayerEnhancedScreen extends StatefulWidget {
  const PlayerEnhancedScreen({super.key});

  @override
  State<PlayerEnhancedScreen> createState() => _PlayerEnhancedScreenState();
}

class _PlayerEnhancedScreenState extends State<PlayerEnhancedScreen> {
  final _audio = MantrasAudioService.instance;
  bool _isShuffle = false;
  bool _isRepeat = false;

  @override
  void initState() {
    super.initState();
    _startPlayback();
  }

  Future<void> _startPlayback() async {
    try {
      await _audio.playUrl(_kDemoAudioUrl);
    } catch (_) {
      // Graceful degradation — streams emit nothing, UI stays interactive.
    }
  }

  @override
  void dispose() {
    _audio.stop();
    super.dispose();
  }

  String _fmt(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  static const List<_TrackItem> _tracks = [
    _TrackItem('Lantern Festival', 'Grinta', Color(0xFFDDA0DD)),
    _TrackItem('Magical City', 'Regina', Color(0xFF6C5CE7)),
    _TrackItem('Deep Sleep', 'Jenny', Color(0xFF55EFC4)),
    _TrackItem('Tropical Vibes', 'Esper', Color(0xFFF9A826)),
    _TrackItem('Ondas Binaurales', 'Theta · 432Hz', Color(0xFFA29BFE)),
    _TrackItem('Reprograma tu ADN', 'Solfeggio · 528Hz', Color(0xFFFFD700)),
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
            colors: [Color(0xFF0C0A20), Color(0xFF15102E), Color(0xFF1A1040)],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: Stack(
          children: [
            // Glow effect
            Positioned(
              top: 100,
              left: MediaQuery.of(context).size.width / 2 - 120,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.18),
                      blurRadius: 120,
                      spreadRadius: 60,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // ── Header ──────────────────────────────────────────────
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
                              LucideIcons.chevronDown,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                'RELAXING ZEN MUSIC',
                                style: GoogleFonts.urbanist(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                  color: AppColors.textTertiary,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Icon(
                                LucideIcons.chevronDown,
                                color: AppColors.textMuted,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                        Container(
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
                            LucideIcons.bookmark,
                            color: Colors.white,
                            size: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                      child: Column(
                        children: [
                          // ── Album art ───────────────────────────────────
                          Container(
                            width: 280,
                            height: 280,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.35,
                                  ),
                                  blurRadius: 40,
                                  offset: const Offset(0, 16),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/images/player_art.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 28),

                          // ── Track info ──────────────────────────────────
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Activación Theta · Abundancia',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '528Hz · Estado Theta · Bio-hacking',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 13,
                                        color: AppColors.textTertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                  color: AppColors.white.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  LucideIcons.heart,
                                  color: Colors.white,
                                  size: 17,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // ── Progress bar (stream-driven) ─────────────────
                          StreamBuilder<Duration?>(
                            stream: _audio.durationStream,
                            builder: (context, durationSnap) {
                              final duration =
                                  durationSnap.data ?? Duration.zero;
                              return StreamBuilder<Duration>(
                                stream: _audio.positionStream,
                                builder: (context, posSnap) {
                                  final position =
                                      posSnap.data ?? Duration.zero;
                                  final ratio =
                                      (duration.inMilliseconds > 0)
                                          ? (position.inMilliseconds /
                                                  duration.inMilliseconds)
                                              .clamp(0.0, 1.0)
                                          : 0.0;
                                  return Column(
                                    children: [
                                      SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                          trackHeight: 3,
                                          thumbShape:
                                              const RoundSliderThumbShape(
                                            enabledThumbRadius: 6,
                                          ),
                                          activeTrackColor: AppColors.primary,
                                          inactiveTrackColor: AppColors.white
                                              .withValues(alpha: 0.15),
                                          thumbColor: Colors.white,
                                          overlayColor:
                                              AppColors.primary.withValues(
                                            alpha: 0.2,
                                          ),
                                        ),
                                        child: Slider(
                                          value: ratio,
                                          onChanged: (v) {
                                            if (duration > Duration.zero) {
                                              _audio.seek(
                                                Duration(
                                                  milliseconds: (duration
                                                              .inMilliseconds *
                                                          v)
                                                      .round(),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 4,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _fmt(position),
                                              style: GoogleFonts.urbanist(
                                                fontSize: 12,
                                                color: AppColors.textTertiary,
                                              ),
                                            ),
                                            Text(
                                              _fmt(duration),
                                              style: GoogleFonts.urbanist(
                                                fontSize: 12,
                                                color: AppColors.textTertiary,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          const SizedBox(height: 16),

                          // ── Controls (stream-driven play/pause) ───────────
                          StreamBuilder<PlayerState>(
                            stream: _audio.playerStateStream,
                            builder: (context, snap) {
                              final playing = snap.data?.playing ?? false;
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  // Shuffle
                                  GestureDetector(
                                    onTap: () => setState(
                                        () => _isShuffle = !_isShuffle),
                                    child: Icon(
                                      LucideIcons.shuffle,
                                      color: _isShuffle
                                          ? AppColors.primary
                                          : AppColors.textMuted,
                                      size: 22,
                                    ),
                                  ),
                                  // Skip back
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                      LucideIcons.skipBack,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  ),
                                  // Play/Pause
                                  GestureDetector(
                                    onTap: () {
                                      if (playing) {
                                        _audio.pause();
                                      } else {
                                        _audio.resume();
                                      }
                                    },
                                    child: Container(
                                      width: 66,
                                      height: 66,
                                      decoration: BoxDecoration(
                                        gradient: AppGradients.primaryButton,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppColors.primary.withValues(
                                              alpha: 0.5,
                                            ),
                                            blurRadius: 24,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        playing
                                            ? LucideIcons.pause
                                            : LucideIcons.play,
                                        color: Colors.white,
                                        size: 28,
                                      ),
                                    ),
                                  ),
                                  // Skip forward
                                  GestureDetector(
                                    onTap: () {},
                                    child: const Icon(
                                      LucideIcons.skipForward,
                                      color: Colors.white,
                                      size: 26,
                                    ),
                                  ),
                                  // Repeat
                                  GestureDetector(
                                    onTap: () =>
                                        setState(() => _isRepeat = !_isRepeat),
                                    child: Icon(
                                      LucideIcons.repeat,
                                      color: _isRepeat
                                          ? AppColors.primary
                                          : AppColors.textMuted,
                                      size: 22,
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                          const SizedBox(height: 28),

                          // ── Colección label ─────────────────────────────
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Colección',
                                style: GoogleFonts.urbanist(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => context.push('/more-collections'),
                                child: Text(
                                  'Ver todo',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // ── Track list ──────────────────────────────────
                          ...List.generate(_tracks.length, (i) {
                            final t = _tracks[i];
                            return Padding(
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
                                    // Track number
                                    SizedBox(
                                      width: 20,
                                      child: Text(
                                        '${i + 1}',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 12,
                                          color: AppColors.textMuted,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Thumb circle
                                    Container(
                                      width: 36,
                                      height: 36,
                                      decoration: BoxDecoration(
                                        color: t.color.withValues(alpha: 0.2),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: t.color.withValues(alpha: 0.3),
                                        ),
                                      ),
                                      child: Icon(
                                        LucideIcons.music,
                                        color: t.color,
                                        size: 16,
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    // Title + artist
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
                                          const SizedBox(height: 2),
                                          Text(
                                            t.artist,
                                            style: GoogleFonts.urbanist(
                                              fontSize: 11,
                                              color: AppColors.textTertiary,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Icon(
                                      LucideIcons.barChart2,
                                      color: AppColors.textMuted,
                                      size: 16,
                                    ),
                                  ],
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
          ],
        ),
      ),
    );
  }
}

class _TrackItem {
  final String title;
  final String artist;
  final Color color;

  const _TrackItem(this.title, this.artist, this.color);
}
