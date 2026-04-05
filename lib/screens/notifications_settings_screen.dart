import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

class NotificationsSettingsScreen extends StatefulWidget {
  const NotificationsSettingsScreen({super.key});

  @override
  State<NotificationsSettingsScreen> createState() =>
      _NotificationsSettingsScreenState();
}

class _NotificationsSettingsScreenState
    extends State<NotificationsSettingsScreen> {
  bool _mirrorAlerts = true;
  bool _mirrorMessage = true;
  bool _planetaryAlerts = true;
  bool _sessionReminder = true;
  bool _dailyRitual = false;
  bool _bioHackAlerts = true;

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(40)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────────
              _Header(),
              SizedBox(height: Responsive.h(6)),
              Text(
                'Configura cuándo y cómo te alertamos',
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(14),
                  color: const Color(0x80FFFFFF),
                ),
              ),
              SizedBox(height: Responsive.h(28)),

              // ── Horas Espejo ──────────────────────────────────────────
              const SectionLabel('HORAS ESPEJO'),
              SizedBox(height: Responsive.h(12)),
              _ToggleRow(
                title: 'Horas Espejo · Alertas',
                subtitle: '11:11 · 22:22 · 00:50 y más',
                value: _mirrorAlerts,
                onChanged: (v) => setState(() => _mirrorAlerts = v),
              ),
              SizedBox(height: Responsive.h(10)),
              _ToggleRow(
                title: 'Mensaje de la Hora',
                subtitle: 'Recibe interpretación kabalística',
                value: _mirrorMessage,
                onChanged: (v) => setState(() => _mirrorMessage = v),
              ),
              SizedBox(height: Responsive.h(24)),

              // ── Horas Planetarias ─────────────────────────────────────
              const SectionLabel('HORAS PLANETARIAS'),
              SizedBox(height: Responsive.h(12)),
              _ToggleRow(
                title: 'Alertas Planetarias',
                subtitle: 'Inicio de hora Júpiter, Venus, Luna...',
                value: _planetaryAlerts,
                onChanged: (v) => setState(() => _planetaryAlerts = v),
              ),
              SizedBox(height: Responsive.h(24)),

              // ── Sesiones & Rituales ───────────────────────────────────
              const SectionLabel('SESIONES & RITUALES'),
              SizedBox(height: Responsive.h(12)),
              _ToggleRow(
                title: 'Recordatorio de Sesión',
                subtitle: '30 min antes de cada sesión reservada',
                value: _sessionReminder,
                onChanged: (v) => setState(() => _sessionReminder = v),
              ),
              SizedBox(height: Responsive.h(10)),
              _ToggleRow(
                title: 'Ritual Diario · Recordatorio',
                subtitle: 'Tu intención de mañana te espera',
                value: _dailyRitual,
                onChanged: (v) => setState(() => _dailyRitual = v),
              ),
              SizedBox(height: Responsive.h(10)),
              _ToggleRow(
                title: 'Bio-Hack Alerts',
                subtitle: 'Nuevas sesiones · Guías · Actualizaciones',
                value: _bioHackAlerts,
                onChanged: (v) => setState(() => _bioHackAlerts = v),
              ),
              SizedBox(height: Responsive.h(36)),

              // ── CTA ───────────────────────────────────────────────────
              GestureDetector(
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: Responsive.h(16)),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryButton,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: Responsive.w(20),
                        offset: Offset(0, Responsive.h(8)),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.check,
                        color: Colors.white,
                        size: Responsive.w(18),
                      ),
                      SizedBox(width: Responsive.w(10)),
                      Text(
                        'Guardar Preferencias',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(16),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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

class _Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            if (Navigator.of(context).canPop()) {
              Navigator.of(context).pop();
            }
          },
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
            'Notificaciones',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: Responsive.sp(17),
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: Responsive.w(36),
          height: Responsive.w(36),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surfaceBorderLight),
          ),
          child: Icon(
            LucideIcons.bell,
            color: Colors.white,
            size: Responsive.w(18),
          ),
        ),
      ],
    );
  }
}

class _ToggleRow extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _ToggleRow({
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: Responsive.w(16), vertical: Responsive.h(14)),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(15),
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Responsive.h(2)),
                Text(
                  subtitle,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(12),
                    color: const Color(0x60FFFFFF),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: AppColors.textTertiary,
            inactiveTrackColor: AppColors.white.withValues(alpha: 0.08),
          ),
        ],
      ),
    );
  }
}
