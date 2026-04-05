import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';
import '../services/alarm_service.dart';

class NewAlarmScreen extends StatefulWidget {
  const NewAlarmScreen({super.key});

  @override
  State<NewAlarmScreen> createState() => _NewAlarmScreenState();
}

class _NewAlarmScreenState extends State<NewAlarmScreen> {
  int _hour = 6;
  int _minute = 30;
  bool _isAm = true;
  final Set<int> _days = {0, 1, 3, 4};
  int _selectedVoice = 0;
  int _selectedFreq = 0;
  bool _vibrate = true;
  bool _softLight = true;
  final _nameController = TextEditingController();

  static const List<String> dayLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  static const List<String> voiceNames = ['Serena', 'Sabio', 'Ocean', 'Mi Voz'];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _saveAlarm() async {
    final hour24 = _isAm
        ? (_hour == 12 ? 0 : _hour)
        : (_hour == 12 ? 12 : _hour + 12);

    final weekdays = _days.map((d) => d + 1).toList()..sort();

    String frequency;
    if (weekdays.isEmpty) {
      frequency = 'once';
    } else if (weekdays.length == 7) {
      frequency = 'daily';
    } else {
      frequency = 'custom';
    }

    await AlarmService.instance.createAlarm(
      hour: hour24,
      minute: _minute,
      weekdays: weekdays,
      name: _nameController.text.isEmpty ? 'Alarma' : _nameController.text,
      voice: voiceNames[_selectedVoice],
      frequency: frequency,
    );

    if (mounted && Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }
  static const List<_FreqChip> freqChips = [
    _FreqChip('Theta 7Hz', AppColors.primary),
    _FreqChip('Alpha 10Hz', AppColors.lunar),
    _FreqChip('Delta 2Hz', AppColors.mint),
  ];

  Widget _buildNumberColumn({
    required List<int> values,
    required int selectedIndex,
    required String Function(int) format,
    required void Function(int delta) onScroll,
  }) {
    return GestureDetector(
      onVerticalDragEnd: (d) {
        if (d.primaryVelocity != null) {
          onScroll(d.primaryVelocity! < 0 ? 1 : -1);
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(values.length, (i) {
          final isCenter = i == 2;
          return AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 150),
            style: GoogleFonts.urbanist(
              fontSize: isCenter ? Responsive.sp(52) : Responsive.sp(32),
              fontWeight: isCenter ? FontWeight.w800 : FontWeight.w400,
              color: isCenter
                  ? Colors.white
                  : Colors.white.withValues(alpha: isCenter ? 1.0 : (i == 1 || i == 3 ? 0.3 : 0.12)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: isCenter ? 0 : Responsive.h(4)),
              child: Text(format(values[i])),
            ),
          );
        }),
      ),
    );
  }

  void _changeHour(int delta) {
    setState(() {
      _hour = ((_hour - 1 + delta) % 12 + 12) % 12 + 1;
    });
  }

  void _changeMinute(int delta) {
    setState(() {
      _minute = ((_minute + delta * 5) % 60 + 60) % 60;
    });
  }

  List<int> get _hourDisplay {
    return List.generate(5, (i) {
      final v = (_hour - 3 + i);
      return ((v - 1) % 12 + 12) % 12 + 1;
    });
  }

