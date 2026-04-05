import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';
import '../services/alarm_service.dart';
import '../models/alarm_data.dart';

class AlarmsTab extends StatefulWidget {
  const AlarmsTab({super.key});

  @override
  State<AlarmsTab> createState() => _AlarmsTabState();
}

class _AlarmsTabState extends State<AlarmsTab> {
  int _selectedVoice = 3;
  bool _permissionsChecked = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _checkPermissions());
  }

  Future<void> _checkPermissions() async {
    if (_permissionsChecked) return;
    _permissionsChecked = true;
    final granted = await AlarmService.instance.ensurePermissions();
    if (!granted && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Se necesitan permisos de alarma y notificaciones'),
        ),
      );
    }
  }

  static String _formatDays(AlarmData alarm) {
    if (alarm.weekdays.isEmpty || alarm.frequency == 'once') return 'Una vez';
    if (alarm.weekdays.length == 7) return 'Todos los días';
    const labels = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];
    final sorted = [...alarm.weekdays]..sort();
    if (sorted.length == 5 && sorted[0] == 1 && sorted[4] == 5) {
      return 'Lun-Vie';
    }
    return sorted.map((d) => labels[d - 1]).join(', ');
  }

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(Responsive.pagePadding, Responsive.h(20), Responsive.pagePadding, Responsive.bottomNavPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Nav ─────────────────────────────────────────────────
              ScreenNav(
                title: 'Alarmas Bio-Hack',
                trailing: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: Responsive.w(36),
                    height: Responsive.w(36),
                    decoration: BoxDecoration(
                      gradient: AppGradients.greenButton,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.plus,
                      color: Colors.white,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Responsive.h(24)),

              // ── Voice Generator ─────────────────────────────────────
              const SectionLabel('MI GENERADOR DE VOZ'),
              SizedBox(height: Responsive.h(12)),

              Container(
                padding: EdgeInsets.all(Responsive.w(16)),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(Responsive.w(16)),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.35),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: Responsive.w(48),
                      height: Responsive.w(48),
                      decoration: BoxDecoration(
                        gradient: AppGradients.primaryButton,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        LucideIcons.mic,
                        color: Colors.white,
                        size: Responsive.w(22),
                      ),
                    ),
                    SizedBox(width: Responsive.w(14)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mi Voz Clonada',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(16),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: Responsive.h(3)),
                          Text(
                            'Entrenando · Calidad 82%',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              color: AppColors.textTertiary,
                            ),
                          ),
                          SizedBox(height: Responsive.h(6)),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Responsive.w(4)),
                            child: LinearProgressIndicator(
                              value: 0.82,
                              backgroundColor:
                                  AppColors.white.withValues(alpha: 0.1),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                AppColors.primary,
                              ),
                              minHeight: Responsive.h(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: Responsive.w(10)),
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.w(8), vertical: Responsive.h(4),
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mint.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(Responsive.w(8)),
                          ),
                          child: Text(
                            'Mejor',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(11),
                              fontWeight: FontWeight.w700,
                              color: AppColors.mint,
                            ),
                          ),
                        ),
                        SizedBox(height: Responsive.h(6)),
                        GestureDetector(
                          onTap: () => context.push('/player'),
                          child: Container(
                            width: Responsive.w(32),
                            height: Responsive.w(32),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              LucideIcons.play,
                              color: Colors.white,
                              size: Responsive.w(14),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: Responsive.h(20)),

              // ── System Voices ───────────────────────────────────────
              const SectionLabel('VOCES DEL SISTEMA'),
              SizedBox(height: Responsive.h(14)),

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
              SizedBox(height: Responsive.h(24)),

              // ── Alarms ──────────────────────────────────────────────
              const SectionLabel('MIS ALARMAS CEREBRALES'),
              SizedBox(height: Responsive.h(12)),

              ValueListenableBuilder<List<AlarmData>>(
                valueListenable: AlarmService.instance.alarms,
                builder: (context, alarmList, _) {
                  if (alarmList.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: Responsive.h(24)),
                      child: Center(
                        child: Text(
                          'No tienes alarmas aún.\nCrea tu primera alarma cerebral.',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(14),
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ),
                    );
                  }
                  const accentColors = [
                    AppColors.primary,
                    AppColors.lunar,
                    AppColors.mint,
                  ];
                  return Column(
                    children: [
                      for (int i = 0; i < alarmList.length; i++) ...[
                        if (i > 0) SizedBox(height: Responsive.h(10)),
                        Dismissible(
                          key: ValueKey(alarmList[i].id),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: EdgeInsets.only(right: Responsive.w(20)),
                            decoration: BoxDecoration(
                              color: Colors.red.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(Responsive.w(16)),
                            ),
                            child: Icon(LucideIcons.trash2, color: Colors.red, size: Responsive.w(22)),
                          ),
                          onDismissed: (_) => AlarmService.instance.deleteAlarm(alarmList[i].id),
                          child: _AlarmCard(
                            time:
                                '${alarmList[i].hour.toString().padLeft(2, '0')}:${alarmList[i].minute.toString().padLeft(2, '0')}',
                            name: alarmList[i].name,
                            days: _formatDays(alarmList[i]),
                            voiceName: alarmList[i].voice ?? 'Mi Voz',
                            accentColor: accentColors[i % accentColors.length],
                            active: alarmList[i].active,
                            onChanged: (_) =>
                                AlarmService.instance.toggleAlarm(alarmList[i].id),
                          ),
                        ),
                      ],
                    ],
                  );
                },
              ),
              SizedBox(height: Responsive.h(24)),

              // ── CTA ─────────────────────────────────────────────────
              GestureDetector(
                onTap: () => context.push('/new-alarm'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: Responsive.h(16)),
                  decoration: BoxDecoration(
                    gradient: AppGradients.greenButton,
                    borderRadius: BorderRadius.circular(Responsive.w(50)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.mint.withValues(alpha: 0.3),
                        blurRadius: Responsive.w(16),
                        offset: Offset(0, Responsive.h(6)),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        LucideIcons.sparkles,
                        color: Colors.white,
                        size: Responsive.w(18),
                      ),
                      SizedBox(width: Responsive.w(10)),
                      Text(
                        'Crear alarma cerebral',
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
            width: Responsive.w(58),
            height: Responsive.w(58),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? AppColors.primary : Colors.transparent,
                width: 2.5,
              ),
            ),
            child: Icon(LucideIcons.user, color: color, size: Responsive.w(26)),
          ),
          SizedBox(height: Responsive.h(6)),
          Text(
            name,
            style: GoogleFonts.urbanist(
              fontSize: Responsive.sp(12),
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
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: active
            ? accentColor.withValues(alpha: 0.08)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
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
                  fontSize: Responsive.sp(28),
                  fontWeight: FontWeight.w800,
                  color: active ? Colors.white : AppColors.textTertiary,
                ),
              ),
              Text(
                name,
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(14),
                  fontWeight: FontWeight.w600,
                  color: active ? Colors.white : AppColors.textTertiary,
                ),
              ),
            ],
          ),
          SizedBox(width: Responsive.w(14)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  days,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(12),
                    color: AppColors.textTertiary,
                  ),
                ),
                Text(
                  voiceName,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(12),
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
