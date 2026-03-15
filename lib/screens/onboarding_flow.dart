import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../theme.dart';

// ─── Entry point ──────────────────────────────────────────────────────────────

class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _next() {
    if (_currentPage < 8) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  void _prev() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundStart,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (i) => setState(() => _currentPage = i),
        children: [
          _Page1Welcome(onNext: _next),
          _Page2Objectives(onNext: _next),
          _Page3FuturoYo(onNext: _next),
          _Page4Experience(onNext: _next),
          _Page5WhatsApp(onNext: _next),
          _Page6Intentions(onNext: _next),
          _Page7Account(onNext: _next),
          _Page8Paywall(onNext: _next, onBack: _prev),
          const _Page9FinalWelcome(),
        ],
      ),
    );
  }
}

// ─── Shared helper widgets ─────────────────────────────────────────────────────

/// A row of N progress bar segments with per-segment color configuration.
class _ProgressBar extends StatelessWidget {
  final List<Color> segmentColors;

  const _ProgressBar({required this.segmentColors});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(segmentColors.length, (i) {
        return Expanded(
          child: Container(
            margin: EdgeInsets.only(right: i < segmentColors.length - 1 ? 6 : 0),
            height: 4,
            decoration: BoxDecoration(
              color: segmentColors[i],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}

/// Animated page-indicator dots with per-dot color configuration.
class _ProgressDots extends StatelessWidget {
  final int activeDot; // 0-based index
  final int total;
  final Color activeColor;

  /// Optional override colors indexed by position (null → use default inactive color)
  final Map<int, Color>? dotColors;

  const _ProgressDots({
    required this.activeDot,
    required this.total,
    required this.activeColor,
    this.dotColors,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final isActive = i == activeDot;
        final color = dotColors?[i] ?? AppColors.white.withValues(alpha: 0.18);
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: isActive ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: isActive ? activeColor : color,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

/// Hero image with a gradient overlay fading to the background color.
class _HeroImage extends StatelessWidget {
  final String assetPath;
  final double height;

  const _HeroImage({required this.assetPath, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(assetPath, fit: BoxFit.cover),
          // Gradient overlay: transparent at top, solid background at 85%
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 0.85],
                colors: [Color(0x000F0A2A), Color(0xFF0F0A2A)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Standard "Continuar" CTA with purple gradient + arrow.
class _PurpleCta extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final double height;
  final double cornerRadius;

  const _PurpleCta({
    required this.label,
    required this.onTap,
    this.height = 56,
    this.cornerRadius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return _GradientButton(
      label: label,
      gradient: AppGradients.primaryButton,
      textColor: AppColors.white,
      shadowColor: AppColors.primary.withValues(alpha: 0.45),
      icon: LucideIcons.arrowRight,
      height: height,
      cornerRadius: cornerRadius,
      onTap: onTap,
    );
  }
}

/// Reusable gradient button with haptic + press animation.
class _GradientButton extends StatefulWidget {
  final String label;
  final LinearGradient gradient;
  final Color textColor;
  final Color? shadowColor;
  final IconData? icon;
  final double height;
  final double cornerRadius;
  final VoidCallback onTap;

  const _GradientButton({
    required this.label,
    required this.gradient,
    required this.textColor,
    required this.onTap,
    this.shadowColor,
    this.icon,
    this.height = 56,
    this.cornerRadius = 16,
  });

  @override
  State<_GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<_GradientButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final shadow = widget.shadowColor ??
        widget.gradient.colors.first.withValues(alpha: 0.40);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        HapticFeedback.lightImpact();
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(widget.cornerRadius),
            boxShadow: [
              BoxShadow(
                color: shadow,
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.urbanist(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: widget.textColor,
                ),
              ),
              if (widget.icon != null) ...[
                const SizedBox(width: 10),
                Icon(widget.icon, color: widget.textColor, size: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// "Omitir por ahora" skip link.
class _SkipLink extends StatelessWidget {
  final VoidCallback onTap;
  final String label;

  const _SkipLink({required this.onTap, this.label = 'Omitir por ahora'});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.urbanist(
          fontSize: 12,
          color: AppColors.white.withValues(alpha: 0.40),
        ),
      ),
    );
  }
}

// ─── Page 1 — Welcome (07 · Bienvenida) ──────────────────────────────────────

class _Page1Welcome extends StatelessWidget {
  final VoidCallback onNext;
  const _Page1Welcome({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ── Hero image (top 42%) ──
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: h * 0.42,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned.fill(
                  child: Image.asset('assets/images/onboarding_hero.png', fit: BoxFit.cover),
                ),
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.0, 0.7, 1.0],
                        colors: [Color(0x000F0A2A), Color(0x800F0A2A), Color(0xFF0F0A2A)],
                      ),
                    ),
                  ),
                ),
                // Purple glow behind logo
                Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [AppColors.primary.withValues(alpha: 0.30), Colors.transparent],
                    ),
                  ),
                ),
                // Rings
                _WelcomeRing(diameter: 260, color: const Color(0x15A29BFE), strokeWidth: 1.5),
                _WelcomeRing(diameter: 200, color: const Color(0x20A29BFE), strokeWidth: 1.0),
                _WelcomeRing(diameter: 150, color: const Color(0x30A29BFE), strokeWidth: 1.0),
                // Logo
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.50),
                        blurRadius: 40,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset('assets/images/logomantra.png', fit: BoxFit.cover),
                  ),
                ),
              ],
            ),
          ),

