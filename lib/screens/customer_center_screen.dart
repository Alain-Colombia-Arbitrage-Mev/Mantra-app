import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../services/revenuecat_service.dart';
import '../utils/responsive.dart';

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
        padding: EdgeInsets.fromLTRB(Responsive.w(24), Responsive.h(20), Responsive.w(24), Responsive.h(40)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cancelar suscripción',
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(20),
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
            SizedBox(height: Responsive.h(12)),
            Text(
              'Para cancelar tu suscripción, visita la tienda donde realizaste la compra:\n\n'
              '• Android: Google Play → Suscripciones\n'
              '• iOS: App Store → Tu nombre → Suscripciones\n\n'
              'Tu acceso Pro continuará hasta el final del período facturado.',
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(14),
                height: 1.6,
                color: AppColors.textTertiary,
              ),
            ),
            SizedBox(height: Responsive.h(20)),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: Responsive.h(14)),
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColors.surfaceBorderLight),
                ),
                child: Text(
                  'Entendido',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(15),
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
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: Column(
            children: [
              // ── Header ────────────────────────────────────────────────
              Padding(
                padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(16), Responsive.w(20), 0),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: Responsive.w(36),
                        height: Responsive.w(36),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.surfaceBorderLight),
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
                        'Mi Suscripción',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(17),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _loading ? null : _loadInfo,
                      child: Container(
                        width: Responsive.w(36),
                        height: Responsive.w(36),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.surfaceBorderLight),
                        ),
                        child: Icon(
                          LucideIcons.refreshCw,
                          color: Colors.white,
                          size: Responsive.w(16),
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
                        padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(24), Responsive.w(20), Responsive.h(40)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // ── Status card ───────────────────────────────
                            _StatusCard(isPro: _isPro),
                            SizedBox(height: Responsive.h(20)),

                            // ── Customer info card ────────────────────────
                            if (_info != null) ...[
                              _InfoCard(info: _info!, formatDate: _formatDate),
                              SizedBox(height: Responsive.h(20)),
                            ],

                            // ── Subscription details ──────────────────────
                            if (_proEntitlement != null) ...[
                              _DetailsCard(
                                entitlement: _proEntitlement!,
                                formatDate: _formatDate,
                              ),
                              SizedBox(height: Responsive.h(20)),
                            ],

                            // ── Section label ─────────────────────────────
                            SectionLabel('ACCIONES'),
                            SizedBox(height: Responsive.h(10)),

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
      padding: EdgeInsets.all(Responsive.w(20)),
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
                  blurRadius: Responsive.w(24),
                  offset: Offset(0, Responsive.h(8)),
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          Container(
            width: Responsive.w(48),
            height: Responsive.w(48),
            decoration: BoxDecoration(
              color: isPro
                  ? AppColors.primary.withValues(alpha: 0.25)
                  : AppColors.white.withValues(alpha: 0.08),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPro ? LucideIcons.crown : LucideIcons.lock,
              color: isPro ? AppColors.primaryLight : AppColors.textTertiary,
              size: Responsive.w(22),
            ),
          ),
          SizedBox(width: Responsive.w(16)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isPro ? 'Plan Pro Activo' : 'Plan Gratuito',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(18),
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: Responsive.h(2)),
              Text(
                isPro
                    ? 'Acceso completo a todas las funciones'
                    : 'Actualiza para desbloquear todo',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(13),
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
      padding: EdgeInsets.all(Responsive.w(20)),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel('INFORMACIÓN DE LA CUENTA'),
          SizedBox(height: Responsive.h(12)),
          _InfoRow(
            label: 'ID de usuario',
            value: info.originalAppUserId,
            canCopy: true,
          ),
          SizedBox(height: Responsive.h(10)),
          _InfoRow(
            label: 'Primera compra',
            value: formatDate(info.firstSeen),
          ),
          SizedBox(height: Responsive.h(10)),
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
              fontSize: Responsive.sp(12),
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
                fontSize: Responsive.sp(13),
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
      padding: EdgeInsets.all(Responsive.w(20)),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionLabel('ESTADO DE LA SUSCRIPCIÓN'),
          SizedBox(height: Responsive.h(12)),
          _InfoRow(
            label: 'Plan actual',
            value: entitlement.productIdentifier,
          ),
          SizedBox(height: Responsive.h(10)),
          _InfoRow(
            label: 'Estado',
            value: entitlement.isActive ? 'Activo' : 'Inactivo',
          ),
          SizedBox(height: Responsive.h(10)),
          _InfoRow(
            label: 'Renovación automática',
            value: entitlement.willRenew ? 'Activada' : 'Desactivada',
          ),
          SizedBox(height: Responsive.h(10)),
          _InfoRow(
            label: 'Vence el',
            value: formatDate(entitlement.expirationDate),
          ),
          SizedBox(height: Responsive.h(10)),
          _InfoRow(
            label: 'Activo desde',
            value: formatDate(entitlement.latestPurchaseDate),
          ),
          if (entitlement.store != Store.unknownStore) ...[
            SizedBox(height: Responsive.h(10)),
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
        padding: EdgeInsets.symmetric(horizontal: Responsive.w(16), vertical: Responsive.h(14)),
        child: Row(
          children: [
            Container(
              width: Responsive.w(38),
              height: Responsive.w(38),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.18),
                shape: BoxShape.circle,
              ),
              child: loading
                  ? SizedBox(
                      width: Responsive.w(18),
                      height: Responsive.w(18),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: iconColor,
                      ),
                    )
                  : Icon(icon, color: iconColor, size: Responsive.w(18)),
            ),
            SizedBox(width: Responsive.w(14)),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(15),
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              color: AppColors.textTertiary,
              size: Responsive.w(18),
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
      margin: EdgeInsets.only(left: Responsive.w(68)),
      color: AppColors.white.withValues(alpha: 0.07),
    );
  }
}
