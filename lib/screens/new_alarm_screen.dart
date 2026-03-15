import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class NewAlarmScreen extends StatefulWidget {
  const NewAlarmScreen({super.key});

  @override
  State<NewAlarmScreen> createState() => _NewAlarmScreenState();
}

class _NewAlarmScreenState extends State<NewAlarmScreen> {
  int _hour = 6;
  int _minute = 30;
  bool _isAm = true;
  final Set<int> _days = {0, 1, 3, 4}; // L M J V selected
  int _selectedVoice = 0; // Serena
  int _selectedFreq = 0; // Theta
  bool _vibrate = true;
  bool _softLight = true;

  static const List<String> dayLabels = ['L', 'M', 'X', 'J', 'V', 'S', 'D'];
  static const List<String> voiceNames = ['Serena', 'Sabio', 'Ocean', 'Mi Voz'];
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
              fontSize: isCenter ? 52 : 32,
              fontWeight: isCenter ? FontWeight.w800 : FontWeight.w400,
              color: isCenter
                  ? Colors.white
                  : Colors.white.withValues(alpha: isCenter ? 1.0 : (i == 1 || i == 3 ? 0.3 : 0.12)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: isCenter ? 0 : 4),
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
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
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
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.surfaceBorderLight),
                        ),
                        child: const Icon(
                          LucideIcons.x,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: Text(
                        'Nueva Alarma',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Urbanist',
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      child: Text(
                        'Guardar',
                        style: GoogleFonts.urbanist(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryLight,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // ── Time picker ─────────────────────────────────────────
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppColors.surfaceBorderLight),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Hours
                      _buildNumberColumn(
                        values: _hourDisplay,
                        selectedIndex: 2,
                        format: (v) => v.toString().padLeft(2, '0'),
                        onScroll: _changeHour,
                      ),
                      // Colon
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          ':',
                          style: GoogleFonts.urbanist(
                            fontSize: 48,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      // Minutes
                      _buildNumberColumn(
                        values: _minuteDisplay,
                        selectedIndex: 2,
                        format: (v) => v.toString().padLeft(2, '0'),
                        onScroll: _changeMinute,
                      ),
                      const SizedBox(width: 20),
                      // AM/PM
                      Column(
                        children: ['AM', 'PM'].map((label) {
                          final isSelected =
                              (label == 'AM') == _isAm;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _isAm = label == 'AM'),
                            child: Container(
                              width: 52,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10),
                              margin: const EdgeInsets.symmetric(vertical: 3),
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
                                  fontSize: 15,
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
                const SizedBox(height: 24),

                // ── Alarm name ──────────────────────────────────────────
                const SectionLabel('NOMBRE DE LA ALARMA'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.surfaceBorderLight),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.sparkles,
                        color: AppColors.primaryLight,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextField(
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Shajarit · Meditación matutina',
                            hintStyle: GoogleFonts.urbanist(
                              fontSize: 14,
                              color: AppColors.textTertiary,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 14),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── Repeat days ─────────────────────────────────────────
                const SectionLabel('DÍAS DE REPETICIÓN'),
                const SizedBox(height: 14),
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
                        width: 40,
                        height: 40,
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
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: sel ? Colors.white : AppColors.textTertiary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // ── Voice ───────────────────────────────────────────────
                const SectionLabel('VOZ CEREBRAL'),
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(voiceNames.length, (i) {
                    final sel = _selectedVoice == i;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedVoice = i),
                      child: Column(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
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
                              size: 22,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            voiceNames[i],
                            style: GoogleFonts.urbanist(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: sel ? Colors.white : AppColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // ── Brain frequency ─────────────────────────────────────
                const SectionLabel('FRECUENCIA CEREBRAL'),
                const SizedBox(height: 12),
                Row(
                  children: List.generate(freqChips.length, (i) {
                    final sel = _selectedFreq == i;
                    return Padding(
                      padding: EdgeInsets.only(right: i < freqChips.length - 1 ? 10 : 0),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedFreq = i),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
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
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: sel ? Colors.white : AppColors.textTertiary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 24),

                // ── Options ─────────────────────────────────────────────
                const SectionLabel('OPCIONES'),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.surfaceBorderLight),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        LucideIcons.smartphone,
                        color: AppColors.textTertiary,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Vibración',
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
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
                      const SizedBox(width: 16),
                      const Icon(
                        LucideIcons.sun,
                        color: AppColors.textTertiary,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Luz suave',
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
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
                const SizedBox(height: 32),

                // ── CTA ─────────────────────────────────────────────────
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
                          LucideIcons.sparkles,
                          color: Colors.white,
                          size: 18,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Crear Alarma Cerebral',
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
                const SizedBox(height: 14),
                Center(
                  child: Text(
                    'Se activará la frecuencia Theta 7Hz al despertar',
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
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