          // ── Content (bottom area) ──
          Positioned(
            left: 24,
            right: 24,
            bottom: 0,
            top: h * 0.36,
            child: Column(
              children: [
                // MANTRAS tagline
                Text(
                  'MANTRAS',
                  style: GoogleFonts.urbanist(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                    letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 10),

                // Title
                Text(
                  'Personas como tú\nya están aquí',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                    height: 1.15,
                  ),
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  'No es una app más. Es un movimiento.\nÚnete a quienes eligieron transformarse.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    color: const Color(0xA0FFFFFF),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 12),

                // Rating badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '4.9 stars  ',
                      style: GoogleFonts.urbanist(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.white,
                      ),
                    ),
                    ...List.generate(5, (_) => const Text('★', style: TextStyle(color: AppColors.gold, fontSize: 14))),
                    Text(
                      '  1,000+ reviews',
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        color: AppColors.white.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),

                const Spacer(),

                // CTA
                _GradientButton(
                  label: 'Comenzar mi viaje →',
                  gradient: AppGradients.primaryButton,
                  textColor: AppColors.white,
                  shadowColor: AppColors.primary.withValues(alpha: 0.50),
                  height: 56,
                  cornerRadius: 18,
                  onTap: onNext,
                ),
                const SizedBox(height: 14),

                // Login link
                GestureDetector(
                  onTap: () => context.go('/home'),
                  child: Text.rich(
                    TextSpan(
                      text: '¿Ya tienes cuenta? ',
                      style: GoogleFonts.urbanist(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                      children: [
                        TextSpan(
                          text: 'Iniciar sesión',
                          style: GoogleFonts.urbanist(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomeRing extends StatelessWidget {
  final double diameter;
  final Color color;
  final double strokeWidth;

  const _WelcomeRing({
    required this.diameter,
    required this.color,
    required this.strokeWidth,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: diameter,
      height: diameter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: color, width: strokeWidth),
      ),
    );
  }
}

// ─── Page 2 — Objectives (08 · Tu Historia) ───────────────────────────────────

const List<(String, String)> _objectiveItems = [
  ('😌', 'Quiero paz interior'),
  ('😴', 'Quiero descansar profundamente'),
  ('🔄', 'Quiero reinventarme cada día'),
  ('💔', 'Necesito sanar y soltar'),
  ('💰', 'Busco abundancia y prosperidad'),
  ('🎯', 'Quiero claridad y enfoque'),
  ('✨', 'Busco despertar espiritual'),
];

// Which pills start pre-selected and their accent color + badge text
const Map<int, (Color, Color, String)> _objectiveDefaults = {
  1: (Color(0x1555EFC4), AppColors.mint, '#1'),
  4: (Color(0x15F9A826), AppColors.amber, 'Nuevo'),
};

class _Page2Objectives extends StatefulWidget {
  final VoidCallback onNext;
  const _Page2Objectives({required this.onNext});

  @override
  State<_Page2Objectives> createState() => _Page2ObjectivesState();
}

class _Page2ObjectivesState extends State<_Page2Objectives> {
  final Set<int> _selected = {1, 4};

  void _toggle(int i) => setState(() {
        if (_selected.contains(i)) {
          _selected.remove(i);
        } else {
          _selected.add(i);
        }
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Hero
            _HeroImage(assetPath: 'assets/images/quiz_hero.png', height: 240),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(14, 20, 14, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress bar: 2 colored, 5 gray
                    _ProgressBar(
                      segmentColors: [
                        AppColors.primary,
                        AppColors.primary,
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Step label — gold
                    Text(
                      'TU HISTORIA',
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.amber,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      '¿Qué quieres\ntransformar en tu vida?',
                      style: GoogleFonts.urbanist(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      'Personas como tú eligen estas intenciones',
                      style: GoogleFonts.urbanist(
                        fontSize: 14,
                        color: AppColors.white.withValues(alpha: 0.50),
                      ),
                    ),
                    const SizedBox(height: 14),

                    // Pills
                    ...List.generate(_objectiveItems.length, (i) {
                      final isSelected = _selected.contains(i);
                      final accent = _objectiveDefaults[i];
                      final fillColor = isSelected
                          ? (accent?.$1 ?? AppColors.primary.withValues(alpha: 0.12))
                          : const Color(0x0AFFFFFF);
                      final borderColor = isSelected
                          ? (accent?.$2 ?? AppColors.primary)
                          : const Color(0x20FFFFFF);
                      final borderWidth = isSelected ? 2.0 : 1.0;
                      final badgeText = isSelected ? accent?.$3 : null;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 7),
                        child: GestureDetector(
                          onTap: () => _toggle(i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            height: 44,
                            padding: const EdgeInsets.symmetric(horizontal: 18),
                            decoration: BoxDecoration(
                              color: fillColor,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: borderColor, width: borderWidth),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  _objectiveItems[i].$1,
                                  style: const TextStyle(fontSize: 20),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    _objectiveItems[i].$2,
                                    style: GoogleFonts.urbanist(
                                      fontSize: 14,
                                      fontWeight: isSelected
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.white.withValues(alpha: 0.75),
                                    ),
                                  ),
                                ),
                                if (badgeText != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: (accent?.$2 ?? AppColors.primary)
                                          .withValues(alpha: 0.20),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      badgeText,
                                      style: GoogleFonts.urbanist(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: accent?.$2 ?? AppColors.primary,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 12),

                    // CTA
                    _PurpleCta(
                      label: 'Continuar →',
                      onTap: widget.onNext,
                      height: 56,
                      cornerRadius: 16,
                    ),
                    const SizedBox(height: 12),

                    Center(
                      child: _SkipLink(onTap: widget.onNext),
                    ),
                    const SizedBox(height: 16),

                    Center(
                      child: _ProgressDots(
                        activeDot: 1,
                        total: 5,
                        activeColor: AppColors.primary,
                        dotColors: {0: AppColors.primary},
                      ),
                    ),
                    const SizedBox(height: 8),
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

// ─── Page 3 — Futuro Yo (09 · Tu Visión) ──────────────────────────────────────

class _Page3FuturoYo extends StatelessWidget {
  final VoidCallback onNext;
  const _Page3FuturoYo({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Hero image
            _HeroImage(
              assetPath: 'assets/images/quiz_hero.png',
              height: 240,
            ),

            // Scrollable content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress bar: 3 colored, 4 gray
                    _ProgressBar(
                      segmentColors: [
                        AppColors.primary,
                        AppColors.primary,
                        AppColors.amber,
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Step label — gold
                    Text(
                      'TU VISIÓN',
                      style: GoogleFonts.urbanist(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFFF9A826),
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      'Describe tu\nfuturo yo',
                      style: GoogleFonts.urbanist(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      'Cierra los ojos un momento. ¿Cómo te ves\ncuando logres tu transformación?',
                      style: GoogleFonts.urbanist(
                        fontSize: 14,
                        color: AppColors.white.withValues(alpha: 0.55),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Text area
                    Container(
                      height: 120,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0x0AFFFFFF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0x20FFFFFF),
                          width: 1,
                        ),
                      ),
                      child: TextField(
                        maxLines: 4,
                        style: GoogleFonts.urbanist(
                          fontSize: 14,
                          color: AppColors.white,
                          height: 1.5,
                        ),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText:
                              'Me veo en paz, con abundancia, rodeado/a de amor y con un propósito claro cada mañana...',
                          hintStyle: GoogleFonts.urbanist(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: AppColors.white.withValues(alpha: 0.30),
                            height: 1.5,
                          ),
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Hint
                    Center(
                      child: Text(
                        'Esto queda entre tú y el universo — nadie más lo verá',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 11,
                          color: AppColors.white.withValues(alpha: 0.40),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // CTA
                    _PurpleCta(
                      label: 'Continuar',
                      onTap: onNext,
                      height: 56,
                      cornerRadius: 16,
                    ),
                    const SizedBox(height: 12),

                    Center(
                      child: _SkipLink(onTap: onNext),
                    ),
                    const SizedBox(height: 8),
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

// ─── Page 4 — Experience (10 · Tu Camino) ─────────────────────────────────────

class _Page4Experience extends StatefulWidget {
  final VoidCallback onNext;
  const _Page4Experience({required this.onNext});

  @override
  State<_Page4Experience> createState() => _Page4ExperienceState();
}

class _Page4ExperienceState extends State<_Page4Experience> {
  int _selectedLevel = 0;
  int _selectedTime = 0;

  static const _levels = [
    (
      emoji: '🌱',
      title: 'Estoy comenzando',
      subtitle: 'Y eso es perfecto — todos empezamos aquí',
      badge: '79%',
      badgeColor: AppColors.mint,
    ),
    (
      emoji: '🧘',
      title: 'Ya tengo algo de práctica',
      subtitle: 'Medito de vez en cuando',
      badge: null as String?,
      badgeColor: AppColors.mint,
    ),
    (
      emoji: '🔮',
      title: 'Llevo tiempo en esto',
      subtitle: 'Tengo una práctica constante',
      badge: null as String?,
      badgeColor: AppColors.primaryLight,
    ),
  ];

  static const _times = ['5', '10', '15', '20+'];

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.sizeOf(context).height;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Hero
            _HeroImage(
              assetPath: 'assets/images/experience_hero.png',
              height: h * 0.26,
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress bar
                    _ProgressBar(segmentColors: [
                      AppColors.primary,
                      AppColors.primary,
                      AppColors.mint,
                      AppColors.white.withValues(alpha: 0.15),
                      AppColors.white.withValues(alpha: 0.15),
                      AppColors.white.withValues(alpha: 0.15),
                      AppColors.white.withValues(alpha: 0.15),
                    ]),
                    const SizedBox(height: 8),

                    // Step label — gold
                    Text(
                      'TU CAMINO',
                      style: GoogleFonts.urbanist(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppColors.amber,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),

                    Text(
                      '¿Dónde estás\nen tu viaje?',
                      style: GoogleFonts.urbanist(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      'No hay respuesta incorrecta · Todos empezamos igual',
                      style: GoogleFonts.urbanist(
                        fontSize: 13,
                        color: AppColors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Level cards
                    ...List.generate(_levels.length, (i) {
                      final isSelected = _selectedLevel == i;
                      final item = _levels[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedLevel = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? const Color(0x1555EFC4)
                                  : const Color(0x0AFFFFFF),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.mint
                                    : const Color(0x20FFFFFF),
                                width: isSelected ? 2.0 : 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  item.emoji,
                                  style: const TextStyle(fontSize: 24),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 1),
                                      Text(
                                        item.subtitle,
                                        style: GoogleFonts.urbanist(
                                          fontSize: 11,
                                          color: AppColors.white
                                              .withValues(alpha: 0.50),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if (item.badge != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: item.badgeColor
                                          .withValues(alpha: 0.20),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      item.badge!,
                                      style: GoogleFonts.urbanist(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: item.badgeColor,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    const SizedBox(height: 12),

                    // Time question
                    Text(
                      '¿Cuánto tiempo puedes regalarte?',
                      style: GoogleFonts.urbanist(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Time chips
                    Row(
                      children: List.generate(_times.length, (i) {
                        final isSelected = _selectedTime == i;
                        return Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.only(right: i < 3 ? 8 : 0),
                            child: GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedTime = i),
                              child: AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 180),
                                height: 56,
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? const Color(0x1555EFC4)
                                      : const Color(0x0AFFFFFF),
                                  borderRadius:
                                      BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.mint
                                        : const Color(0x20FFFFFF),
                                    width: isSelected ? 2.0 : 1.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _times[i],
                                      style: GoogleFonts.urbanist(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: isSelected
                                            ? AppColors.mint
                                            : AppColors.white,
                                      ),
                                    ),
                                    Text(
                                      'min',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 9,
                                        color: AppColors.white
                                            .withValues(alpha: 0.45),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 14),

                    // Trophy callout
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(LucideIcons.trophy,
                                color: AppColors.gold, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              '¡Vas increíble! Un paso más y listo',
                              style: GoogleFonts.urbanist(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppColors.gold
                                    .withValues(alpha: 0.85),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // CTA
                    _PurpleCta(
                      label: 'Continuar →',
                      onTap: widget.onNext,
                      height: 54,
                      cornerRadius: 16,
                    ),
                    const SizedBox(height: 8),

                    Center(child: _SkipLink(onTap: widget.onNext)),
                    const SizedBox(height: 10),

                    Center(
                      child: _ProgressDots(
                        activeDot: 2,
                        total: 5,
                        activeColor: AppColors.mint,
                        dotColors: {
                          0: AppColors.primary,
                          1: AppColors.primary,
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
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

// ─── Page 4 — WhatsApp (10 · Tu Tribu) ────────────────────────────────────────

class _Page5WhatsApp extends StatefulWidget {
  final VoidCallback onNext;
  const _Page5WhatsApp({required this.onNext});

  @override
  State<_Page5WhatsApp> createState() => _Page5WhatsAppState();
}

class _Page5WhatsAppState extends State<_Page5WhatsApp> {
  bool _useWhatsapp = true;
  final TextEditingController _phoneController = TextEditingController();

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const benefits = [
      'Tu mantra diario llega cada mañana',
      'Rituales y frecuencias en el momento justo',
      'Contenido exclusivo de tu comunidad',
      'Privado y seguro — solo cosas buenas',
    ];

    const whatsappGreen = Color(0xFF25D366);
    const whatsappGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [whatsappGreen, Color(0xFF1DA851)],
    );

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Hero
            _HeroImage(
              assetPath: 'assets/images/whatsapp_hero.png',
              height: 260,
            ),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress bar
                    _ProgressBar(
                      segmentColors: [
                        AppColors.primary,
                        AppColors.primary,
                        AppColors.mint,
                        whatsappGreen,
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Step label — WhatsApp green
                    Text(
                      'TU TRIBU',
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: whatsappGreen,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'Conecta con tu\ncírculo sagrado',
                      style: GoogleFonts.urbanist(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      '52,000+ personas reciben mantras cada mañana',
                      style: GoogleFonts.urbanist(
                        fontSize: 14,
                        color: AppColors.white.withValues(alpha: 0.44),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Phone input row
                    Container(
                      height: 52,
                      decoration: BoxDecoration(
                        color: const Color(0x08FFFFFF),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0x20FFFFFF)),
                      ),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text(
                              '🇲🇽 +52',
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                          Container(
                            width: 1,
                            height: 28,
                            color: const Color(0x20FFFFFF),
                          ),
                          Expanded(
                            child: TextField(
                              controller: _phoneController,
                              keyboardType: TextInputType.phone,
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                color: AppColors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Tu número de celular',
                                hintStyle: GoogleFonts.urbanist(
                                  fontSize: 15,
                                  color: AppColors.white.withValues(alpha: 0.35),
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 14),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Method tabs
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _useWhatsapp = true),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              height: 40,
                              decoration: BoxDecoration(
                                color: _useWhatsapp
                                    ? const Color(0x2025D366)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _useWhatsapp
                                      ? whatsappGreen
                                      : const Color(0x20FFFFFF),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'WhatsApp',
                                style: GoogleFonts.urbanist(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: _useWhatsapp
                                      ? whatsappGreen
                                      : AppColors.white.withValues(alpha: 0.60),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => _useWhatsapp = false),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              height: 40,
                              decoration: BoxDecoration(
                                color: !_useWhatsapp
                                    ? const Color(0x2025D366)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: !_useWhatsapp
                                      ? whatsappGreen
                                      : const Color(0x20FFFFFF),
                                ),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                'SMS',
                                style: GoogleFonts.urbanist(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: !_useWhatsapp
                                      ? whatsappGreen
                                      : AppColors.white.withValues(alpha: 0.60),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Benefit items
                    ...benefits.map(
                      (b) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              LucideIcons.checkCircle2,
                              color: whatsappGreen,
                              size: 18,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                b,
                                style: GoogleFonts.urbanist(
                                  fontSize: 13,
                                  color: AppColors.white.withValues(alpha: 0.80),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // Green CTA
                    _GradientButton(
                      label: 'Unirme a la comunidad →',
                      gradient: whatsappGradient,
                      textColor: AppColors.white,
                      shadowColor: whatsappGreen.withValues(alpha: 0.40),
                      height: 56,
                      cornerRadius: 16,
                      onTap: widget.onNext,
                    ),
                    const SizedBox(height: 10),

                    Center(
                      child: Text(
                        'Tu información es sagrada para nosotros. Cancela cuando quieras.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 11,
                          color: AppColors.white.withValues(alpha: 0.30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),

                    Center(child: _SkipLink(onTap: widget.onNext)),
                    const SizedBox(height: 16),

                    Center(
                      child: _ProgressDots(
                        activeDot: 3,
                        total: 5,
                        activeColor: whatsappGreen,
                        dotColors: {
                          0: AppColors.primary,
                          1: AppColors.primary,
                          2: AppColors.mint,
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
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

// ─── Page 5 — Intentions (11 · Tu Intención) ──────────────────────────────────

class _Page6Intentions extends StatefulWidget {
  final VoidCallback onNext;
  const _Page6Intentions({required this.onNext});

  @override
  State<_Page6Intentions> createState() => _Page6IntentionsState();
}

class _Page6IntentionsState extends State<_Page6Intentions> {
  int _selected = 2; // "Salud" pre-selected

  static const _intentions = [
    (
      icon: LucideIcons.gem,
      color: Color(0xFFA29BFE),
      fillColor: Color(0x206C5CE7),
      borderColor: Color(0x446C5CE7),
      title: 'Abundancia',
      subtitle: 'Atraer prosperidad',
    ),
    (
      icon: LucideIcons.heart,
      color: Color(0xFFE84393),
      fillColor: Color(0x20E84393),
      borderColor: Color(0x44E84393),
      title: 'Amor',
      subtitle: 'Relaciones plenas',
    ),
    (
      icon: LucideIcons.leaf,
      color: Color(0xFF55EFC4),
      fillColor: Color(0x2055EFC4),
      borderColor: Color(0x4455EFC4),
      title: 'Salud',
      subtitle: 'Bienestar integral',
    ),
    (
      icon: LucideIcons.briefcase,
      color: Color(0xFFF9A826),
      fillColor: Color(0x20F9A826),
      borderColor: Color(0x44F9A826),
      title: 'Trabajo',
      subtitle: 'Éxito profesional',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            // Hero
            _HeroImage(
              assetPath: 'assets/images/paywall_hero.png',
              height: 220,
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress bar
                    _ProgressBar(
                      segmentColors: [
                        AppColors.primary,
                        AppColors.primary,
                        AppColors.mint,
                        const Color(0xFF25D366),
                        AppColors.amber,
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Step label — gold
                    Text(
                      'TU INTENCIÓN',
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.amber,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'Elige tu intención\npara cada día',
                      style: GoogleFonts.urbanist(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      'Cada mañana recibirás un mantra alineado\ncon lo que más necesitas',
                      style: GoogleFonts.urbanist(
                        fontSize: 14,
                        color: AppColors.white.withValues(alpha: 0.55),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 18),

                    // 2x2 intention grid
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.4,
                      children: List.generate(_intentions.length, (i) {
                        final item = _intentions[i];
                        final isSelected = _selected == i;
                        return GestureDetector(
                          onTap: () => setState(() => _selected = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? item.fillColor
                                  : const Color(0x0AFFFFFF),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected
                                    ? item.borderColor
                                    : const Color(0x15FFFFFF),
                                width: isSelected ? 1.5 : 1.0,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(item.icon,
                                    color: item.color, size: 22),
                                const SizedBox(height: 6),
                                Text(
                                  item.title,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  item.subtitle,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 11,
                                    color: AppColors.white
                                        .withValues(alpha: 0.50),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 14),

                    Text(
                      'Tu intención puede cambiar — y eso es parte del viaje',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        color: AppColors.white.withValues(alpha: 0.40),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // CTA
                    _PurpleCta(
                      label: 'Continuar',
                      onTap: widget.onNext,
                      height: 56,
                      cornerRadius: 16,
                    ),
                    const SizedBox(height: 16),
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

// ─── Page 6 — Account (12 · Tu Espacio) ───────────────────────────────────────

class _Page7Account extends StatefulWidget {
  final VoidCallback onNext;
  const _Page7Account({required this.onNext});

  @override
  State<_Page7Account> createState() => _Page7AccountState();
}

class _Page7AccountState extends State<_Page7Account> {
  bool _termsAccepted = false;
  bool _passwordVisible = false;

  static const _gray = Color(0x15FFFFFF);
  static const _border = Color(0x26FFFFFF);
  static const _labelColor = Color(0xB3FFFFFF);

  Widget _fieldLabel(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: GoogleFonts.urbanist(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: _labelColor,
            letterSpacing: 0.5,
          ),
        ),
      );

  Widget _inputField({
    required IconData leadingIcon,
    required String hint,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: _gray,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _border),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Icon(leadingIcon, color: AppColors.primaryLight, size: 20),
          ),
          Expanded(
            child: TextField(
              keyboardType: keyboardType,
              obscureText: isPassword && !_passwordVisible,
              style: GoogleFonts.urbanist(
                fontSize: 15,
                color: AppColors.white,
              ),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: GoogleFonts.urbanist(
                  fontSize: 15,
                  color: AppColors.white.withValues(alpha: 0.35),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          if (isPassword)
            GestureDetector(
              onTap: () => setState(() => _passwordVisible = !_passwordVisible),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Icon(
                  _passwordVisible ? LucideIcons.eye : LucideIcons.eyeOff,
                  color: AppColors.white.withValues(alpha: 0.40),
                  size: 20,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
        ),
      ),
      child: Stack(
        children: [
          Positioned(top: -60, left: -30, child: _glow(280, const Color(0x356C5CE7))),
          Positioned(top: -20, right: -60, child: _glow(200, const Color(0x20A29BFE))),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Progress bar: 5 purple, 1 amber, 1 gray
                        _ProgressBar(segmentColors: [
                          AppColors.primary,
                          AppColors.primary,
                          AppColors.primary,
                          AppColors.primary,
                          AppColors.primary,
                          AppColors.amber,
                          AppColors.white.withValues(alpha: 0.15),
                        ]),

                        // Header block
                        Column(children: [
                          const SizedBox(height: 8),
                          Text(
                            'TU ESPACIO',
                            style: GoogleFonts.urbanist(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.amber,
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Reclama tu santuario',
                            style: GoogleFonts.urbanist(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Un espacio sagrado, solo para ti',
                            style: GoogleFonts.urbanist(
                              fontSize: 13,
                              color: AppColors.white.withValues(alpha: 0.50),
                            ),
                          ),
                        ]),

                        // Form block
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _fieldLabel('Nombre'),
                            _inputField(
                                leadingIcon: LucideIcons.user,
                                hint: 'Tu nombre'),
                            const SizedBox(height: 10),
                            _fieldLabel('Email'),
                            _inputField(
                              leadingIcon: LucideIcons.mail,
                              hint: 'tu@email.com',
                              keyboardType: TextInputType.emailAddress,
                            ),
                            const SizedBox(height: 10),
                            _fieldLabel('Contraseña'),
                            _inputField(
                              leadingIcon: LucideIcons.lock,
                              hint: '••••••••',
                              isPassword: true,
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () => setState(
                                  () => _termsAccepted = !_termsAccepted),
                              child: Row(children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: _termsAccepted
                                        ? AppColors.primary
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                      color: _termsAccepted
                                          ? AppColors.primary
                                          : _border,
                                      width: 1.5,
                                    ),
                                  ),
                                  child: _termsAccepted
                                      ? const Icon(LucideIcons.check,
                                          color: AppColors.white, size: 12)
                                      : null,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    'Acepto los términos y política de privacidad',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 12,
                                      color: AppColors.white
                                          .withValues(alpha: 0.50),
                                    ),
                                  ),
                                ),
                              ]),
                            ),
                          ],
                        ),

                        // Actions block
                        Column(children: [
                          _PurpleCta(
                            label: 'Continuar →',
                            onTap: widget.onNext,
                            height: 52,
                            cornerRadius: 16,
                          ),
                          const SizedBox(height: 12),
                          Row(children: [
                            Expanded(
                                child: Container(height: 1, color: _border)),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: Text(
                                'o continúa con',
                                style: GoogleFonts.urbanist(
                                  fontSize: 12,
                                  color: AppColors.white
                                      .withValues(alpha: 0.35),
                                ),
                              ),
                            ),
                            Expanded(
                                child: Container(height: 1, color: _border)),
                          ]),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(
                              child: _SocialButton(
                                  label: 'G  Google', onTap: widget.onNext),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: _SocialButton(
                                  label: 'Apple', onTap: widget.onNext),
                            ),
                          ]),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: widget.onNext,
                            child: Text.rich(TextSpan(
                              text: '¿Ya eres parte de la tribu? ',
                              style: GoogleFonts.urbanist(
                                fontSize: 13,
                                color: AppColors.white.withValues(alpha: 0.50),
                              ),
                              children: [
                                TextSpan(
                                  text: 'Iniciar sesión',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                              ],
                            )),
                          ),
                        ]),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  static Widget _glow(double size, Color color) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, Colors.transparent]),
        ),
      );
}

class _SocialButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _SocialButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: const Color(0x14FFFFFF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: const Color(0x26FFFFFF)),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.urbanist(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

// ─── Page 7 — Paywall (13 · Invierte en tu transformación) ───────────────────

class _Page8Paywall extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Page8Paywall({required this.onNext, required this.onBack});

  @override
  State<_Page8Paywall> createState() => _Page8PaywallState();
}

class _Page8PaywallState extends State<_Page8Paywall> {
  int _selectedPlan = 0; // 0=Anual, 1=Mensual, 2=Semanal

  static const _progressGray = Color(0x26FFFFFF);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Amber glow top-right
            Positioned(
              top: -40,
              right: -40,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.amber.withValues(alpha: 0.18),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Progress bar — all 7 colored
                        _ProgressBar(segmentColors: [
                          AppColors.primary,
                          AppColors.primary,
                          AppColors.primary,
                          AppColors.primary,
                          AppColors.primary,
                          AppColors.amber,
                          _progressGray,
                        ]),
                        const SizedBox(height: 8),

                        // Hero with close button
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: SizedBox(
                                height: 180,
                                width: double.infinity,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: [
                                    Image.asset(
                                      'assets/images/paywall_hero.png',
                                      fit: BoxFit.cover,
                                    ),
                                    Container(
                                      decoration: const BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0x000F0A2A),
                                            Color(0xCC0F0A2A),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: GestureDetector(
                                onTap: widget.onNext,
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: const BoxDecoration(
                                    color: Color(0x40000000),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    LucideIcons.x,
                                    color: AppColors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),

                        // Gold badge
                        Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 5),
                            decoration: BoxDecoration(
                              color: AppColors.goldBg,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(color: AppColors.goldBorder),
                            ),
                            child: Text(
                              'ACCESO PARA NUEVOS MIEMBROS',
                              style: GoogleFonts.urbanist(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: AppColors.gold,
                                letterSpacing: 1,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),

                        // Title
                        Center(
                          child: Text(
                            'Invierte en tu\ntransformación',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: AppColors.white,
                              height: 1.15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),

                        // Social proof
                        Center(
                          child: Text(
                            '★★★★★  4.9 · +52,000 vidas transformadas',
                            style: GoogleFonts.urbanist(
                              fontSize: 12,
                              color: AppColors.white.withValues(alpha: 0.60),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Plan cards
                        Column(children: [
                          // Card 0 — Anual (most popular, selected by default)
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              _PlanCard(
                                isSelected: _selectedPlan == 0,
                                onTap: () => setState(() => _selectedPlan = 0),
                                borderColor: _selectedPlan == 0
                                    ? AppColors.primary
                                    : const Color(0x26FFFFFF),
                                borderWidth: _selectedPlan == 0 ? 2.0 : 1.0,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text(
                                        'Anual',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primaryLight,
                                        ),
                                      ),
                                      const Spacer(),
                                      // AHORRA badge
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.mint
                                              .withValues(alpha: 0.20),
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Text(
                                          'AHORRA 85%',
                                          style: GoogleFonts.urbanist(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.mint,
                                          ),
                                        ),
                                      ),
                                    ]),
                                    const SizedBox(height: 4),
                                    Text(
                                      r'$29.99/año',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Todo ilimitado · 7 días gratis',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 12,
                                        color: AppColors.primaryLight
                                            .withValues(alpha: 0.80),
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      r'$2.49/Premium · Descuento $17.90/año',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 11,
                                        color: AppColors.white
                                            .withValues(alpha: 0.40),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // MÁS POPULAR badge
                              Positioned(
                                top: -12,
                                left: 16,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 3),
                                  decoration: BoxDecoration(
                                    gradient: AppGradients.primaryButton,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    'MÁS POPULAR',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.white,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Card 1 — Mensual
                          _PlanCard(
                            isSelected: _selectedPlan == 1,
                            onTap: () => setState(() => _selectedPlan = 1),
                            borderColor: _selectedPlan == 1
                                ? AppColors.primaryLight
                                : const Color(0x26FFFFFF),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Mensual',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Todo ilimitado · 7 días gratis',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 12,
                                          color: AppColors.white
                                              .withValues(alpha: 0.45),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        r'$1.92/Semana',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 11,
                                          color: AppColors.white
                                              .withValues(alpha: 0.35),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  r'$7.99/mes',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white
                                        .withValues(alpha: 0.60),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),

                          // Card 2 — Semanal
                          _PlanCard(
                            isSelected: _selectedPlan == 2,
                            onTap: () => setState(() => _selectedPlan = 2),
                            borderColor: _selectedPlan == 2
                                ? AppColors.amber
                                : const Color(0x26FFFFFF),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Semanal',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Ideal para probar · Sin compromiso',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 12,
                                          color: AppColors.white
                                              .withValues(alpha: 0.45),
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Facturado cada semana',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 11,
                                          color: AppColors.white
                                              .withValues(alpha: 0.35),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  r'$3.99/sem',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.white
                                        .withValues(alpha: 0.60),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        const SizedBox(height: 14),

                        // Trial guarantee note
                        Center(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(LucideIcons.shieldCheck,
                                  color: AppColors.mint, size: 14),
                              const SizedBox(width: 6),
                              Text(
                                '7 días gratis · Prueba sin riesgo, cancela cuando quieras',
                                style: GoogleFonts.urbanist(
                                  fontSize: 11,
                                  color: AppColors.white
                                      .withValues(alpha: 0.55),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // CTA
                        _GradientButton(
                          label: 'Comenzar mi transformación',
                          gradient: AppGradients.primaryButton,
                          textColor: AppColors.white,
                          shadowColor:
                              AppColors.primary.withValues(alpha: 0.45),
                          icon: LucideIcons.sparkles,
                          height: 56,
                          cornerRadius: 16,
                          onTap: widget.onNext,
                        ),
                        const SizedBox(height: 8),

                        Center(
                          child: Text(
                            'Esta invitación es solo para nuevos miembros',
                            style: GoogleFonts.urbanist(
                              fontSize: 12,
                              color: AppColors.white.withValues(alpha: 0.40),
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),

                        Center(
                          child: Text(
                            'Garantía de satisfacción · Comenzará 2 hrs en...',
                            style: GoogleFonts.urbanist(
                              fontSize: 11,
                              color: AppColors.white.withValues(alpha: 0.30),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Skip
                        Center(
                          child: _SkipLink(
                            onTap: widget.onNext,
                            label:
                                'Ahora no, quiero explorar primero',
                          ),
                        ),
                        const SizedBox(height: 8),

                        Center(
                          child: Text(
                            'Al continuar aceptas los Términos y Política de Privacidad',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: 10,
                              color: AppColors.white.withValues(alpha: 0.25),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final Color borderColor;
  final double borderWidth;
  final Widget child;

  const _PlanCard({
    required this.isSelected,
    required this.onTap,
    required this.borderColor,
    required this.child,
    this.borderWidth = 1,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.06)
              : const Color(0x0AFFFFFF),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: borderColor, width: borderWidth),
        ),
        child: child,
      ),
    );
  }
}

// ─── Page 8 — Final Welcome (14 · Bienvenida Final) ──────────────────────────

class _Page9FinalWelcome extends StatelessWidget {
  const _Page9FinalWelcome();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundStart, AppColors.backgroundEnd],
        ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            // Purple glow top-center
            Positioned(
              top: -30,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 360,
                  height: 360,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        const Color(0x456C5CE7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Amber glow bottom-right
            Positioned(
              bottom: 40,
              right: -30,
              child: Container(
                width: 240,
                height: 240,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0x30F9A826),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // Progress bar: all 7 colored
                  _ProgressBar(
                    segmentColors: [
                      AppColors.primary,
                      AppColors.primary,
                      AppColors.primary,
                      AppColors.primary,
                      AppColors.primary,
                      AppColors.amber,
                      AppColors.mint,
                    ],
                  ),

                  const Spacer(),

                  // Logo 120x120
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.50),
                          blurRadius: 40,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset('assets/images/logomantra.png',
                          fit: BoxFit.cover),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tagline
                  Text(
                    'TU TRIBU TE DA LA BIENVENIDA',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryLight,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Title
                  Text(
                    'Ahora eres parte\nde algo más grande',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 34,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 14),

                  // Subtitle
                  Text(
                    '52,000+ almas despiertas te acompañan.\nTu transformación comienza con el primer paso.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: AppColors.white.withValues(alpha: 0.50),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 3 feature chips
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _FeatureChip(
                        icon: LucideIcons.sparkles,
                        iconColor: AppColors.primaryLight,
                        label: 'Mantras',
                      ),
                      const SizedBox(width: 12),
                      _FeatureChip(
                        icon: LucideIcons.users,
                        iconColor: AppColors.mint,
                        label: 'Comunidad',
                      ),
                      const SizedBox(width: 12),
                      _FeatureChip(
                        icon: LucideIcons.star,
                        iconColor: AppColors.amber,
                        label: 'Rituales',
                      ),
                    ],
                  ),

                  const Spacer(),

                  // CTA
                  _GradientButton(
                    label: 'Entrar a mi santuario',
                    gradient: AppGradients.primaryButton,
                    textColor: AppColors.white,
                    shadowColor: AppColors.primary.withValues(alpha: 0.45),
                    icon: LucideIcons.home,
                    height: 64,
                    cornerRadius: 20,
                    onTap: () => context.go('/home'),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    'Tu tribu te espera — cada día es una nueva oportunidad',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      color: AppColors.white.withValues(alpha: 0.25),
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureChip extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const _FeatureChip({
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      width: 90,
      decoration: BoxDecoration(
        color: const Color(0x14FFFFFF),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, size: 22),
          const SizedBox(height: 6),
          Text(
            label,
            style: GoogleFonts.urbanist(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
