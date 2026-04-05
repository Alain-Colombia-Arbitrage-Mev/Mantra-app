import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';


class AlchemistScreen extends StatefulWidget {
  const AlchemistScreen({super.key});

  @override
  State<AlchemistScreen> createState() => _AlchemistScreenState();
}

class _AlchemistScreenState extends State<AlchemistScreen> {
  int _selectedBrainState = 2;
  int _selectedFrequency = 1;
  int _selectedLandscape = 0;
  final TextEditingController _mantraController = TextEditingController();

  static const List<_BrainChip> _brainStates = [
    _BrainChip(label: 'Beta', range: '8-31Hz'),
    _BrainChip(label: 'Alpha', range: '8-12Hz'),
    _BrainChip(label: 'Theta', range: '4-7Hz'),
    _BrainChip(label: 'Delta', range: '1-3Hz'),
  ];

  static const List<_FreqChip> _frequencies = [
    _FreqChip(hz: '432Hz', name: 'Armonía'),
    _FreqChip(hz: '528Hz', name: 'Amor'),
    _FreqChip(hz: '639Hz', name: 'Conexión'),
    _FreqChip(hz: '741Hz', name: 'Intuición'),
    _FreqChip(hz: '852Hz', name: 'Despertar'),
  ];

  static const List<_LandscapeChip> _landscapes = [
    _LandscapeChip(label: 'Cosmos', icon: LucideIcons.sparkles),
    _LandscapeChip(label: 'Bosque', icon: LucideIcons.trees),
    _LandscapeChip(label: 'Océano', icon: LucideIcons.waves),
    _LandscapeChip(label: 'Silencio', icon: LucideIcons.volumeX),
  ];