  List<int> get _minuteDisplay {
    return List.generate(5, (i) {
      final v = (_minute ~/ 5 - 2 + i) * 5;
      return ((v % 60) + 60) % 60;
    });
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ─────────────────────────────────────────────
                Row(
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
                          LucideIcons.x,
                          color: Colors.white,
                          size: Responsive.w(18),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Nueva Alarma',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: Responsive.sp(17),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _saveAlarm,
                      child: Text(
                        'Guardar',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(15),
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(28)),

                // ── Time picker ─────────────────────────────────────────
                Container(
                  padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.surfaceBorderLight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildNumberColumn(
                        values: _hourDisplay,
                        selectedIndex: 2,
                        format: (v) => v.toString().padLeft(2, '0'),
                        onScroll: _changeHour,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Responsive.w(8)),
                        child: Text(
                          ':',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(48),
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      _buildNumberColumn(
                        values: _minuteDisplay,
                        selectedIndex: 2,
                        format: (v) => v.toString().padLeft(2, '0'),
                        onScroll: _changeMinute,
                      ),
                      SizedBox(width: Responsive.w(20)),
                      Column(
                        children: ['AM', 'PM'].map((label) {
                          final isSelected =
                              (label == 'AM') == _isAm;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _isAm = label == 'AM'),
                            child: Container(
                              width: Responsive.w(52),
                              padding:
                                  EdgeInsets.symmetric(vertical: Responsive.h(10)),
                              margin: EdgeInsets.symmetric(vertical: Responsive.h(3)),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                label,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.urbanist(
                                  fontSize: Responsive.sp(15),
                                  fontWeight: FontWeight.w700,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textTertiary,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Alarm name ──────────────────────────────────────────
                const SectionLabel('NOMBRE DE LA ALARMA'),
                SizedBox(height: Responsive.h(12)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(14),
                    vertical: Responsive.h(4),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.surfaceBorderLight),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.sparkles,
                        color: AppColors.primaryLight,
                        size: Responsive.w(18),
                      ),
                      SizedBox(width: Responsive.w(10)),
                      Expanded(
                        child: TextField(
                          controller: _nameController,
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(14),
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Shajarit · Meditación matutina',
                            hintStyle: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(14),
                              color: AppColors.textTertiary,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: Responsive.h(14)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Repeat days ─────────────────────────────────────────
                const SectionLabel('DÍAS DE REPETICIÓN'),
                SizedBox(height: Responsive.h(14)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(7, (i) {
                    final sel = _days.contains(i);
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          if (sel) {
                            _days.remove(i);
                          } else {
                            _days.add(i);
                          }
                        });
                      },
                      child: Container(
                        width: Responsive.w(40),
                        height: Responsive.w(40),
                        decoration: BoxDecoration(
                          color: sel
                              ? AppColors.primary
                              : AppColors.white.withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: sel
                                ? AppColors.primary
                                : AppColors.surfaceBorderLight,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            dayLabels[i],
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              fontWeight: FontWeight.w700,
                              color: sel ? Colors.white : AppColors.textTertiary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Voice ───────────────────────────────────────────────
                const SectionLabel('VOZ CEREBRAL'),
                SizedBox(height: Responsive.h(14)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(voiceNames.length, (i) {
                    final sel = _selectedVoice == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedVoice = i),
                      child: Column(
                        children: [
                          Container(
                            width: Responsive.w(56),
                            height: Responsive.w(56),
                            decoration: BoxDecoration(
                              color: sel
                                  ? AppColors.primary.withValues(alpha: 0.25)
                                  : AppColors.white.withValues(alpha: 0.08),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: sel
                                    ? AppColors.primary
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: Icon(
                              LucideIcons.user,
                              color: sel
                                  ? AppColors.primaryLight
                                  : AppColors.textTertiary,
                              size: Responsive.w(22),
                            ),
                          ),
                          SizedBox(height: Responsive.h(6)),
                          Text(
                            voiceNames[i],
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(12),
                              fontWeight: FontWeight.w600,
                              color: sel ? Colors.white : AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Brain frequency ─────────────────────────────────────
                const SectionLabel('FRECUENCIA CEREBRAL'),
                SizedBox(height: Responsive.h(12)),
                Row(
                  children: List.generate(freqChips.length, (i) {
                    final sel = _selectedFreq == i;
                    return Padding(
                      padding: EdgeInsets.only(right: i < freqChips.length - 1 ? Responsive.w(10) : 0),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedFreq = i),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.w(14),
                            vertical: Responsive.h(8),
                          ),
                          decoration: BoxDecoration(
                            color: sel
                                ? freqChips[i].color.withValues(alpha: 0.25)
                                : AppColors.white.withValues(alpha: 0.07),
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: sel
                                  ? freqChips[i].color
                                  : AppColors.surfaceBorderLight,
                            ),
                          ),
                          child: Text(
                            freqChips[i].label,
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              fontWeight: FontWeight.w600,
                              color: sel ? Colors.white : AppColors.textTertiary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Options ─────────────────────────────────────────────
                const SectionLabel('OPCIONES'),
                SizedBox(height: Responsive.h(12)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(16),
                    vertical: Responsive.h(6),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.surfaceBorderLight),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.smartphone,
                        color: AppColors.textTertiary,
                        size: Responsive.w(18),
                      ),
                      SizedBox(width: Responsive.w(10)),
                      Expanded(
                        child: Text(
                          'Vibración',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(14),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Switch(
                        value: _vibrate,
                        onChanged: (v) => setState(() => _vibrate = v),
                        activeThumbColor: Colors.white,
                        activeTrackColor: AppColors.primary,
                        inactiveThumbColor: AppColors.textTertiary,
                        inactiveTrackColor:
                            AppColors.white.withValues(alpha: 0.08),
                      ),
                      SizedBox(width: Responsive.w(16)),
                      Icon(
                        LucideIcons.sun,
                        color: AppColors.textTertiary,
                        size: Responsive.w(18),
                      ),
                      SizedBox(width: Responsive.w(10)),
                      Expanded(
                        child: Text(
                          'Luz suave',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(14),
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Switch(
                        value: _softLight,
                        onChanged: (v) => setState(() => _softLight = v),
                        activeThumbColor: Colors.white,
                        activeTrackColor: AppColors.primary,
                        inactiveThumbColor: AppColors.textTertiary,
                        inactiveTrackColor:
                            AppColors.white.withValues(alpha: 0.08),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(32)),

                // ── CTA ─────────────────────────────────────────────────
                GestureDetector(
                  onTap: _saveAlarm,
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
                          LucideIcons.sparkles,
                          color: Colors.white,
                          size: Responsive.w(18),
                        ),
                        SizedBox(width: Responsive.w(10)),
                        Text(
                          'Crear Alarma Cerebral',
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
                SizedBox(height: Responsive.h(14)),
                Center(
                  child: Text(
                    'Se activará la frecuencia Theta 7Hz al despertar',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      color: const Color(0x50FFFFFF),
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

class _FreqChip {
  final String label;
  final Color color;

  const _FreqChip(this.label, this.color);
}
