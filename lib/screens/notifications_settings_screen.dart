import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

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
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A1A),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header ────────────────────────────────────────────────
              _Header(),
              const SizedBox(height: 6),
              Text(
                'Configura cuándo y cómo te alertamos',
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  color: const Color(0x80FFFFFF),
                ),
              ),
              const SizedBox(height: 28),

              // ── Horas Espejo ──────────────────────────────────────────
              const SectionLabel('HORAS ESPEJO'),
              const SizedBox(height: 12),
              _ToggleRow(
                title: 'Horas Espejo · Alertas',
                subtitle: '11:11 · 22:22 · 00:50 y más',
                value: _mirrorAlerts,
                onChanged: (v) => setState(() => _mirrorAlerts = v),
              ),
              const SizedBox(height: 10),
              _ToggleRow(
                title: 'Mensaje de la Hora',
                subtitle: 'Recibe interpretación kabalística',
                value: _mirrorMessage,
                onChanged: (v) => setState(() => _mirrorMessage = v),
              ),
              const SizedBox(height: 24),

              // ── Horas Planetarias ─────────────────────────────────────
              const SectionLabel('HORAS PLANETARIAS'),
              const SizedBox(height: 12),
              _ToggleRow(
                title: 'Alertas Planetarias',
                subtitle: 'Inicio de hora Júpiter, Venus, Luna...',
                value: _planetaryAlerts,
                onChanged: (v) => setState(() => _planetaryAlerts = v),
              ),
              const SizedBox(height: 24),

              // ── Sesiones & Rituales ───────────────────────────────────
              const SectionLabel('SESIONES & RITUALES'),
              const SizedBox(height: 12),
              _ToggleRow(
                title: 'Recordatorio de Sesión',
                subtitle: '30 min antes de cada sesión reservada',
                value: _sessionReminder,
                onChanged: (v) => setState(() => _sessionReminder = v),
              ),
              const SizedBox(height: 10),
              _ToggleRow(
                title: 'Ritual Diario · Recordatorio',
                subtitle: 'Tu intención de mañana te espera',
                value: _dailyRitual,
                onChanged: (v) => setState(() => _dailyRitual = v),
              ),
              const SizedBox(height: 10),
              _ToggleRow(
                title: 'Bio-Hack Alerts',
                subtitle: 'Nuevas sesiones · Guías · Actualizaciones',
                value: _bioHackAlerts,
                onChanged: (v) => setState(() => _bioHackAlerts = v),
              ),
              const SizedBox(height: 36),

              // ── CTA ───────────────────────────────────────────────────
              GestureDetector(
                onTap: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  }
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryButton,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        LucideIcons.check,
                        color: Colors.white,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Guardar Preferencias',
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
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
        const Expanded(
          child: Text(
            'Notificaciones',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 17,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surfaceBorderLight),
          ),
          child: const Icon(
            LucideIcons.bell,
            color: Colors.white,
            size: 18,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
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
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
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
