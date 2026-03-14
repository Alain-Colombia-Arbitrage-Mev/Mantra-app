import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class AlchemistScreen extends StatefulWidget {
  const AlchemistScreen({super.key});

  @override
  State<AlchemistScreen> createState() => _AlchemistScreenState();
}

class _AlchemistScreenState extends State<AlchemistScreen> {
  int _selectedBrainState = 2; // Theta selected
  int _selectedFrequency = 1; // 528Hz selected
  int _selectedLandscape = 0; // Cosmos selected
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
                // ── Header ──────────────────────────────────────────────
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
                          color: Colors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surfaceBorderLight,
                          ),
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
                        'El Alquimista',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surfaceBorderLight),
                      ),
                      child: const Icon(
                        LucideIcons.info,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                // Subtitle
                Center(
                  child: Text(
                    'Crea tu Audio de Manifestación',
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
                const SizedBox(height: 28),

                // ── Brain State ──────────────────────────────────────────
                const SectionLabel('ESTADO CEREBRAL'),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_brainStates.length, (i) {
                      final chip = _brainStates[i];
                      final selected = i == _selectedBrainState;
                      return Padding(
                        padding: EdgeInsets.only(
                          right: i < _brainStates.length - 1 ? 8 : 0,
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedBrainState = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 18,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : const Color(0x1AFFFFFF),
                              borderRadius: BorderRadius.circular(50),
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
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: selected
                                        ? Colors.white
                                        : const Color(0xAAFFFFFF),
                                  ),
                                ),
                                Text(
                                  chip.range,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 11,
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
                const SizedBox(height: 24),

                // ── Binaural Frequency ───────────────────────────────────
                const SectionLabel('FRECUENCIA BINAURAL'),
                const SizedBox(height: 12),
                // Row 1: first 3 frequencies
                Row(
                  children: List.generate(3, (i) {
                    final freq = _frequencies[i];
                    final selected = i == _selectedFrequency;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: i < 2 ? 8 : 0),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedFrequency = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0x33F9A826)
                                  : const Color(0x1AFFFFFF),
                              borderRadius: BorderRadius.circular(12),
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: selected
                                        ? AppColors.amber
                                        : Colors.white,
                                  ),
                                ),
                                Text(
                                  freq.name,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 11,
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
                const SizedBox(height: 8),
                // Row 2: remaining 2 frequencies
                Row(
                  children: List.generate(2, (i) {
                    final idx = i + 3;
                    final freq = _frequencies[idx];
                    final selected = idx == _selectedFrequency;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: i < 1 ? 8 : 0),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedFrequency = idx),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              color: selected
                                  ? const Color(0x33F9A826)
                                  : const Color(0x1AFFFFFF),
                              borderRadius: BorderRadius.circular(12),
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
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: selected
                                        ? AppColors.amber
                                        : Colors.white,
                                  ),
                                ),
                                Text(
                                  freq.name,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 11,
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
                const SizedBox(height: 24),

                // ── Soundscape ───────────────────────────────────────────
                const SectionLabel('PAISAJE SONORO'),
                const SizedBox(height: 12),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(_landscapes.length, (i) {
                      final ls = _landscapes[i];
                      final selected = i == _selectedLandscape;
                      return Padding(
                        padding: EdgeInsets.only(
                          right: i < _landscapes.length - 1 ? 8 : 0,
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedLandscape = i),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.primary
                                  : const Color(0x1AFFFFFF),
                              borderRadius: BorderRadius.circular(50),
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
                                  size: 14,
                                  color: selected
                                      ? Colors.white
                                      : const Color(0xAAFFFFFF),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  ls.label,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 13,
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
                const SizedBox(height: 24),

                // ── Mantra input ─────────────────────────────────────────
                const SectionLabel('TU MANTRA'),
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0x1AFFFFFF),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0x26FFFFFF)),
                  ),
                  child: TextField(
                    controller: _mantraController,
                    maxLines: 3,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    decoration: InputDecoration(
                      hintText:
                          'Escribe tu intención o afirmación...',
                      hintStyle: GoogleFonts.urbanist(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.all(16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ── Voice recording card ─────────────────────────────────
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0x146C5CE7),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: const Color(0x666C5CE7)),
                  ),
                  child: Column(
                    children: [
                      // Top row
                      Row(
                        children: [
                          Text(
                            'GRABACIÓN DE VOZ',
                            style: GoogleFonts.urbanist(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.5,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.mint.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: AppColors.mint,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  'Listo',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.mint,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Center: mic + info
                      Row(
                        children: [
                          Icon(
                            LucideIcons.mic,
                            color: AppColors.primaryLight,
                            size: 32,
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Tu voz clonada activa',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Graba 10 seg · Calidad 82% · Mi Voz',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 12,
                                    color: AppColors.textTertiary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      // Waveform bars
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildWaveform(),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // ── CTA ──────────────────────────────────────────────────
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: double.infinity,
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryButton,
                      borderRadius: BorderRadius.circular(27),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.40),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(LucideIcons.mic, color: Colors.white, size: 20),
                        const SizedBox(width: 10),
                        Text(
                          'Graba tu voz · Activa ahora',
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
                const SizedBox(height: 16),
                // Save for later
                Center(
                  child: Text(
                    'Guardar para después',
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.66),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildWaveform() {
    const heights = [8.0, 14.0, 20.0, 12.0, 24.0, 10.0, 18.0, 14.0, 22.0, 10.0, 16.0, 8.0];
    return heights
        .map(
          (h) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2),
            child: Container(
              width: 4,
              height: h,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        )
        .toList();
  }
}

// Private data classes for chip configuration
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
