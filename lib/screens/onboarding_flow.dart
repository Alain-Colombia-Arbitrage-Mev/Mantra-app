import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';

import '../widgets/pencil_surface.dart';

/// Production frames exported from mandala2.pen. The controls are native
/// and the screen artwork remains the Pencil-approved composition.
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  static const _nodes = [
    'TTLH4',
    'x36zX',
    '1DHid',
    'CqnJW',
    '3fTTR',
    'tkH7u',
    'l5Vlq',
    'yBsgB',
    'K5ULP',
    'wecjl',
    'IEgGc',
    'w4GjPh',
    'D4A7Y',
  ];
  final _controller = PageController();
  int _page = 0;
  final Set<String> _needs = {'Dormir mejor'};
  final Set<String> _times = {'5 minutos'};
  final Set<String> _guidance = {'Guíame paso a paso'};

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page == _nodes.length - 1) {
      context.go('/home');
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  void _startPractice() {
    HapticFeedback.lightImpact();
    context.go('/home');
  }

  void _toggle(Set<String> values, String value) {
    setState(() {
      if (values.contains(value)) {
        values.remove(value);
      } else {
        values.add(value);
      }
    });
  }

  List<Widget> _choiceOverlays(int index, Size size) {
    final horizontalInset = size.width * (24 / PencilSurface.canvasSize.width);
    switch (index) {
      case 5:
        return [
          Positioned(
            left: horizontalInset,
            right: horizontalInset,
            top: size.height * (373 / 956),
            height: size.height * (222 / 956),
            child: _MultiChoiceList(
              values: const [
                ('Sentir calma', Icons.spa_outlined),
                ('Dormir mejor', Icons.bedtime_outlined),
                ('Enfoque y confianza', Icons.center_focus_strong_outlined),
                ('Soltar una etapa', Icons.auto_awesome_outlined),
              ],
              selected: _needs,
              onToggle: (value) => _toggle(_needs, value),
            ),
          ),
        ];
      case 6:
        return [
          Positioned(
            left: horizontalInset,
            right: horizontalInset,
            top: size.height * (411 / 956),
            height: size.height * (210 / 956),
            child: _MultiChoiceGrid(
              values: const [
                ('5 minutos', Icons.bubble_chart_outlined),
                ('5 minutos+', Icons.favorite_border),
                ('10 minutos', Icons.eco_outlined),
                ('15 minutos', Icons.card_giftcard_outlined),
              ],
              selected: _times,
              onToggle: (value) => _toggle(_times, value),
            ),
          ),
        ];
      case 7:
        return [
          Positioned(
            left: horizontalInset,
            right: horizontalInset,
            top: size.height * (368 / 956),
            height: size.height * (192 / 956),
            child: _MultiChoiceList(
              values: const [
                ('Guíame paso a paso', Icons.psychology_alt_outlined),
                ('Déjame avanzar a mi ritmo', Icons.directions_walk_outlined),
                ('Quiero profundizar', Icons.auto_awesome_outlined),
              ],
              selected: _guidance,
              onToggle: (value) => _toggle(_guidance, value),
            ),
          ),
        ];
      default:
        return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return PageView.builder(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _nodes.length,
      onPageChanged: (value) => setState(() => _page = value),
      itemBuilder: (context, index) {
        if (index == 0) {
          return _VideoStoryPage(active: _page == index, onContinue: _next);
        }

        return PencilSurface(
          nodeId: _nodes[index],
          showNavigation: false,
          respectSafeArea: false,
          overlays: _choiceOverlays(index, size),
          onTap: (point) {
            if (index == 9 && point.dy > .32 && point.dy < .69) {
              context.push('/register');
              return;
            }
            // The refreshed paywall exposes both the trial CTA and the
            // continue-with-free-version action.
            if (index == 10 && point.dy > .70 && point.dy < .90) {
              _next();
              return;
            }
            // POST · Prueba activada → práctica lista → Home.
            if (index == 11 && point.dy > .80 && point.dy < .90) {
              _next();
              return;
            }
            if (index == 12 && point.dy > .87 && point.dy < .96) {
              _startPractice();
              return;
            }
            if (index == 4 && point.dy > .78 && point.dy < .90) {
              _next();
              return;
            }
            if (point.dy >= .79) _next();
          },
        );
      },
    );
  }
}

class _VideoStoryPage extends StatefulWidget {
  final bool active;
  final VoidCallback onContinue;

  const _VideoStoryPage({required this.active, required this.onContinue});

  @override
  State<_VideoStoryPage> createState() => _VideoStoryPageState();
}

class _VideoStoryPageState extends State<_VideoStoryPage> {
  late final VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(
      'assets/videos/onboarding_story_01.mp4',
    );
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      await _videoController.initialize();
      if (!mounted) return;
      await _videoController.setLooping(true);
      await _videoController.setVolume(0);
      if (widget.active) await _videoController.play();
      if (mounted) setState(() {});
    } on PlatformException {
      // The poster remains visible if the platform cannot decode the video.
    }
  }

  @override
  void didUpdateWidget(covariant _VideoStoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active == widget.active ||
        !_videoController.value.isInitialized) {
      return;
    }
    if (widget.active) {
      _videoController.play();
    } else {
      _videoController.pause();
    }
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFF09080E),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF09080E),
        body: LayoutBuilder(
          builder: (context, constraints) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTapUp: (details) {
              if (details.localPosition.dy / constraints.maxHeight >= .79) {
                widget.onContinue();
              }
            },
            child: ClipRect(
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: PencilSurface.canvasSize.width,
                  height: PencilSurface.canvasSize.height,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.asset(
                        'assets/images/onboarding_story_01_poster.png',
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                      if (_videoController.value.isInitialized)
                        _CoverVideo(controller: _videoController),
                      const DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0, .3, .62, 1],
                            colors: [
                              Color(0x12080711),
                              Color(0x36080711),
                              Color(0xB8080711),
                              Color(0xF7080711),
                            ],
                          ),
                        ),
                      ),
                      const Positioned(
                        left: 27,
                        top: 408,
                        width: 386,
                        child: _StoryCopy(),
                      ),
                      const Positioned(
                        left: 18,
                        top: 873,
                        child: _StoryProgress(),
                      ),
                      const Positioned(
                        left: 364,
                        top: 847,
                        child: _StoryContinueButton(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _CoverVideo extends StatelessWidget {
  final VideoPlayerController controller;

  const _CoverVideo({required this.controller});

  @override
  Widget build(BuildContext context) {
    final videoSize = controller.value.size;
    return ClipRect(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: videoSize.width,
          height: videoSize.height,
          child: VideoPlayer(controller),
        ),
      ),
    );
  }
}

