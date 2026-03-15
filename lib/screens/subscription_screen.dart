import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../theme.dart';
import '../services/revenuecat_service.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  static const List<String> _benefits = [
    '7 días de prueba gratis',
    'Acceso a la librería completa',
    '300+ paisajes sonoros',
    '80+ meditaciones guiadas',
    '20+ sonidos para dormir',
    'Mezcla tus propios sonidos',
    'Sin anuncios, sin estrés',
  ];

  Offerings? _offerings;
  bool _loading = true;
  String? _error;
  Package? _selectedPackage;
  bool _purchasing = false;

  @override
  void initState() {
    super.initState();
    _loadOfferings();
  }

  Future<void> _loadOfferings() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    final offerings = await RevenueCatService.instance.getOfferings();
    if (!mounted) return;
    if (offerings == null) {
      setState(() {
        _loading = false;
        _error = 'No se pudieron cargar los planes. Intenta de nuevo.';
      });
      return;
    }
    final packages = offerings.current?.availablePackages ?? [];
    // Default selection: prefer annual, then monthly, then first available.
    Package? defaultPkg;
    for (final pkg in packages) {
      if (pkg.packageType == PackageType.annual) {
        defaultPkg = pkg;
        break;
      }
    }
    defaultPkg ??= packages.isNotEmpty ? packages.first : null;

    setState(() {
      _offerings = offerings;
      _selectedPackage = defaultPkg;
      _loading = false;
    });
  }

  Future<void> _purchase() async {
    if (_selectedPackage == null || _purchasing) return;
    setState(() => _purchasing = true);
    final success =
        await RevenueCatService.instance.purchasePackage(_selectedPackage!);
    if (!mounted) return;
    setState(() => _purchasing = false);
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '¡Bienvenido a Plan Pro!',
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppColors.primary,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      if (mounted) context.pop();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Compra no completada.',
            style: GoogleFonts.urbanist(fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppColors.danger,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Future<void> _restore() async {
    setState(() => _purchasing = true);
    final success = await RevenueCatService.instance.restorePurchases();
    if (!mounted) return;
    setState(() => _purchasing = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          success ? 'Compras restauradas exitosamente.' : 'No se encontraron compras anteriores.',
          style: GoogleFonts.urbanist(fontWeight: FontWeight.w600),
        ),
        backgroundColor: success ? AppColors.primary : AppColors.textTertiary,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
    if (success && mounted) context.pop();
  }

  Future<void> _showNativePaywall() async {
    await RevenueCatService.instance.presentPaywall();
    if (mounted) setState(() {});
  }

  String _periodLabel(PackageType type) {
    switch (type) {
      case PackageType.weekly:
        return 'Semanal';
      case PackageType.monthly:
        return 'Mensual';
      case PackageType.twoMonth:
        return '2 Meses';
      case PackageType.threeMonth:
        return '3 Meses';
      case PackageType.sixMonth:
        return '6 Meses';
      case PackageType.annual:
        return 'Anual';
      case PackageType.lifetime:
        return 'De por vida';
      default:
        return 'Plan';
    }
  }

  String? _perWeekNote(Package pkg) {
    final price = pkg.storeProduct.price;
    switch (pkg.packageType) {
      case PackageType.annual:
        final perWeek = price / 52;
        return '${pkg.storeProduct.currencyCode} ${perWeek.toStringAsFixed(2)}/sem';
      case PackageType.monthly:
        final perWeek = price / 4.33;
        return '${pkg.storeProduct.currencyCode} ${perWeek.toStringAsFixed(2)}/sem';
      case PackageType.weekly:
        return null;
      default:
        return null;
    }
  }

  bool _isRecommended(Package pkg) =>
      pkg.packageType == PackageType.annual;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F0A2A), Color(0xFF0A0A1A)],
          ),
        ),
        child: Stack(
          children: [
            // Purple glow top-right
            Positioned(
              top: -80,
              right: -60,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 160,
                      spreadRadius: 80,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // ── Header ───────────────────────────────────────────────
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
                            'Suscripción',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/home'),
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
                              LucideIcons.x,
                              color: Colors.white,
                              size: 18,
                            ),
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
                          // ── PRO badge ────────────────────────────────────
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppGradients.primaryButton,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.45,
                                  ),
                                  blurRadius: 20,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Text(
                              'PLAN PRO',
                              style: GoogleFonts.urbanist(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ── Headline ──────────────────────────────────────
                          Text(
                            'Desbloquea la\nexperiencia completa',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 28),

                          // ── Benefits list ─────────────────────────────────
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.surfaceBorderLight,
                              ),
                            ),
                            child: Column(
                              children: _benefits.map((b) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          color: AppColors.mint.withValues(
                                            alpha: 0.2,
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.mint.withValues(
                                              alpha: 0.4,
                                            ),
                                          ),
                                        ),
                                        child: Icon(
                                          LucideIcons.check,
                                          color: AppColors.mint,
                                          size: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        b,
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // ── Plan cards (loading / error / packages) ───────
                          _buildPackagesSection(),
                          const SizedBox(height: 28),

                          // ── CTA ───────────────────────────────────────────
                          GestureDetector(
                            onTap: _purchasing ? null : _purchase,
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              width: double.infinity,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: _purchasing || _selectedPackage == null
                                    ? null
                                    : AppGradients.primaryButton,
                                color: _purchasing || _selectedPackage == null
                                    ? AppColors.white.withValues(alpha: 0.12)
                                    : null,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: _purchasing || _selectedPackage == null
                                    ? null
                                    : [
                                        BoxShadow(
                                          color: AppColors.primary.withValues(
                                            alpha: 0.45,
                                          ),
                                          blurRadius: 24,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                              ),
                              child: Center(
                                child: _purchasing
                                    ? const SizedBox(
                                        width: 22,
                                        height: 22,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2.5,
                                          color: Colors.white,
                                        ),
                                      )
                                    : Text(
                                        'Comenzar prueba gratis',
                                        style: GoogleFonts.urbanist(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // ── Restore purchases ─────────────────────────────
                          GestureDetector(
                            onTap: _purchasing ? null : _restore,
                            child: Text(
                              'Restaurar compras',
                              style: GoogleFonts.urbanist(
                                fontSize: 13,
                                color: AppColors.white.withValues(alpha: 0.55),
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.white.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // ── Native paywall link ───────────────────────────
                          GestureDetector(
                            onTap: _showNativePaywall,
                            child: Text(
                              'Ver paywall nativo',
                              style: GoogleFonts.urbanist(
                                fontSize: 13,
                                color: AppColors.primaryLight.withValues(
                                  alpha: 0.7,
                                ),
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primaryLight.withValues(
                                  alpha: 0.4,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),

                          // ── Legal ─────────────────────────────────────────
                          GestureDetector(
                            onTap: () => context.push('/terms'),
                            child: Text(
                              'Política de privacidad y Términos de uso',
                              style: GoogleFonts.urbanist(
                                fontSize: 12,
                                color: AppColors.white.withValues(alpha: 0.4),
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.white.withValues(
                                  alpha: 0.25,
                                ),
                              ),
                            ),
                          ),
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

  Widget _buildPackagesSection() {
    if (_loading) {
      return Container(
        height: 100,
        alignment: Alignment.center,
        child: const CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2.5,
        ),
      );
    }

    if (_error != null) {
      return Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.danger.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.danger.withValues(alpha: 0.25)),
        ),
        child: Column(
          children: [
            Text(
              _error!,
              textAlign: TextAlign.center,
              style: GoogleFonts.urbanist(
                fontSize: 14,
                color: AppColors.danger,
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: _loadOfferings,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.4),
                  ),
                ),
                child: Text(
                  'Reintentar',
                  style: GoogleFonts.urbanist(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryLight,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    final packages = _offerings?.current?.availablePackages ?? [];
    if (packages.isEmpty) {
      return Text(
        'No hay planes disponibles en este momento.',
        textAlign: TextAlign.center,
        style: GoogleFonts.urbanist(
          fontSize: 14,
          color: AppColors.textTertiary,
        ),
      );
    }

    return Column(
      children: packages.map((pkg) => _PackageCard(
        package: pkg,
        isSelected: _selectedPackage?.identifier == pkg.identifier,
        isRecommended: _isRecommended(pkg),
        periodLabel: _periodLabel(pkg.packageType),
        perWeekNote: _perWeekNote(pkg),
        onTap: () => setState(() => _selectedPackage = pkg),
      )).toList(),
    );
  }
}

class _PackageCard extends StatelessWidget {
  final Package package;
  final bool isSelected;
  final bool isRecommended;
  final String periodLabel;
  final String? perWeekNote;
  final VoidCallback onTap;

  const _PackageCard({
    required this.package,
    required this.isSelected,
    required this.isRecommended,
    required this.periodLabel,
    required this.perWeekNote,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.15)
              : AppColors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.surfaceBorderLight,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Selection indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? AppColors.primary : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.textTertiary,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, color: Colors.white, size: 12)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        periodLabel,
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      if (isRecommended) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            gradient: AppGradients.primaryButton,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Text(
                            'Recomendado',
                            style: GoogleFonts.urbanist(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (perWeekNote != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      perWeekNote!,
                      style: GoogleFonts.urbanist(
                        fontSize: 12,
                        color: AppColors.textTertiary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(
              package.storeProduct.priceString,
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w800,
                color: isSelected ? AppColors.primaryLight : Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
