import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class AlarmsTab extends StatefulWidget {
  const AlarmsTab({super.key});

  @override
  State<AlarmsTab> createState() => _AlarmsTabState();
}

class _AlarmsTabState extends State<AlarmsTab> {
  final List<bool> _alarmActive = [true, false, true];
  int _selectedVoice = 3; // 0=Serena, 1=Sabio, 2=Osiain, 3=Mi Voz

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Nav ─────────────────────────────────────────────────
              ScreenNav(
                title: 'Alarmas Bio-Hack',
                trailing: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      gradient: AppGradients.greenButton,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      LucideIcons.plus,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // ── Voice Generator ─────────────────────────────────────
              const SectionLabel('MI GENERADOR DE VOZ'),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        gradient: AppGradients.primaryButton,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        LucideIcons.mic,
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mi Voz Clonada',
                            style: GoogleFonts.urbanist(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Entrenando · Calidad 82%',
                            style: GoogleFonts.urbanist(
                              fontSize: 13,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const SizedBox(height: 6),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: 0.82,
                              backgroundColor:
                                  AppColors.white.withValues(alpha: 0.1),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                              minHeight: 4,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mint.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Mejor',
                            style: GoogleFonts.urbanist(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.mint,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        GestureDetector(
                          onTap: () => context.push('/player'),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              LucideIcons.play,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // ── System Voices ───────────────────────────────────────
              const SectionLabel('VOCES DEL SISTEMA'),
              const SizedBox(height: 14),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _VoiceAvatar(
                    name: 'Serena',
                    index: 0,
                    selected: _selectedVoice == 0,
                    color: AppColors.lunar,
                    onTap: () => setState(() => _selectedVoice = 0),
                  ),
                  _VoiceAvatar(
                    name: 'Sabio',
                    index: 1,
                    selected: _selectedVoice == 1,
                    color: AppColors.chakra,
                    onTap: () => setState(() => _selectedVoice = 1),
                  ),
                  _VoiceAvatar(
                    name: 'Osiain',
                    index: 2,
                    selected: _selectedVoice == 2,
                    color: AppColors.mint,
                    onTap: () => setState(() => _selectedVoice = 2),
                  ),
                  _VoiceAvatar(
                    name: 'Mi Voz',
                    index: 3,
                    selected: _selectedVoice == 3,
                    color: AppColors.primary,
                    onTap: () => setState(() => _selectedVoice = 3),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // ── Alarms ──────────────────────────────────────────────
              const SectionLabel('MIS ALARMAS CEREBRALES'),
              const SizedBox(height: 12),

              _AlarmCard(
                time: '06:30',
                name: 'Shajarit',
                days: 'Lun-Vie',
                voiceName: 'Voz Serena',
                accentColor: AppColors.primary,
                active: _alarmActive[0],
                onChanged: (v) => setState(() => _alarmActive[0] = v),
              ),
              const SizedBox(height: 10),
              _AlarmCard(
                time: '14:45',
                name: 'Minja',
                days: 'Todos los días',
                voiceName: 'Voz Sabio',
                accentColor: AppColors.lunar,
                active: _alarmActive[1],
                onChanged: (v) => setState(() => _alarmActive[1] = v),
              ),
              const SizedBox(height: 10),
              _AlarmCard(
                time: '18:42',
                name: 'Maariv',
                days: 'Todos los días',
                voiceName: 'Voz Mi Voz',
                accentColor: AppColors.mint,
                active: _alarmActive[2],
                onChanged: (v) => setState(() => _alarmActive[2] = v),
              ),
              const SizedBox(height: 24),

              // ── CTA ─────────────────────────────────────────────────
              GestureDetector(
                onTap: () => context.push('/new-alarm'),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    gradient: AppGradients.greenButton,
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mint.withValues(alpha: 0.3),
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
                        'Crear alarma cerebral',
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

class _VoiceAvatar extends StatelessWidget {
  final String name;
  final int index;
  final bool selected;
  final Color color;
  final VoidCallback onTap;

  const _VoiceAvatar({
    required this.name,
    required this.index,
    required this.selected,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? AppColors.primary : Colors.transparent,
                width: 2.5,
              ),
            ),
            child: Icon(LucideIcons.user, color: color, size: 26),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: GoogleFonts.urbanist(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: selected ? Colors.white : AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlarmCard extends StatelessWidget {
  final String time;
  final String name;
  final String days;
  final String voiceName;
  final Color accentColor;
  final bool active;
  final ValueChanged<bool> onChanged;

  const _AlarmCard({
    required this.time,
    required this.name,
    required this.days,
    required this.voiceName,
    required this.accentColor,
    required this.active,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: active
            ? accentColor.withValues(alpha: 0.08)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: active
              ? accentColor.withValues(alpha: 0.3)
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
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: active ? Colors.white : AppColors.textTertiary,
                ),
              ),
              Text(
                name,
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : AppColors.textTertiary,
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
                  days,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
                Text(
                  voiceName,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: accentColor.withValues(alpha: 0.9),
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: active,
            onChanged: onChanged,
            activeThumbColor: accentColor,
            activeTrackColor: accentColor.withValues(alpha: 0.35),
            inactiveThumbColor: AppColors.textTertiary,
            inactiveTrackColor: AppColors.white.withValues(alpha: 0.08),
          ),
        ],
      ),
    );
  }
}