  @override
  void dispose() {
    _mantraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      extendBody: true,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(40),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surfaceBorderLight,
                          ),
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
                        'El Alquimista',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(18),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: Responsive.w(36),
                      height: Responsive.w(36),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surfaceBorderLight),
                      ),
                      child: Icon(
                        LucideIcons.info,
                        color: Colors.white,
                        size: Responsive.w(18),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: Responsive.h(8)),
                Center(
                  child: Text(
                    'Crea tu Audio de Manifestación',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(13),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(28)),
                const SectionLabel('ESTADO CEREBRAL'),
                SizedBox(height: Responsive.h(12)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_brainStates.length, (i) {
                      final chip = _brainStates[i];
                      final selected = i == _selectedBrainState;
                      return Padding(
                        padding: EdgeInsets.only(
                          right: i < _brainStates.length - 1 ? Responsive.w(8) : 0,
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedBrainState = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.w(18),
                              vertical: Responsive.h(10),
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : const Color(0x1AFFFFFF),
                              borderRadius: BorderRadius.circular(Responsive.w(50)),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  chip.label,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(13),
                                    fontWeight: FontWeight.w700,
                                    color: selected
                                        ? Colors.white
                                        : const Color(0xAAFFFFFF),
                                  ),
                                ),
                                Text(
                                  chip.range,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(11),
                                    color: selected
                                        ? Colors.white.withValues(alpha: 0.8)
                                        : const Color(0x66FFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: Responsive.h(24)),
                const SectionLabel('FRECUENCIA BINAURAL'),
                SizedBox(height: Responsive.h(12)),
                Row(
                  children: List.generate(3, (i) {
                    final freq = _frequencies[i];
                    final selected = i == _selectedFrequency;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: i < 2 ? Responsive.w(8) : 0),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedFrequency = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0x33F9A826)
                                  : const Color(0x1AFFFFFF),
                              borderRadius: BorderRadius.circular(Responsive.w(12)),
                              border: Border.all(
                                color: selected
                                    ? AppColors.amber
                                    : Colors.transparent,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  freq.hz,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(14),
                                    fontWeight: FontWeight.w700,
                                    color: selected
                                        ? AppColors.amber
                                        : Colors.white,
                                  ),
                                ),
                                Text(
                                  freq.name,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(11),
                                    color: selected
                                        ? AppColors.amber
                                            .withValues(alpha: 0.8)
                                        : const Color(0x80FFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: Responsive.h(8)),
                Row(
                  children: List.generate(2, (i) {
                    final idx = i + 3;
                    final freq = _frequencies[idx];
                    final selected = idx == _selectedFrequency;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: i < 1 ? Responsive.w(8) : 0),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedFrequency = idx),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0x33F9A826)
                                  : const Color(0x1AFFFFFF),
                              borderRadius: BorderRadius.circular(Responsive.w(12)),
                              border: Border.all(
                                color: selected
                                    ? AppColors.amber
                                    : Colors.transparent,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  freq.hz,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(14),
                                    fontWeight: FontWeight.w700,
                                    color: selected
                                        ? AppColors.amber
                                        : Colors.white,
                                  ),
                                ),
                                Text(
                                  freq.name,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(11),
                                    color: selected
                                        ? AppColors.amber
                                            .withValues(alpha: 0.8)
                                        : const Color(0x80FFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: Responsive.h(24)),
                const SectionLabel('PAISAJE SONORO'),
                SizedBox(height: Responsive.h(12)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_landscapes.length, (i) {
                      final ls = _landscapes[i];
                      final selected = i == _selectedLandscape;
                      return Padding(
                        padding: EdgeInsets.only(
                          right: i < _landscapes.length - 1 ? Responsive.w(8) : 0,
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedLandscape = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.w(16),
                              vertical: Responsive.h(10),
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : const Color(0x1AFFFFFF),
                              borderRadius: BorderRadius.circular(Responsive.w(50)),
                              border: Border.all(
                                color: selected
                                    ? AppColors.primary
                                    : Colors.transparent,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  ls.icon,
                                  size: Responsive.w(14),
                                  color: selected
                                      ? Colors.white
                                      : const Color(0xAAFFFFFF),
                                ),
                                SizedBox(width: Responsive.w(6)),
                                Text(
                                  ls.label,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(13),
                                    fontWeight: FontWeight.w600,
                                    color: selected
                                        ? Colors.white
                                        : const Color(0xAAFFFFFF),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                SizedBox(height: Responsive.h(24)),
                const SectionLabel('TU MANTRA'),
                SizedBox(height: Responsive.h(12)),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(Responsive.w(16)),
                    border: Border.all(color: const Color(0x26FFFFFF)),
                  ),
                  child: TextField(
                    controller: _mantraController,
                    maxLines: 3,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(14),
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText:
                          'Escribe tu intención o afirmación...',
                      hintStyle: GoogleFonts.urbanist(
                        fontSize: Responsive.sp(14),
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(Responsive.w(16)),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(20)),
                Container(
                  padding: EdgeInsets.all(Responsive.w(16)),
                  decoration: BoxDecoration(
                    color: const Color(0x146C5CE7),
                    borderRadius: BorderRadius.circular(Responsive.w(16)),
                    border: Border.all(color: const Color(0x666C5CE7)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'GRABACIÓN DE VOZ',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(11),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: Responsive.w(10),
                              vertical: Responsive.h(4),
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.mint.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(Responsive.w(20)),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: Responsive.w(6),
                                  height: Responsive.w(6),
                                  decoration: const BoxDecoration(
                                    color: AppColors.mint,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                SizedBox(width: Responsive.w(5)),
                                Text(
                                  'Listo',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(11),
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mint,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.h(16)),
                      Row(
                        children: [
                          Icon(
                            LucideIcons.mic,
                            color: AppColors.primaryLight,
                            size: Responsive.w(32),
                          ),
                          SizedBox(width: Responsive.w(14)),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tu voz clonada activa',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(14),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(height: Responsive.h(2)),
                                Text(
                                  'Graba 10 seg · Calidad 82% · Mi Voz',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(12),
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.h(14)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildWaveform(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(24)),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Grabación próximamente',
                        style: GoogleFonts.urbanist(),
                      ),
                      backgroundColor: AppColors.primary,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  child: Container(
                    width: double.infinity,
                    height: Responsive.h(54),
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryButton,
                      borderRadius: BorderRadius.circular(Responsive.w(27)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.40),
                          blurRadius: Responsive.w(20),
                          offset: Offset(0, Responsive.h(8)),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(LucideIcons.mic, color: Colors.white, size: Responsive.w(20)),
                        SizedBox(width: Responsive.w(10)),
                        Text(
                          'Graba tu voz · Activa ahora',
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
                SizedBox(height: Responsive.h(16)),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (Navigator.of(context).canPop()) {
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text(
                      'Guardar para después',
                      style: GoogleFonts.urbanist(
                        fontSize: Responsive.sp(13),
                        color: Colors.white.withValues(alpha: 0.66),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(20)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWaveform() {
    final heights = [8.0, 14.0, 20.0, 12.0, 24.0, 10.0, 18.0, 14.0, 22.0, 10.0, 16.0, 8.0];
    return heights
        .map(
          (h) => Padding(
            padding: EdgeInsets.symmetric(horizontal: Responsive.w(2)),
            child: Container(
              width: Responsive.w(4),
              height: Responsive.h(h),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(Responsive.w(2)),
              ),
            ),
          ),
        )
        .toList();
  }
}

class _BrainChip {
  final String label;
  final String range;
  const _BrainChip({required this.label, required this.range});
}

class _FreqChip {
  final String hz;
  final String name;
  const _FreqChip({required this.hz, required this.name});
}

class _LandscapeChip {
  final String label;
  final IconData icon;
  const _LandscapeChip({required this.label, required this.icon});
}
