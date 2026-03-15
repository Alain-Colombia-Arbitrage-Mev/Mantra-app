import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../services/revenuecat_service.dart';

class CustomerCenterScreen extends StatefulWidget {
  const CustomerCenterScreen({super.key});

  @override
  State<CustomerCenterScreen> createState() => _CustomerCenterScreenState();
}

class _CustomerCenterScreenState extends State<CustomerCenterScreen> {
  CustomerInfo? _info;
  bool _loading = true;
  bool _actionLoading = false;

  @override
  void initState() {
    super.initState();
    _loadInfo();
  }

  Future<void> _loadInfo() async {
    setState(() => _loading = true);
    try {
      final info = await Purchases.getCustomerInfo();
      if (!mounted) return;
      setState(() {
        _info = info;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
    }
  }

  Future<void> _restore() async {
    setState(() => _actionLoading = true);
    final success = await RevenueCatService.instance.restorePurchases();
    if (!mounted) return;
    setState(() => _actionLoading = false);
    _showSnack(
      success ? 'Compras restauradas exitosamente.' : 'No se encontraron compras anteriores.',
      success ? AppColors.primary : AppColors.textTertiary,
    );
    if (success) await _loadInfo();
  }

  Future<void> _changeplan() async {
    await RevenueCatService.instance.presentPaywall();
    if (mounted) await _loadInfo();
  }

  void _showCancelInfo() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1530),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cancelar suscripción',
              style: GoogleFonts.urbanist(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Para cancelar tu suscripción, visita la tienda donde realizaste la compra:\n\n'
              '• Android: Google Play → Suscripciones\n'
              '• iOS: App Store → Tu nombre → Suscripciones\n\n'
              'Tu acceso Pro continuará hasta el final del período facturado.',
              style: GoogleFonts.urbanist(
                fontSize: 14,
                height: 1.6,
                color: AppColors.textTertiary,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.surfaceBorderLight),
                ),
                child: Text(
                  'Entendido',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnack(String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg, style: GoogleFonts.urbanist(fontWeight: FontWeight.w600)),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  bool get _isPro => RevenueCatService.instance.isPro;

  String _formatDate(String? isoDate) {
    if (isoDate == null) return '—';
    try {
      final dt = DateTime.parse(isoDate).toLocal();
      const months = [
        'ene', 'feb', 'mar', 'abr', 'may', 'jun',
        'jul', 'ago', 'sep', 'oct', 'nov', 'dic',
      ];
      return '${dt.day} ${months[dt.month - 1]} ${dt.year}';
    } catch (_) {
      return isoDate;
    }
  }

  EntitlementInfo? get _proEntitlement =>
      _info?.entitlements.all[RevenueCatService.entitlementId];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // ── Header ────────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.surfaceBorderLight),
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
                        'Mi Suscripción',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    // Refresh button
                    GestureDetector(
                      onTap: _loading ? null : _loadInfo,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.surfaceBorderLight),
                        ),
                        child: const Icon(
                          LucideIcons.refreshCw,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: _loading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                          strokeWidth: 2.5,
                        ),
                      )
                    : SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 24, 20, 40),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Status card ───────────────────────────────
                            _StatusCard(isPro: _isPro),
                            const SizedBox(height: 20),

                            // ── Customer info card ────────────────────────
                            if (_info != null) ...[
                              _InfoCard(info: _info!, formatDate: _formatDate),
                              const SizedBox(height: 20),
                            ],

                            // ── Subscription details ──────────────────────
                            if (_proEntitlement != null) ...[
                              _DetailsCard(
                                entitlement: _proEntitlement!,
                                formatDate: _formatDate,
                              ),
                              const SizedBox(height: 20),
                            ],

                            // ── Section label ─────────────────────────────
                            SectionLabel('ACCIONES'),
                            const SizedBox(height: 10),

                            // ── Action buttons ────────────────────────────
                            Container(
                              decoration: BoxDecoration(
                                color: AppColors.surfaceLight,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: AppColors.surfaceBorderLight,
                                ),
                              ),
                              child: Column(
                                children: [
                                  _ActionRow(
                                    icon: LucideIcons.crown,
                                    iconColor: AppColors.primary,
                                    label: 'Cambiar plan',
                                    onTap: _actionLoading ? null : _changeplan,
                                  ),
                                  _RowDivider(),
                                  _ActionRow(
                                    icon: LucideIcons.refreshCw,
                                    iconColor: AppColors.mint,
                                    label: 'Restaurar compras',
                                    onTap: _actionLoading ? null : _restore,
                                    loading: _actionLoading,
                                  ),
                                  _RowDivider(),
                                  _ActionRow(
                                    icon: LucideIcons.xCircle,
                                    iconColor: AppColors.danger,
                                    label: 'Cancelar suscripción',
                                    onTap: _showCancelInfo,
                                  ),
                                ],
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
    );
  }
}