class _StoryCopy extends StatelessWidget {
  const _StoryCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '01 · MIRAS AL UNIVERSO BUSCANDO UNA SEÑAL',
          style: GoogleFonts.inter(
            color: const Color(0xFFD6B1D8),
            fontSize: 11.5,
            fontWeight: FontWeight.w600,
            height: 1.25,
            letterSpacing: 1.35,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          '¿Y si hoy la señal\nte encuentra a ti?',
          style: GoogleFonts.notoSans(
            color: Colors.white,
            fontSize: 34,
            fontWeight: FontWeight.w600,
            height: 1.08,
            letterSpacing: -.5,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Tu cerebro prioriza aquello a lo que prestas atención. Una pausa '
          'puede ayudarte a reconocer lo que ya estaba frente a ti.',
          style: GoogleFonts.inter(
            color: const Color(0xFFDED8E2),
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _StoryProgress extends StatelessWidget {
  const _StoryProgress();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 30,
          height: 5,
          decoration: BoxDecoration(
            color: const Color(0xFFF5F2F7),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 5),
        for (var index = 0; index < 2; index++) ...[
          Container(
            width: 8,
            height: 5,
            decoration: BoxDecoration(
              color: const Color(0x55FFFFFF),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          if (index == 0) const SizedBox(width: 5),
        ],
      ],
    );
  }
}

class _StoryContinueButton extends StatelessWidget {
  const _StoryContinueButton();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Continuar',
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: const Color(0xF2F7F3F9),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white),
          boxShadow: const [
            BoxShadow(
              color: Color(0x66000000),
              offset: Offset(0, 10),
              blurRadius: 24,
            ),
            BoxShadow(
              color: Color(0x44B57BB5),
              blurRadius: 16,
              spreadRadius: 1,
            ),
          ],
        ),
        child: const Icon(
          Icons.arrow_forward_rounded,
          color: Color(0xFF221A27),
          size: 24,
        ),
      ),
    );
  }
}

typedef _Choice = (String, IconData);

class _MultiChoiceList extends StatelessWidget {
  final List<_Choice> values;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const _MultiChoiceList({
    required this.values,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: values
        .map(
          (value) => Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: _ChoiceCard(
                label: value.$1,
                active: selected.contains(value.$1),
                onTap: () => onToggle(value.$1),
              ),
            ),
          ),
        )
        .toList(),
  );
}

class _MultiChoiceGrid extends StatelessWidget {
  final List<_Choice> values;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const _MultiChoiceGrid({
    required this.values,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    childAspectRatio: 1.85,
    physics: const NeverScrollableScrollPhysics(),
    children: values
        .map(
          (value) => _ChoiceCard(
            label: value.$1,
            active: selected.contains(value.$1),
            compact: true,
            onTap: () => onToggle(value.$1),
          ),
        )
        .toList(),
  );
}

class _ChoiceCard extends StatelessWidget {
  final String label;
  final bool active;
  final bool compact;
  final VoidCallback onTap;

  const _ChoiceCard({
    required this.label,
    required this.active,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: active,
    label: label,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerRight,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 160),
          opacity: active ? 1 : 0,
          child: Container(
            width: compact ? 18 : 20,
            height: compact ? 18 : 20,
            margin: EdgeInsets.only(right: compact ? 8 : 10),
            decoration: const BoxDecoration(
              color: Color(0xFF9897F5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: compact ? 12 : 14,
              color: const Color(0xFF09080D),
            ),
          ),
        ),
      ),
    ),
  );
}
