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
    if (_currentPage < 7) {
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
          _Page3Experience(onNext: _next),
          _Page4WhatsApp(onNext: _next),
          _Page5CreateAccount(onNext: _next),
          _Page6ChoosePlan(onNext: _next, onBack: _prev),
          _Page7PersonalizedPlan(onNext: _next),
          const _Page8FinalWelcome(),
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

  const _SkipLink({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        'Omitir por ahora',
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
          // ── Hero image (top 45%) ──
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
                // Purple glow
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
                      BoxShadow(color: AppColors.primary.withValues(alpha: 0.50), blurRadius: 40, spreadRadius: 3),
                    ],
                  ),
                  child: ClipOval(child: Image.asset('assets/images/logomantra.png', fit: BoxFit.cover)),
                ),
              ],
            ),
          ),

          // ── Content (bottom area, no scroll) ──
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
                    fontSize: 13, fontWeight: FontWeight.w700,
                    color: AppColors.primaryLight, letterSpacing: 6,
                  ),
                ),
                const SizedBox(height: 8),

                // Title
                Text(
                  'Tu transformación\ncomienza aquí',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                    fontSize: 30, fontWeight: FontWeight.w800,
                    color: AppColors.white, height: 1.15,
                  ),
                ),
                const SizedBox(height: 6),

                // Subtitle
                Text(
                  'Únete a +50,000 personas que ya\ntransformaron su bienestar diario',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                    fontSize: 13, color: AppColors.white.withValues(alpha: 0.63), height: 1.5,
                  ),
                ),
                const SizedBox(height: 10),

                // Stars + rating
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(5, (_) => const Icon(LucideIcons.star, color: AppColors.gold, size: 16)),
                    const SizedBox(width: 6),
                    Text(
                      '4.9 ★ · Mejor app de meditación 2024',
                      style: GoogleFonts.urbanist(fontSize: 12, color: AppColors.white.withValues(alpha: 0.50)),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

                // Exclusive offer badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0x15FFD700),
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: const Color(0x60FFD700)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(LucideIcons.gift, color: AppColors.gold, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        'Regístrate hoy: 7 días PRO gratis',
                        style: GoogleFonts.urbanist(fontSize: 11, fontWeight: FontWeight.w700, color: const Color(0xDDFFD700)),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                // Trust row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _TrustItem(icon: LucideIcons.shieldCheck, iconColor: AppColors.mint, label: '100% seguro'),
                    const SizedBox(width: 18),
                    _TrustItem(icon: LucideIcons.timer, iconColor: AppColors.primaryLight, label: '7 días gratis'),
                    const SizedBox(width: 18),
                    _TrustItem(icon: LucideIcons.xCircle, iconColor: AppColors.amber, label: 'Cancela ya'),
                  ],
                ),

                const Spacer(),

                // CTA
                _GradientButton(
                  label: 'Comenzar mi viaje',
                  gradient: AppGradients.primaryButton,
                  textColor: AppColors.white,
                  shadowColor: AppColors.primary.withValues(alpha: 0.50),
                  icon: LucideIcons.arrowRight,
                  height: 56,
                  cornerRadius: 18,
                  onTap: onNext,
                ),
                const SizedBox(height: 12),

                // Login link
                GestureDetector(
                  onTap: () => context.go('/home'),
                  child: Text.rich(
                    TextSpan(
                      text: '¿Ya tienes cuenta? ',
                      style: GoogleFonts.urbanist(fontSize: 13, color: AppColors.textSecondary),
                      children: [
                        TextSpan(
                          text: 'Iniciar sesión',
                          style: GoogleFonts.urbanist(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryLight),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Dots
                _ProgressDots(activeDot: 0, total: 5, activeColor: AppColors.primary),
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

class _TrustItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;

  const _TrustItem({
    required this.icon,
    required this.iconColor,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: iconColor, size: 20),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.urbanist(
            fontSize: 12,
            color: AppColors.white.withValues(alpha: 0.38),
          ),
        ),
      ],
    );
  }
}

// ─── Page 2 — Objectives Quiz (08 · Objetivos) ────────────────────────────────

const List<(String, String)> _objectiveItems = [
  ('😌', 'Reducir estrés y ansiedad'),
  ('😴', 'Dormir mejor'),
  ('🔄', 'Mejorar mis hábitos'),
  ('💔', 'Superar un duelo o pérdida'),
  ('💰', 'Abundancia y prosperidad'),
  ('🎯', 'Mayor enfoque y concentración'),
  ('✨', 'Crecimiento espiritual'),
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
                padding: const EdgeInsets.fromLTRB(14, 24, 14, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress bar: 2 purple, 3 gray
                    _ProgressBar(
                      segmentColors: [
                        AppColors.primary,
                        AppColors.primary,
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'PASO 1 DE 5',
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryLight,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      '¿Cuál es tu objetivo con\nlas meditaciones guiadas?',
                      style: GoogleFonts.urbanist(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      'Selecciona todo lo que aplique',
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
                      label: 'Continuar',
                      onTap: widget.onNext,
                      height: 56,
                      cornerRadius: 16,
                    ),
                    const SizedBox(height: 12),

                    Center(
                      child: _SkipLink(onTap: widget.onNext),
                    ),
                    const SizedBox(height: 16),

                    // Dots: dot0 = filled purple (past), dot1 = active purple
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

// ─── Page 3 — Experience (09 · Experiencia) ──────────────────────────────────

class _Page3Experience extends StatefulWidget {
  final VoidCallback onNext;
  const _Page3Experience({required this.onNext});

  @override
  State<_Page3Experience> createState() => _Page3ExperienceState();
}

class _Page3ExperienceState extends State<_Page3Experience> {
  int _selectedLevel = 0;
  int _selectedTime = 0;

  // Neuromarketing: emotional benefits per level, social proof badges
  static const _levels = [
    (
      emoji: '🌱',
      title: 'Estoy comenzando',
      subtitle: 'Quiero descubrir mi paz interior',
      badge: 'Más popular',
      badgeColor: AppColors.mint,
      benefit: '5 min al día = 40% menos estrés en 2 semanas',
    ),
    (
      emoji: '🧘',
      title: 'Ya tengo algo de práctica',
      subtitle: 'Busco profundizar mi bienestar',
      badge: null,
      badgeColor: AppColors.mint,
      benefit: 'Desbloquea técnicas avanzadas de respiración',
    ),
    (
      emoji: '🔮',
      title: 'Practico regularmente',
      subtitle: 'Quiero elevar mi nivel espiritual',
      badge: 'Avanzado',
      badgeColor: AppColors.primaryLight,
      benefit: 'Accede a rituales y frecuencias exclusivas',
    ),
  ];

  static const _times = [
    (value: '5', label: 'min', desc: 'Perfecto\npara empezar'),
    (value: '10', label: 'min', desc: 'Lo más\nelegido'),
    (value: '15', label: 'min', desc: 'Cambio\nreal'),
    (value: '20+', label: 'min', desc: 'Trans-\nformación'),
  ];

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
            // Hero (compact)
            _HeroImage(assetPath: 'assets/images/experience_hero.png', height: h * 0.25),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress bar
                    _ProgressBar(segmentColors: [
                      AppColors.primary, AppColors.primary, AppColors.mint,
                      AppColors.white.withValues(alpha: 0.15),
                      AppColors.white.withValues(alpha: 0.15),
                    ]),
                    const SizedBox(height: 8),

                    // Step + social proof hook
                    Row(
                      children: [
                        Text('PASO 2 DE 5', style: GoogleFonts.urbanist(
                          fontSize: 11, fontWeight: FontWeight.w700,
                          color: AppColors.mint, letterSpacing: 2,
                        )),
                        const Spacer(),
                        Icon(LucideIcons.users, color: AppColors.mint.withValues(alpha: 0.7), size: 12),
                        const SizedBox(width: 4),
                        Text('12,847 hoy', style: GoogleFonts.urbanist(
                          fontSize: 10, color: AppColors.mint.withValues(alpha: 0.7),
                        )),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Headline — emotional, not clinical
                    Text(
                      'Tu bienestar merece\nun plan personalizado',
                      style: GoogleFonts.urbanist(
                        fontSize: 24, fontWeight: FontWeight.w700,
                        color: AppColors.white, height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Anchoring + social proof
                    Text(
                      'Sin importar tu nivel, te guiamos paso a paso',
                      style: GoogleFonts.urbanist(
                        fontSize: 13, color: AppColors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Level cards — compact, emotional
                    ...List.generate(_levels.length, (i) {
                      final isSelected = _selectedLevel == i;
                      final item = _levels[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedLevel = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 180),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0x1555EFC4) : const Color(0x0AFFFFFF),
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? AppColors.mint : const Color(0x20FFFFFF),
                                width: isSelected ? 2.0 : 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(item.emoji, style: const TextStyle(fontSize: 24)),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(item.title, style: GoogleFonts.urbanist(
                                        fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.white,
                                      )),
                                      const SizedBox(height: 1),
                                      Text(item.subtitle, style: GoogleFonts.urbanist(
                                        fontSize: 11, color: AppColors.white.withValues(alpha: 0.50),
                                      )),
                                    ],
                                  ),
                                ),
                                if (item.badge != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: item.badgeColor.withValues(alpha: 0.20),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(item.badge!, style: GoogleFonts.urbanist(
                                      fontSize: 10, fontWeight: FontWeight.w700, color: item.badgeColor,
                                    )),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),

                    // Benefit callout for selected level
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      child: Container(
                        key: ValueKey(_selectedLevel),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.mint.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            const Icon(LucideIcons.sparkles, color: AppColors.mint, size: 14),
                            const SizedBox(width: 8),
                            Expanded(child: Text(
                              _levels[_selectedLevel].benefit,
                              style: GoogleFonts.urbanist(
                                fontSize: 11, fontWeight: FontWeight.w600,
                                color: AppColors.mint.withValues(alpha: 0.85),
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Time question — with emotional framing
                    Text(
                      '¿Cuánto tiempo puedes dedicarte hoy?',
                      style: GoogleFonts.urbanist(
                        fontSize: 14, fontWeight: FontWeight.w700, color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Time chips
                    Row(
                      children: List.generate(_times.length, (i) {
                        final isSelected = _selectedTime == i;
                        final t = _times[i];
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(right: i < 3 ? 8 : 0),
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedTime = i),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 180),
                                height: 56,
                                decoration: BoxDecoration(
                                  color: isSelected ? const Color(0x1555EFC4) : const Color(0x0AFFFFFF),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSelected ? AppColors.mint : const Color(0x20FFFFFF),
                                    width: isSelected ? 2.0 : 1.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(t.value, style: GoogleFonts.urbanist(
                                      fontSize: 18, fontWeight: FontWeight.w700,
                                      color: isSelected ? AppColors.mint : AppColors.white,
                                    )),
                                    Text(t.label, style: GoogleFonts.urbanist(
                                      fontSize: 9, color: AppColors.white.withValues(alpha: 0.45),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 16),

                    // Urgency + reward micro-copy
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.10),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(LucideIcons.trophy, color: AppColors.gold, size: 14),
                            const SizedBox(width: 6),
                            Text(
                              'Tu plan personalizado está casi listo',
                              style: GoogleFonts.urbanist(
                                fontSize: 11, fontWeight: FontWeight.w600,
                                color: AppColors.gold.withValues(alpha: 0.85),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    // CTA — commitment language
                    _PurpleCta(
                      label: 'Crear mi programa',
                      onTap: widget.onNext,
                      height: 54,
                      cornerRadius: 16,
                    ),
                    const SizedBox(height: 8),

                    Center(child: _SkipLink(onTap: widget.onNext)),
                    const SizedBox(height: 10),

                    Center(
                      child: _ProgressDots(
                        activeDot: 2, total: 5, activeColor: AppColors.mint,
                        dotColors: {0: AppColors.primary, 1: AppColors.primary},
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

// ─── Page 4 — WhatsApp (10 · WhatsApp) ────────────────────────────────────────

class _Page4WhatsApp extends StatefulWidget {
  final VoidCallback onNext;
  const _Page4WhatsApp({required this.onNext});

  @override
  State<_Page4WhatsApp> createState() => _Page4WhatsAppState();
}

class _Page4WhatsAppState extends State<_Page4WhatsApp> {
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
      'Recordatorios diarios de meditación',
      'Alertas de rituales lunares y frecuencias',
      'Ofertas exclusivas y contenido gratuito',
      'Tu número está protegido y es privado',
    ];

    const greenGradient = LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [AppColors.mint, Color(0xFF2ED8A3)],
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
            _HeroImage(assetPath: 'assets/images/whatsapp_hero.png', height: 260),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Progress: 2 purple, 1 mint, 2 gray
                    _ProgressBar(
                      segmentColors: [
                        AppColors.primary,
                        AppColors.primary,
                        AppColors.mint,
                        AppColors.white.withValues(alpha: 0.15),
                        AppColors.white.withValues(alpha: 0.15),
                      ],
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'PASO 3 DE 5',
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppColors.mint,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 10),

                    Text(
                      'Ingresa tu número\npara continuar',
                      style: GoogleFonts.urbanist(
                        fontSize: 26,
                        fontWeight: FontWeight.w700,
                        color: AppColors.white,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Text(
                      'Te enviaremos un código por WhatsApp o SMS',
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
                                    ? const Color(0x2055EFC4)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: _useWhatsapp
                                      ? AppColors.mint
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
                                      ? AppColors.mint
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
                                    ? const Color(0x2055EFC4)
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: !_useWhatsapp
                                      ? AppColors.mint
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
                                      ? AppColors.mint
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
                              color: AppColors.mint,
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
                      label: _useWhatsapp
                          ? 'Enviar código por WhatsApp'
                          : 'Enviar código por SMS',
                      gradient: greenGradient,
                      textColor: const Color(0xFF0A0A1A),
                      shadowColor: AppColors.mint.withValues(alpha: 0.40),
                      icon: LucideIcons.arrowRight,
                      height: 56,
                      cornerRadius: 16,
                      onTap: widget.onNext,
                    ),
                    const SizedBox(height: 10),

                    Center(
                      child: Text(
                        'Al continuar aceptas nuestros Términos y Política de Privacidad',
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

                    // Dots: dot3 active mint, dot0+dot1 purple, dot2 mint (past)
                    Center(
                      child: _ProgressDots(
                        activeDot: 3,
                        total: 5,
                        activeColor: AppColors.mint,
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

// ─── Page 5 — Crear Cuenta (12 · Crear cuenta) ────────────────────────────────

class _Page5CreateAccount extends StatefulWidget {
  final VoidCallback onNext;
  const _Page5CreateAccount({required this.onNext});

  @override
  State<_Page5CreateAccount> createState() => _Page5CreateAccountState();
}

class _Page5CreateAccountState extends State<_Page5CreateAccount> {
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
    const progressGray = Color(0x26FFFFFF);

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
                    constraints: BoxConstraints(minHeight: constraints.maxHeight - 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Progress bar
                        _ProgressBar(segmentColors: [
                          AppColors.primary, AppColors.primary, AppColors.primary,
                          AppColors.primary, AppColors.primaryLight,
                          progressGray, progressGray,
                        ]),

                        // Logo + header block
                        Column(children: [
                          Container(
                            width: 72, height: 72,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.50), blurRadius: 30, spreadRadius: 4)],
                            ),
                            child: ClipOval(child: Image.asset('assets/images/logomantra.png', fit: BoxFit.cover)),
                          ),
                          const SizedBox(height: 10),
                          Text('PASO 5 DE 7', style: GoogleFonts.urbanist(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primaryLight, letterSpacing: 2)),
                          const SizedBox(height: 4),
                          Text('Crear tu cuenta', style: GoogleFonts.urbanist(fontSize: 26, fontWeight: FontWeight.w700, color: AppColors.white)),
                          const SizedBox(height: 2),
                          Text('Únete a la comunidad MANTRAS', style: GoogleFonts.urbanist(fontSize: 13, color: AppColors.white.withValues(alpha: 0.50))),
                        ]),

                        // Form block
                        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          _fieldLabel('Nombre completo'),
                          _inputField(leadingIcon: LucideIcons.user, hint: 'Tu nombre'),
                          const SizedBox(height: 10),
                          _fieldLabel('Correo electrónico'),
                          _inputField(leadingIcon: LucideIcons.mail, hint: 'tu@email.com', keyboardType: TextInputType.emailAddress),
                          const SizedBox(height: 10),
                          _fieldLabel('Contraseña'),
                          _inputField(leadingIcon: LucideIcons.lock, hint: '••••••••', isPassword: true),
                          const SizedBox(height: 10),
                          GestureDetector(
                            onTap: () => setState(() => _termsAccepted = !_termsAccepted),
                            child: Row(children: [
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 150),
                                width: 20, height: 20,
                                decoration: BoxDecoration(
                                  color: _termsAccepted ? AppColors.primary : Colors.transparent,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(color: _termsAccepted ? AppColors.primary : _border, width: 1.5),
                                ),
                                child: _termsAccepted ? const Icon(LucideIcons.check, color: AppColors.white, size: 12) : null,
                              ),
                              const SizedBox(width: 8),
                              Expanded(child: Text('Acepto los términos y política de privacidad', style: GoogleFonts.urbanist(fontSize: 12, color: AppColors.white.withValues(alpha: 0.50)))),
                            ]),
                          ),
                        ]),

                        // Actions block
                        Column(children: [
                          _PurpleCta(label: 'Continuar', onTap: widget.onNext, height: 52, cornerRadius: 16),
                          const SizedBox(height: 12),
                          Row(children: [
                            Expanded(child: Container(height: 1, color: _border)),
                            Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text('o continúa con', style: GoogleFonts.urbanist(fontSize: 12, color: AppColors.white.withValues(alpha: 0.35)))),
                            Expanded(child: Container(height: 1, color: _border)),
                          ]),
                          const SizedBox(height: 10),
                          Row(children: [
                            Expanded(child: _SocialButton(label: 'G  Google', onTap: widget.onNext)),
                            const SizedBox(width: 10),
                            Expanded(child: _SocialButton(label: 'Apple', onTap: widget.onNext)),
                          ]),
                          const SizedBox(height: 12),
                          GestureDetector(
                            onTap: widget.onNext,
                            child: Text.rich(TextSpan(
                              text: '¿Ya tienes cuenta? ',
                              style: GoogleFonts.urbanist(fontSize: 13, color: AppColors.white.withValues(alpha: 0.50)),
                              children: [TextSpan(text: 'Iniciar sesión', style: GoogleFonts.urbanist(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primaryLight))],
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
    width: size, height: size,
    decoration: BoxDecoration(shape: BoxShape.circle, gradient: RadialGradient(colors: [color, Colors.transparent])),
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

// ─── Page 6 — Elige tu Plan (13 · Plan) ──────────────────────────────────────

class _Page6ChoosePlan extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;

  const _Page6ChoosePlan({required this.onNext, required this.onBack});

  @override
  State<_Page6ChoosePlan> createState() => _Page6ChoosePlanState();
}

class _Page6ChoosePlanState extends State<_Page6ChoosePlan> {
  int _selectedPlan = 1; // 0=Free, 1=Pro, 2=Annual

  static const _progressGray = Color(0x26FFFFFF);

  String get _ctaLabel {
    switch (_selectedPlan) {
      case 0:
        return 'Comenzar con Gratuito';
      case 2:
        return 'Comenzar con Anual';
      default:
        return 'Comenzar con Pro';
    }
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
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: constraints.maxHeight - 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                  // Back + progress
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    GestureDetector(
                      onTap: widget.onBack,
                      child: Row(mainAxisSize: MainAxisSize.min, children: [
                        const Icon(LucideIcons.chevronLeft, color: Color(0x80FFFFFF), size: 20),
                        const SizedBox(width: 4),
                        Text('Volver', style: GoogleFonts.urbanist(fontSize: 14, color: AppColors.white.withValues(alpha: 0.50))),
                      ]),
                    ),
                    const SizedBox(height: 10),
                    _ProgressBar(segmentColors: [
                      AppColors.primary, AppColors.primary, AppColors.primary,
                      AppColors.primary, AppColors.primary, AppColors.amber, _progressGray,
                    ]),
                  ]),

                  // Header centered
                  Column(children: [
                    Center(child: Text('PASO 6 DE 7', style: GoogleFonts.urbanist(fontSize: 12, fontWeight: FontWeight.w700, color: AppColors.amber, letterSpacing: 2))),
                    const SizedBox(height: 6),
                    Center(child: Text('Elige tu plan', style: GoogleFonts.urbanist(fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.white))),
                    const SizedBox(height: 4),
                    Center(child: Text('Comienza gratis · Cancela cuando quieras', style: GoogleFonts.urbanist(fontSize: 13, color: AppColors.white.withValues(alpha: 0.50)))),
                  ]),

                  // Plan cards block
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _PlanCard(
                    isSelected: _selectedPlan == 0,
                    onTap: () => setState(() => _selectedPlan = 0),
                    borderColor: _selectedPlan == 0
                        ? AppColors.primaryLight
                        : const Color(0x26FFFFFF),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Gratuito',
                                style: GoogleFonts.urbanist(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '3 meditaciones · Alarma básica · Sin frecuencias',
                                style: GoogleFonts.urbanist(
                                  fontSize: 13,
                                  color: AppColors.white.withValues(alpha: 0.38),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          r'$0 / mes',
                          style: GoogleFonts.urbanist(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white.withValues(alpha: 0.50),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Card 2 — Pro (selected by default)
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      _PlanCard(
                        isSelected: _selectedPlan == 1,
                        onTap: () => setState(() => _selectedPlan = 1),
                        borderColor: AppColors.primary,
                        borderWidth: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pro ✦',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primaryLight,
                                  ),
                                ),
                                const Spacer(),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      r'$7.99 / mes',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors.white,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.mint.withValues(alpha: 0.20),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Text(
                                        '7 días gratis',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 11,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.mint,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Meditaciones ilimitadas · Todas las frecuencias',
                              style: GoogleFonts.urbanist(
                                fontSize: 13,
                                color: AppColors.primaryLight.withValues(alpha: 0.80),
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Alarmas biológicas · Sesiones privadas',
                              style: GoogleFonts.urbanist(
                                fontSize: 13,
                                color: AppColors.primaryLight.withValues(alpha: 0.80),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // "MÁS POPULAR" badge
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

                  // Card 3 — Anual
                  _PlanCard(
                    isSelected: _selectedPlan == 2,
                    onTap: () => setState(() => _selectedPlan = 2),
                    borderColor: _selectedPlan == 2
                        ? AppColors.amber
                        : const Color(0x60F9A826),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Anual 🏆',
                                style: GoogleFonts.urbanist(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.amber,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Todo de Pro · Ahorra 40% · Acceso al Alquimista',
                                style: GoogleFonts.urbanist(
                                  fontSize: 13,
                                  color: const Color(0xFFFFEAA7).withValues(alpha: 0.80),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          r'$59.99 / año',
                          style: GoogleFonts.urbanist(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFFFEAA7),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ]),

                  // Actions block
                  Column(children: [
                  _GradientButton(
                    label: _ctaLabel,
                    gradient: AppGradients.primaryButton,
                    textColor: AppColors.white,
                    shadowColor: AppColors.primary.withValues(alpha: 0.45),
                    icon: LucideIcons.sparkles,
                    height: 56,
                    cornerRadius: 16,
                    onTap: widget.onNext,
                  ),
                  const SizedBox(height: 10),

                  Center(
                    child: GestureDetector(
                      onTap: widget.onNext,
                      child: Text(
                        'Continuar con Gratuito',
                        style: GoogleFonts.urbanist(
                          fontSize: 13,
                          color: AppColors.white.withValues(alpha: 0.31),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  ]),
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

// ─── Page 7 — Plan Personalizado (11 · Results) ───────────────────────────────

class _Page7PersonalizedPlan extends StatelessWidget {
  final VoidCallback onNext;
  const _Page7PersonalizedPlan({required this.onNext});

  static const _resultItems = [
    ('🧘', 'meditaciones diarias', '3 meditaciones diarias'),
    ('🌙', 'rituales lunares', 'Rituales lunares personalizados'),
    ('🎵', 'frecuencias', 'Frecuencias 528Hz recomendadas'),
    ('⏰', 'alarma biológica', 'Alarma biológica a las 6:30 AM'),
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight - 36),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Progress bar: all 7 segments colored
              _ProgressBar(
                segmentColors: [
                  AppColors.primary,
                  AppColors.primary,
                  AppColors.primary,
                  AppColors.primary,
                  AppColors.primaryLight,
                  AppColors.amber,
                  AppColors.mint,
                ],
              ),
              const SizedBox(height: 24),

              // Sparkles icon on purple circle
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, AppColors.primaryLight],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.45),
                      blurRadius: 24,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(LucideIcons.sparkles,
                    color: AppColors.white, size: 36),
              ),
              const SizedBox(height: 20),

              Text(
                'Tu programa está listo',
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 10),

              Text(
                'Basado en tus respuestas, hemos creado\nun plan perfecto para ti',
                textAlign: TextAlign.center,
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  color: AppColors.white.withValues(alpha: 0.50),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),

              // 4 result cards
              ..._resultItems.map(
                (item) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: const Color(0x0AFFFFFF),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: const Color(0x15FFFFFF)),
                    ),
                    child: Row(
                      children: [
                        Text(item.$1, style: const TextStyle(fontSize: 22)),
                        const SizedBox(width: 14),
                        Text(
                          item.$3,
                          style: GoogleFonts.urbanist(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Green CTA
              _GradientButton(
                label: 'Activar mi programa',
                gradient: AppGradients.greenButton,
                textColor: const Color(0xFF0A0A1A),
                shadowColor: AppColors.mint.withValues(alpha: 0.40),
                icon: LucideIcons.arrowRight,
                height: 56,
                cornerRadius: 16,
                onTap: onNext,
              ),
              const SizedBox(height: 8),
            ],
          ),
        ),
      );
          },
        ),
      ),
    );
  }
}

// ─── Page 8 — Bienvenida Final (14 · Bienvenida final) ───────────────────────

class _Page8FinalWelcome extends StatelessWidget {
  const _Page8FinalWelcome();

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

                  // Progress bar: all 7 segments colored (4 purple, 2 amber, 1 mint)
                  _ProgressBar(
                    segmentColors: [
                      AppColors.primary,
                      AppColors.primary,
                      AppColors.primary,
                      AppColors.primary,
                      AppColors.amber,
                      AppColors.amber,
                      AppColors.mint,
                    ],
                  ),

                  const Spacer(),

                  // Logo circle
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.primary, AppColors.primaryLight],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.50),
                          blurRadius: 40,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: const Icon(LucideIcons.sparkles,
                        color: AppColors.white, size: 40),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    'BIENVENIDO/A',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryLight,
                      letterSpacing: 3,
                    ),
                  ),
                  const SizedBox(height: 12),

                  Text(
                    'Tu viaje\ncomienza ahora',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 14),

                  Text(
                    'Hemos preparado tu espacio sagrado.\nTodo está listo para ti.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 16,
                      color: AppColors.white.withValues(alpha: 0.50),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 28),

                  // 3 feature chips horizontal
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _FeatureChip(
                        icon: LucideIcons.bellRing,
                        iconColor: AppColors.primaryLight,
                        label: 'Alarmas',
                      ),
                      const SizedBox(width: 12),
                      _FeatureChip(
                        icon: LucideIcons.waves,
                        iconColor: AppColors.mint,
                        label: 'Frecuencias',
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

                  // Purple CTA
                  _GradientButton(
                    label: 'Ir a mi santuario',
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
                    'Todo tu progreso se guarda automáticamente',
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