// ── Sub-widgets ────────────────────────────────────────────────────────────────

class _StatusCard extends StatelessWidget {
  final bool isPro;
  const _StatusCard({required this.isPro});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: isPro
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1E1440), Color(0xFF2A1F5C)],
              )
            : null,
        color: isPro ? null : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPro
              ? AppColors.primary.withValues(alpha: 0.5)
              : AppColors.surfaceBorderLight,
          width: isPro ? 1.5 : 1,
        ),
        boxShadow: isPro
            ? [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: isPro
                  ? AppColors.primary.withValues(alpha: 0.25)
                  : AppColors.white.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPro ? LucideIcons.crown : LucideIcons.lock,
              color: isPro ? AppColors.primaryLight : AppColors.textTertiary,
              size: 22,
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPro ? 'Plan Pro Activo' : 'Plan Gratuito',
                style: GoogleFonts.urbanist(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                isPro
                    ? 'Acceso completo a todas las funciones'
                    : 'Actualiza para desbloquear todo',
                style: GoogleFonts.urbanist(
                  fontSize: 13,
                  color: AppColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final CustomerInfo info;
  final String Function(String?) formatDate;

  const _InfoCard({required this.info, required this.formatDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel('INFORMACIÓN DE LA CUENTA'),
          const SizedBox(height: 12),
          _InfoRow(
            label: 'ID de usuario',
            value: info.originalAppUserId,
            canCopy: true,
          ),
          const SizedBox(height: 10),
          _InfoRow(
            label: 'Primera compra',
            value: formatDate(info.firstSeen),
          ),
          const SizedBox(height: 10),
          _InfoRow(
            label: 'Última actualización',
            value: formatDate(info.requestDate),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final bool canCopy;

  const _InfoRow({
    required this.label,
    required this.value,
    this.canCopy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: GoogleFonts.urbanist(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textTertiary,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: GestureDetector(
            onLongPress: canCopy
                ? () {
                    Clipboard.setData(ClipboardData(text: value));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Copiado al portapapeles',
                          style: GoogleFonts.urbanist(),
                        ),
                        duration: const Duration(seconds: 1),
                        backgroundColor: AppColors.primary,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  }
                : null,
            child: Text(
              value,
              style: GoogleFonts.urbanist(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ),
      ],
    );
  }
}

class _DetailsCard extends StatelessWidget {
  final EntitlementInfo entitlement;
  final String Function(String?) formatDate;

  const _DetailsCard({
    required this.entitlement,
    required this.formatDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel('ESTADO DE LA SUSCRIPCIÓN'),
          const SizedBox(height: 12),
          _InfoRow(
            label: 'Plan actual',
            value: entitlement.productIdentifier,
          ),
          const SizedBox(height: 10),
          _InfoRow(
            label: 'Estado',
            value: entitlement.isActive ? 'Activo' : 'Inactivo',
          ),
          const SizedBox(height: 10),
          _InfoRow(
            label: 'Renovación automática',
            value: entitlement.willRenew ? 'Activada' : 'Desactivada',
          ),
          const SizedBox(height: 10),
          _InfoRow(
            label: 'Vence el',
            value: formatDate(entitlement.expirationDate),
          ),
          const SizedBox(height: 10),
          _InfoRow(
            label: 'Activo desde',
            value: formatDate(entitlement.latestPurchaseDate),
          ),
          if (entitlement.store != Store.unknownStore) ...[
            const SizedBox(height: 10),
            _InfoRow(
              label: 'Tienda',
              value: _storeName(entitlement.store),
            ),
          ],
        ],
      ),
    );
  }

  String _storeName(Store store) {
    switch (store) {
      case Store.appStore:
        return 'App Store (iOS)';
      case Store.playStore:
        return 'Google Play (Android)';
      case Store.stripe:
        return 'Stripe';
      case Store.promotional:
        return 'Promocional';
      default:
        return 'Desconocida';
    }
  }
}

class _ActionRow extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final VoidCallback? onTap;
  final bool loading;

  const _ActionRow({
    required this.icon,
    required this.iconColor,
    required this.label,
    this.onTap,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: loading
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: iconColor,
                      ),
                    )
                  : Icon(icon, color: iconColor, size: 18),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.urbanist(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(
              LucideIcons.chevronRight,
              color: AppColors.textTertiary,
              size: 18,
            ),
          ],
        ),
      ),
    );
  }
}

class _RowDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 68),
      color: AppColors.white.withValues(alpha: 0.07),
    );
  }
}
