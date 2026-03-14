import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class MirrorHoursScreen extends StatefulWidget {
  const MirrorHoursScreen({super.key});

  @override
  State<MirrorHoursScreen> createState() => _MirrorHoursScreenState();
}

class _MirrorHoursScreenState extends State<MirrorHoursScreen> {
  final List<bool> _active = [true, true, true, true, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      extendBody: true,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Nav ───────────────────────────────────────────────
                ScreenNav(
                  title: 'Horas Espejo',
                  showBack: true,
                  trailing: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surfaceBorderLight),
                    ),
                    child: const Icon(
                      LucideIcons.info,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'El universo te habla a través del tiempo',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                    fontSize: 13,
                    color: AppColors.textTertiary,
                  ),
                ),
                const SizedBox(height: 24),

                // ── Next mirror hour label ────────────────────────────
                const SectionLabel('PRÓXIMA HORA ESPEJO'),
                const SizedBox(height: 12),

                // ── Featured 11:11 card ───────────────────────────────
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24, vertical: 28,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryButton,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '11:11',
                        style: GoogleFonts.urbanist(
                          fontSize: 56,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Puerta de manifestación abierta',
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'en 2h 34min',
                        style: GoogleFonts.urbanist(
                          fontSize: 13,
                          color: AppColors.white.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // ── All hours label ───────────────────────────────────
                const SectionLabel('TODAS LAS HORAS ESPEJO'),
                const SizedBox(height: 12),

                _MirrorCard(
                  time: '11:11',
                  meaning: 'Puerta de manifestación · Pide un deseo',
                  voiceInfo: 'Voz Serena · Afirmación de poder',
                  active: _active[0],
                  highlighted: false,
                  onChanged: (v) => setState(() => _active[0] = v),
                ),
                const SizedBox(height: 10),
                _MirrorCard(
                  time: '12:12',
                  meaning: 'Renovación y nuevos comienzos',
                  voiceInfo: 'Voz Mi Voz · Código 520',
                  active: _active[1],
                  highlighted: false,
                  onChanged: (v) => setState(() => _active[1] = v),
                ),
                const SizedBox(height: 10),
                _MirrorCard(
                  time: '13:13',
                  meaning: 'Transformación alquímica en progreso',
                  voiceInfo: 'Voz Sabio · Mantra de Júpiter',
                  active: _active[2],
                  highlighted: false,
                  onChanged: (v) => setState(() => _active[2] = v),
                ),
                const SizedBox(height: 10),
                _MirrorCard(
                  time: '22:22',
                  meaning: 'La hora más poderosa del día',
                  voiceInfo: 'Voz Mi Voz · Código maestro 741852',
                  active: _active[3],
                  highlighted: true,
                  onChanged: (v) => setState(() => _active[3] = v),
                ),
                const SizedBox(height: 10),
                _MirrorCard(
                  time: '00:00',
                  meaning: 'Portal del infinito · Reset cósmico',
                  voiceInfo: 'Voz Osiain · Meditación de silencio',
                  active: _active[4],
                  highlighted: false,
                  onChanged: (v) => setState(() => _active[4] = v),
                ),
                const SizedBox(height: 28),

                // ── CTA ───────────────────────────────────────────────
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryButton,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          LucideIcons.sparkles,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Crear hora espejo personalizada',
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
      ),
    );
  }
}

class _MirrorCard extends StatelessWidget {
  final String time;
  final String meaning;
  final String voiceInfo;
  final bool active;
  final bool highlighted;
  final ValueChanged<bool> onChanged;

  const _MirrorCard({
    required this.time,
    required this.meaning,
    required this.voiceInfo,
    required this.active,
    required this.highlighted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: highlighted
            ? AppColors.primary.withValues(alpha: 0.15)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: highlighted
              ? AppColors.primary.withValues(alpha: 0.4)
              : AppColors.surfaceBorderLight,
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: GoogleFonts.urbanist(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: highlighted ? AppColors.primaryLight : Colors.white,
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meaning,
                  style: GoogleFonts.urbanist(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  voiceInfo,
                  style: GoogleFonts.urbanist(
                    fontSize: 11,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Switch(
            value: active,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.35),
            inactiveThumbColor: AppColors.textTertiary,
            inactiveTrackColor: AppColors.white.withValues(alpha: 0.08),
          ),
        ],
      ),
    );
  }
}
