import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:video_player/video_player.dart';

import '../services/revenuecat_service.dart';
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
    'bFUOx',
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
  final _paywallScrollController = ScrollController(keepScrollOffset: false);
  int _page = 0;
  bool _precacheStarted = false;
  final Set<String> _needs = {'Calma y protección'};
  final Set<String> _times = {'5 minutos'};
  final Set<String> _guidance = {'Guíame paso a paso'};
  _PaywallPlan _selectedPaywallPlan = _PaywallPlan.annual;
  bool _paywallActionInProgress = false;
  bool _restoreInProgress = false;
  bool _paywallOfferingsRequested = false;
  Offerings? _paywallOfferings;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_precacheStarted) return;
    _precacheStarted = true;

    for (final nodeId in _nodes) {
      if (nodeId == 'TTLH4' || nodeId == 'CqnJW') continue;
      unawaited(
        precacheImage(AssetImage('assets/pencil/$nodeId.png'), context),
      );
    }
    unawaited(
      precacheImage(
        const AssetImage('assets/images/onboarding_story_01_poster.png'),
        context,
      ),
    );
    unawaited(
      precacheImage(
        const AssetImage(
          'assets/images/onboarding_story_05_intention_poster.png',
        ),
        context,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _paywallScrollController.dispose();
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

  void _toggleIntention(String value) {
    setState(() {
      if (_needs.contains(value)) {
        // Keep one clear primary intention at all times.
        if (_needs.length > 1) _needs.remove(value);
        return;
      }

      // The first selection is primary; the next two are secondary.
      if (_needs.length == 3) _needs.remove(_needs.last);
      _needs.add(value);
    });
  }

  Package? _packageForPlan(Offerings offerings) {
    final packages = offerings.current?.availablePackages ?? const <Package>[];
    final wantedType = _selectedPaywallPlan == _PaywallPlan.annual
        ? PackageType.annual
        : PackageType.monthly;

    for (final package in packages) {
      if (package.packageType == wantedType) return package;
    }
    return packages.isEmpty ? null : packages.first;
  }

  Package? _packageOfType(_PaywallPlan plan) {
    final wantedType = plan == _PaywallPlan.annual
        ? PackageType.annual
        : PackageType.monthly;
    for (final package
        in _paywallOfferings?.current?.availablePackages ?? const <Package>[]) {
      if (package.packageType == wantedType) return package;
    }
    return null;
  }

  String _paywallPrice(_PaywallPlan plan, String fallback) =>
      _packageOfType(plan)?.storeProduct.priceString ?? fallback;

  String get _paywallCurrency =>
      _packageOfType(_PaywallPlan.annual)?.storeProduct.currencyCode ??
      _packageOfType(_PaywallPlan.monthly)?.storeProduct.currencyCode ??
      'USD';

  Future<void> _loadPaywallOfferings() async {
    if (_paywallOfferingsRequested) return;
    _paywallOfferingsRequested = true;
    final offerings = await RevenueCatService.instance.getOfferings();
    if (!mounted || offerings == null) return;
    setState(() => _paywallOfferings = offerings);
  }

  Future<void> _continueWithRitualPlus() async {
    if (_paywallActionInProgress || _restoreInProgress) return;
    HapticFeedback.mediumImpact();
    setState(() => _paywallActionInProgress = true);

    var success = false;
    try {
      final offerings =
          _paywallOfferings ?? await RevenueCatService.instance.getOfferings();
      if (offerings != null && mounted) {
        setState(() => _paywallOfferings = offerings);
      }
      final package = offerings == null ? null : _packageForPlan(offerings);
      if (package != null) {
        success = await RevenueCatService.instance.purchasePackage(package);
      } else {
        await RevenueCatService.instance.presentPaywall();
        success = await RevenueCatService.instance.checkProStatus();
      }
    } catch (error) {
      debugPrint('Onboarding paywall failed: $error');
    }

    if (!mounted) return;
    setState(() => _paywallActionInProgress = false);
    if (success) {
      _next();
      return;
    }
    _showPaywallMessage(
      'La compra no se completó. Puedes intentarlo de nuevo o seguir gratis.',
    );
  }

  Future<void> _restorePurchase() async {
    if (_paywallActionInProgress || _restoreInProgress) return;
    HapticFeedback.selectionClick();
    setState(() => _restoreInProgress = true);
    final success = await RevenueCatService.instance.restorePurchases();
    if (!mounted) return;
    setState(() => _restoreInProgress = false);
    if (success) {
      _next();
      return;
    }
    _showPaywallMessage('No encontramos una compra activa para restaurar.');
  }

  void _showPaywallMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message, style: GoogleFonts.manrope()),
          behavior: SnackBarBehavior.floating,
          backgroundColor: const Color(0xFF211B3B),
        ),
      );
  }

  void _selectPaywallPlan(_PaywallPlan plan) {
    HapticFeedback.selectionClick();
    setState(() => _selectedPaywallPlan = plan);
  }

  List<Widget> _choiceOverlays(String nodeId, Size size) {
    final horizontalInset = size.width * (24 / PencilSurface.canvasSize.width);
    switch (nodeId) {
      case 'tkH7u':
        return [
          Positioned(
            left: horizontalInset,
            right: horizontalInset,
            top: size.height * (379 / 956),
            height: size.height * (206 / 956),
            child: _MultiChoiceList(
              values: const [
                ('Calma y protección', Icons.shield_outlined),
                ('Bienestar y energía', Icons.spa_outlined),
                ('Prosperidad y trabajo', Icons.trending_up_rounded),
                ('Amor y propósito', Icons.favorite_border_rounded),
              ],
              selected: _needs,
              showPrimary: true,
              onToggle: _toggleIntention,
            ),
          ),
        ];
      case 'l5Vlq':
        return [
          Positioned(
            left: horizontalInset,
            right: horizontalInset,
            top: size.height * (398 / 956),
            height: size.height * (210 / 956),
            child: _MultiChoiceGrid(
              values: const [
                ('3 minutos', Icons.diamond_outlined),
                ('5 minutos', Icons.favorite_border),
                ('10 minutos', Icons.eco_outlined),
                ('15 minutos', Icons.card_giftcard_outlined),
              ],
              selected: _times,
              onToggle: (value) => _toggle(_times, value),
            ),
          ),
        ];
      case 'yBsgB':
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
      onPageChanged: (value) {
        setState(() => _page = value);
        if (_nodes[value] == 'IEgGc') {
          unawaited(_loadPaywallOfferings());
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_paywallScrollController.hasClients) {
              _paywallScrollController.jumpTo(0);
            }
          });
        }
      },
      itemBuilder: (context, index) {
        final nodeId = _nodes[index];

        if (nodeId == 'TTLH4') {
          return _VideoStoryPage(
            active: _page == index,
            onContinue: _next,
            videoAsset: 'assets/videos/onboarding_story_01.mp4',
            posterAsset: 'assets/images/onboarding_story_01_poster.png',
            copyTop: 369,
            copy: const _StoryOneCopy(),
            progress: const _StoryProgress(activeStep: 0, stepCount: 3),
            intentionOverlay: false,
            seamlessLoop: false,
          );
        }

        if (nodeId == 'CqnJW') {
          return _VideoStoryPage(
            active: _page == index,
            onContinue: _next,
            videoAsset: 'assets/videos/onboarding_story_05_intention.mp4',
            posterAsset:
                'assets/images/onboarding_story_05_intention_poster.png',
            copyTop: 369,
            copy: const _IntentionStoryCopy(),
            progress: const _StoryProgress(activeStep: 4, stepCount: 6),
            intentionOverlay: true,
            seamlessLoop: true,
          );
        }

        if (nodeId == 'IEgGc') {
          return _OnboardingPaywallPage(
            currencyCode: _paywallCurrency,
            scrollController: _paywallScrollController,
            monthlyPrice: _paywallPrice(_PaywallPlan.monthly, r'$9.99'),
            annualPrice: _paywallPrice(_PaywallPlan.annual, r'$79.00'),
            selectedPlan: _selectedPaywallPlan,
            purchasing: _paywallActionInProgress,
            restoring: _restoreInProgress,
            onSelectPlan: _selectPaywallPlan,
            onContinue: _continueWithRitualPlus,
            onContinueFree: _next,
            onClose: _next,
            onRestore: _restorePurchase,
            onTerms: () => context.push('/terms'),
            onPrivacy: () => context.push('/terms'),
          );
        }

        return PencilSurface(
          nodeId: nodeId,
          showNavigation: false,
          respectSafeArea: false,
          overlays: _choiceOverlays(nodeId, size),
          onTap: (point) {
            if (nodeId == 'wecjl' && point.dy > .84 && point.dy < .93) {
              context.push('/register');
              return;
            }
            // POST · Prueba activada → práctica lista → Home.
            if (nodeId == 'w4GjPh' && point.dy > .80 && point.dy < .90) {
              _next();
              return;
            }
            if (nodeId == 'D4A7Y' && point.dy > .87 && point.dy < .96) {
              _startPractice();
              return;
            }
            if (nodeId == '3fTTR' && point.dy > .78 && point.dy < .90) {
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

enum _PaywallPlan { monthly, annual }

class _OnboardingPaywallPage extends StatelessWidget {
  static const _background = Color(0xFF09080E);
  static const _surface = Color(0xFF151219);
  static const _surfaceSelected = Color(0xFF211627);
  static const _accent = Color(0xFFD58ACF);
  static const _text = Color(0xFFF7F2F7);
  static const _muted = Color(0xFFAAA3B0);

  final String currencyCode;
  final ScrollController scrollController;
  final String monthlyPrice;
  final String annualPrice;
  final _PaywallPlan selectedPlan;
  final bool purchasing;
  final bool restoring;
  final ValueChanged<_PaywallPlan> onSelectPlan;
  final VoidCallback onContinue;
  final VoidCallback onContinueFree;
  final VoidCallback onClose;
  final VoidCallback onRestore;
  final VoidCallback onTerms;
  final VoidCallback onPrivacy;

  const _OnboardingPaywallPage({
    required this.currencyCode,
    required this.scrollController,
    required this.monthlyPrice,
    required this.annualPrice,
    required this.selectedPlan,
    required this.purchasing,
    required this.restoring,
    required this.onSelectPlan,
    required this.onContinue,
    required this.onContinueFree,
    required this.onClose,
    required this.onRestore,
    required this.onTerms,
    required this.onPrivacy,
  });

  @override
  Widget build(BuildContext context) => AnnotatedRegion<SystemUiOverlayStyle>(
    value: SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
      systemStatusBarContrastEnforced: false,
      systemNavigationBarColor: _background,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: Colors.transparent,
      systemNavigationBarContrastEnforced: false,
    ),
    child: Scaffold(
      backgroundColor: _background,
      body: Column(
        children: [
          SizedBox(
            height: 190,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/images/bT1cU.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.center,
                  filterQuality: FilterQuality.high,
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xB8000000),
                        Color(0x52000000),
                        Colors.transparent,
                        _background,
                      ],
                      stops: [0, .23, .58, 1],
                    ),
                  ),
                ),
                SafeArea(
                  bottom: false,
                  minimum: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 38,
                          padding: const EdgeInsets.symmetric(horizontal: 13),
                          decoration: BoxDecoration(
                            color: const Color(0xCC6D477F),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(color: const Color(0x3DFFFFFF)),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.public_rounded,
                                size: 16,
                                color: _text,
                              ),
                              const SizedBox(width: 7),
                              Text(
                                'Internacional · $currencyCode',
                                style: GoogleFonts.manrope(
                                  color: _text,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Semantics(
                          button: true,
                          label: 'Cerrar y seguir gratis',
                          child: IconButton.filled(
                            key: const Key('paywall_close'),
                            onPressed: onClose,
                            style: IconButton.styleFrom(
                              backgroundColor: const Color(0xB3745483),
                              foregroundColor: _text,
                              minimumSize: const Size.square(44),
                            ),
                            icon: const Icon(Icons.close_rounded, size: 22),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              minimum: const EdgeInsets.only(bottom: 4),
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  controller: scrollController,
                  primary: false,
                  physics: const ClampingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 6),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight - 12,
                    ),
                    child: IntrinsicHeight(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _PaywallBadge(),
                          const SizedBox(height: 7),
                          Text(
                            'Más calma y claridad,\ntodos los días.',
                            style: GoogleFonts.manrope(
                              color: _text,
                              fontSize: 27,
                              height: 1.08,
                              fontWeight: FontWeight.w800,
                              letterSpacing: -.7,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Text(
                                '★★★★★',
                                style: TextStyle(color: _text, fontSize: 12),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Precio claro · renovación visible · cancela cuando quieras',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.manrope(
                                    color: _muted,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          _PaywallPlanCard(
                            key: const Key('paywall_plan_monthly'),
                            title: 'Mensual',
                            subtitle:
                                '$monthlyPrice al mes · cancela cuando quieras',
                            price: monthlyPrice,
                            period: '/mes',
                            selected: selectedPlan == _PaywallPlan.monthly,
                            onTap: () => onSelectPlan(_PaywallPlan.monthly),
                          ),
                          const SizedBox(height: 8),
                          _PaywallPlanCard(
                            key: const Key('paywall_plan_annual'),
                            title: 'Anual',
                            subtitle:
                                '$annualPrice al año · equivale a '
                                r'$6.58/mes',
                            price: annualPrice,
                            period: '/año',
                            recommended: true,
                            selected: selectedPlan == _PaywallPlan.annual,
                            onTap: () => onSelectPlan(_PaywallPlan.annual),
                          ),
                          const SizedBox(height: 10),
                          const _PaywallBenefits(),
                          const SizedBox(height: 9),
                          _PaywallInfoRow(
                            icon: Icons.notifications_none_rounded,
                            text:
                                'Después, $annualPrice/año. Te avisaremos antes de renovar.',
                          ),
                          const SizedBox(height: 5),
                          const _PaywallInfoRow(
                            icon: Icons.shield_outlined,
                            text: 'Sin permanencia · cancela cuando quieras',
                          ),
                          const Spacer(),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            height: 58,
                            child: FilledButton(
                              key: const Key('paywall_continue'),
                              onPressed: purchasing || restoring
                                  ? null
                                  : onContinue,
                              style: FilledButton.styleFrom(
                                backgroundColor: _text,
                                disabledBackgroundColor: const Color(
                                  0xFFB8B0BA,
                                ),
                                foregroundColor: const Color(0xFF17121A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                                textStyle: GoogleFonts.manrope(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              child: purchasing
                                  ? const SizedBox.square(
                                      dimension: 22,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.2,
                                        color: Color(0xFF17121A),
                                      ),
                                    )
                                  : const FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text('Continuar con Ritual+'),
                                          SizedBox(width: 10),
                                          Icon(
                                            Icons.arrow_forward_rounded,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 34,
                            child: TextButton(
                              key: const Key('paywall_continue_free'),
                              onPressed: purchasing || restoring
                                  ? null
                                  : onContinueFree,
                              style: TextButton.styleFrom(
                                foregroundColor: _muted,
                                textStyle: GoogleFonts.manrope(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: const Text(
                                'Seguir con la versión gratuita',
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 34,
                            child: Row(
                              children: [
                                Expanded(
                                  child: _PaywallLegalButton(
                                    key: const Key('paywall_terms'),
                                    label: 'Términos',
                                    onPressed: onTerms,
                                  ),
                                ),
                                Expanded(
                                  child: _PaywallLegalButton(
                                    key: const Key('paywall_privacy'),
                                    label: 'Privacidad',
                                    onPressed: onPrivacy,
                                  ),
                                ),
                                Expanded(
                                  child: _PaywallLegalButton(
                                    key: const Key('paywall_restore'),
                                    label: restoring
                                        ? 'Restaurando…'
                                        : 'Restaurar compra',
                                    onPressed: purchasing || restoring
                                        ? null
                                        : onRestore,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

class _PaywallBadge extends StatelessWidget {
  const _PaywallBadge();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    decoration: BoxDecoration(
      color: const Color(0xFF1B1820),
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: const Color(0xFF39343F)),
    ),
    child: Text(
      '✣  7 DÍAS CON RITUAL+',
      style: GoogleFonts.manrope(
        color: const Color(0xFFC6BDC9),
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.3,
      ),
    ),
  );
}

class _PaywallPlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String period;
  final bool selected;
  final bool recommended;
  final VoidCallback onTap;

  const _PaywallPlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.period,
    required this.selected,
    required this.onTap,
    this.recommended = false,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: selected,
    label: 'Plan $title, $price $period',
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          height: recommended ? 92 : 76,
          padding: const EdgeInsets.symmetric(horizontal: 14),
          decoration: BoxDecoration(
            color: selected
                ? _OnboardingPaywallPage._surfaceSelected
                : _OnboardingPaywallPage._surface,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: selected
                  ? _OnboardingPaywallPage._accent
                  : const Color(0xFF37323D),
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: selected
                      ? _OnboardingPaywallPage._accent
                      : Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? _OnboardingPaywallPage._accent
                        : const Color(0xFF625B6A),
                    width: 1.5,
                  ),
                ),
                child: selected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 15,
                        color: Colors.white,
                      )
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.manrope(
                            color: _OnboardingPaywallPage._text,
                            fontSize: 15,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        if (recommended) ...[
                          const SizedBox(width: 7),
                          Flexible(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 7,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFF8F4E91),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                'RECOMENDADO · AHORRA 34%',
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.manrope(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: .6,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 3),
                    Text(
                      subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.manrope(
                        color: _OnboardingPaywallPage._muted,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (recommended)
                    Text(
                      r'$119.88',
                      style: GoogleFonts.manrope(
                        color: _OnboardingPaywallPage._muted,
                        fontSize: 10,
                        decoration: TextDecoration.lineThrough,
                        decorationColor: _OnboardingPaywallPage._muted,
                      ),
                    ),
                  Text(
                    price,
                    style: GoogleFonts.manrope(
                      color: _OnboardingPaywallPage._text,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    period,
                    style: GoogleFonts.manrope(
                      color: _OnboardingPaywallPage._muted,
                      fontSize: 9,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class _PaywallBenefits extends StatelessWidget {
  const _PaywallBenefits();

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.fromLTRB(14, 12, 14, 10),
    decoration: BoxDecoration(
      color: _OnboardingPaywallPage._surface,
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: const Color(0xFF37323D)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TODO LO QUE INCLUYE RITUAL+',
          style: GoogleFonts.manrope(
            color: const Color(0xFFE8B8E2),
            fontSize: 9.5,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 7),
        const _PaywallBenefit(
          icon: Icons.headphones_rounded,
          label: 'Meditaciones guiadas para tu intención',
        ),
        const _PaywallBenefit(
          icon: Icons.auto_awesome_rounded,
          label: 'Rituales de manifestación personalizados',
        ),
        const _PaywallBenefit(
          icon: Icons.send_outlined,
          label: 'Peticiones al universo y seguimiento',
        ),
      ],
    ),
  );
}

class _PaywallBenefit extends StatelessWidget {
  final IconData icon;
  final String label;

  const _PaywallBenefit({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 23,
    child: Row(
      children: [
        Icon(icon, size: 16, color: _OnboardingPaywallPage._text),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: _OnboardingPaywallPage._text,
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

class _PaywallInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _PaywallInfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 20,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 14, color: _OnboardingPaywallPage._muted),
        const SizedBox(width: 7),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.manrope(
              color: _OnboardingPaywallPage._muted,
              fontSize: 9.5,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    ),
  );
}

class _PaywallLegalButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;

  const _PaywallLegalButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) => TextButton(
    onPressed: onPressed,
    style: TextButton.styleFrom(
      padding: EdgeInsets.zero,
      foregroundColor: _OnboardingPaywallPage._muted,
      textStyle: GoogleFonts.manrope(
        fontSize: 9.5,
        fontWeight: FontWeight.w600,
      ),
    ),
    child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis),
  );
}

class _VideoStoryPage extends StatefulWidget {
  final bool active;
  final VoidCallback onContinue;
  final String videoAsset;
  final String posterAsset;
  final double copyTop;
  final Widget copy;
  final Widget progress;
  final bool intentionOverlay;
  final bool seamlessLoop;

  const _VideoStoryPage({
    required this.active,
    required this.onContinue,
    required this.videoAsset,
    required this.posterAsset,
    required this.copyTop,
    required this.copy,
    required this.progress,
    required this.intentionOverlay,
    required this.seamlessLoop,
  });

  @override
  State<_VideoStoryPage> createState() => _VideoStoryPageState();
}

class _VideoStoryPageState extends State<_VideoStoryPage> {
  static const _crossfadeDuration = Duration(milliseconds: 850);

  late final List<VideoPlayerController> _videoControllers;
  Timer? _crossfadeTimer;
  int _activeVideo = 0;
  int _visibleVideo = 0;
  bool _seamlessReady = false;
  bool _transitioning = false;

  @override
  void initState() {
    super.initState();
    _videoControllers = List.generate(
      widget.seamlessLoop ? 2 : 1,
      (_) => VideoPlayerController.asset(widget.videoAsset),
    );
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      await _videoControllers.first.initialize();
      if (!mounted) return;
      await _videoControllers.first.setVolume(0);
      await _videoControllers.first.setLooping(!widget.seamlessLoop);
      _videoControllers.first.addListener(_monitorSeamlessLoop);
      if (mounted) setState(() {});
      if (widget.active) await _videoControllers.first.play();

      if (widget.seamlessLoop) {
        try {
          await _videoControllers.last.initialize();
          if (!mounted) return;
          await _videoControllers.last.setVolume(0);
          await _videoControllers.last.setLooping(false);
          _videoControllers.last.addListener(_monitorSeamlessLoop);
          _seamlessReady = true;
        } catch (error) {
          debugPrint('Secondary onboarding video failed: $error');
          try {
            await _videoControllers.first.setLooping(true);
          } catch (_) {
            // The poster remains available when playback is unsupported.
          }
        }
      }
    } catch (error) {
      debugPrint('Onboarding video failed: $error');
      // The poster remains visible if the platform cannot decode the video.
    }
  }

  void _monitorSeamlessLoop() {
    if (!mounted || !widget.active || !_seamlessReady || _transitioning) {
      return;
    }

    final value = _videoControllers[_activeVideo].value;
    if (!value.isInitialized ||
        !value.isPlaying ||
        value.duration == Duration.zero) {
      return;
    }

    final remaining = value.duration - value.position;
    if (remaining <= _crossfadeDuration && value.position > Duration.zero) {
      unawaited(_startCrossfade());
    }
  }

  Future<void> _startCrossfade() async {
    if (_transitioning || !widget.active) return;
    _transitioning = true;

    final outgoing = _activeVideo;
    final incoming = outgoing == 0 ? 1 : 0;
    final incomingController = _videoControllers[incoming];

    await incomingController.seekTo(Duration.zero);
    if (!mounted || !widget.active) {
      _transitioning = false;
      return;
    }
    await incomingController.play();
    if (!mounted) return;
    setState(() => _visibleVideo = incoming);

    _crossfadeTimer?.cancel();
    _crossfadeTimer = Timer(_crossfadeDuration, () {
      if (!mounted) return;
      _activeVideo = incoming;
      _transitioning = false;
      unawaited(_videoControllers[outgoing].pause());
      unawaited(_videoControllers[outgoing].seekTo(Duration.zero));
    });
  }

  @override
  void didUpdateWidget(covariant _VideoStoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.active == widget.active ||
        !_videoControllers.first.value.isInitialized) {
      return;
    }
    if (widget.active) {
      unawaited(_videoControllers[_activeVideo].play());
    } else {
      _crossfadeTimer?.cancel();
      for (final controller in _videoControllers) {
        unawaited(controller.pause());
      }
      _activeVideo = _visibleVideo;
      _transitioning = false;
    }
  }

  @override
  void dispose() {
    _crossfadeTimer?.cancel();
    for (final controller in _videoControllers) {
      controller.removeListener(_monitorSeamlessLoop);
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildVideo() {
    if (!_videoControllers.first.value.isInitialized) {
      return const SizedBox.shrink();
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        for (var index = 0; index < _videoControllers.length; index++)
          if (_videoControllers[index].value.isInitialized)
            AnimatedOpacity(
              opacity: index == _visibleVideo ? 1 : 0,
              duration: widget.seamlessLoop
                  ? _crossfadeDuration
                  : Duration.zero,
              curve: Curves.easeInOut,
              child: _CoverVideo(controller: _videoControllers[index]),
            ),
      ],
    );
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
                        widget.posterAsset,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                      _buildVideo(),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: widget.intentionOverlay
                                ? const [0, .38, .8, 1]
                                : const [0, .3, .62, 1],
                            colors: widget.intentionOverlay
                                ? const [
                                    Color(0x0009080E),
                                    Color(0x4209080E),
                                    Color(0xE809080E),
                                    Color(0xFF09080E),
                                  ]
                                : const [
                                    Color(0x12080711),
                                    Color(0x36080711),
                                    Color(0xB8080711),
                                    Color(0xF7080711),
                                  ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 27,
                        top: widget.copyTop,
                        width: 386,
                        child: widget.copy,
                      ),
                      Positioned(left: 18, top: 873, child: widget.progress),
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

class _StoryOneCopy extends StatelessWidget {
  const _StoryOneCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '01 · ESTO ES MANTRALIA',
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
          'Cinco minutos pueden cambiar el tono de tu día',
          style: GoogleFonts.notoSans(
            color: Colors.white,
            fontSize: 39,
            fontWeight: FontWeight.w600,
            height: 1.08,
            letterSpacing: -.5,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          'Un espacio para reconocer lo que sientes, convertir deseos en '
          'intenciones y acompañarlas con acciones concretas.',
          style: GoogleFonts.inter(
            color: const Color(0xFFDED8E2),
            fontSize: 16.5,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _IntentionStoryCopy extends StatelessWidget {
  const _IntentionStoryCopy();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '05 · DE LA INTENCIÓN A LA ACCIÓN',
          style: GoogleFonts.notoSans(
            color: const Color(0xFFDCD6E0),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.6,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Dale dirección a lo que deseas',
          style: GoogleFonts.notoSans(
            color: Colors.white,
            fontSize: 36,
            fontWeight: FontWeight.w700,
            height: 1.06,
            letterSpacing: -.5,
          ),
        ),
        const SizedBox(height: 14),
        Text(
          'Nombra cómo quieres sentirte y recibe una práctica para convertir '
          'esa intención en un paso posible hoy.',
          style: GoogleFonts.notoSans(
            color: const Color(0xFFDCD6E0),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _StoryProgress extends StatelessWidget {
  final int activeStep;
  final int stepCount;

  const _StoryProgress({required this.activeStep, required this.stepCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        stepCount,
        (index) => Padding(
          padding: EdgeInsets.only(right: index == stepCount - 1 ? 0 : 5),
          child: Container(
            width: index == activeStep ? 30 : 8,
            height: 5,
            decoration: BoxDecoration(
              color: index == activeStep
                  ? const Color(0xFFF5F2F7)
                  : const Color(0x55FFFFFF),
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
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
  final bool showPrimary;

  const _MultiChoiceList({
    required this.values,
    required this.selected,
    required this.onToggle,
    this.showPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final selectedOrder = selected.toList();
    return Column(
      children: values
          .map(
            (value) => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: _ChoiceCard(
                  label: value.$1,
                  active: selected.contains(value.$1),
                  badgeText: showPrimary && selectedOrder.indexOf(value.$1) == 0
                      ? 'P'
                      : null,
                  onTap: () => onToggle(value.$1),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
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
  final String? badgeText;
  final VoidCallback onTap;

  const _ChoiceCard({
    required this.label,
    required this.active,
    required this.onTap,
    this.compact = false,
    this.badgeText,
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
            child: badgeText == null
                ? Icon(
                    Icons.check_rounded,
                    size: compact ? 12 : 14,
                    color: const Color(0xFF09080D),
                  )
                : Center(
                    child: Text(
                      badgeText!,
                      style: const TextStyle(
                        color: Color(0xFF09080D),
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
          ),
        ),
      ),
    ),
  );
}
