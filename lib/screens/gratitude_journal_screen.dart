import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class GratitudeJournalScreen extends StatefulWidget {
  const GratitudeJournalScreen({super.key});

  @override
  State<GratitudeJournalScreen> createState() => _GratitudeJournalScreenState();
}

class _GratitudeJournalScreenState extends State<GratitudeJournalScreen> {
  final List<TextEditingController> _controllers = List.generate(
    3,
    (_) => TextEditingController(),
  );

  static const List<_PastEntry> _pastEntries = [
    _PastEntry('14 Mar 2026', 'Gratitud por mi familia, salud y oportunidades'),
    _PastEntry('13 Mar 2026', 'Agradezco la meditación de hoy y la paz interior'),
    _PastEntry('12 Mar 2026', 'Gracias por cada momento de crecimiento personal'),
    _PastEntry('11 Mar 2026', 'Gratitud por los amigos y el apoyo que recibo'),
    _PastEntry('10 Mar 2026', 'Agradezco la abundancia que fluye en mi vida'),
  ];

  static const List<String> _prompts = [
    '¿Qué persona te llenó de gratitud hoy?',
    '¿Qué experiencia agradeces que pasó hoy?',
    '¿Qué aspecto de ti mismo agradeces?',
  ];

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          child: Column(
            children: [
              // ── Header ──────────────────────────────────────────────
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Row(
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
                        'Diario de Gratitud',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surfaceBorderLight,
                          ),
                        ),
                        child: const Icon(
                          LucideIcons.calendar,
                          color: Colors.white,
                          size: 17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ── Stats ────────────────────────────────────────
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              AppColors.gold.withValues(alpha: 0.15),
                              AppColors.amber.withValues(alpha: 0.08),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.gold.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LucideIcons.flame,
                              color: AppColors.gold,
                              size: 20,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                '21 días escribiendo · Racha activa',
                                style: GoogleFonts.urbanist(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.gold,
                                ),
                              ),
                            ),
                            Text(
                              '🔥',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Today's entry ────────────────────────────────
                      Row(
                        children: [
                          Icon(
                            LucideIcons.sun,
                            color: AppColors.gold,
                            size: 16,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'ENTRADA DE HOY',
                            style: GoogleFonts.urbanist(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '15 Mar 2026',
                            style: GoogleFonts.urbanist(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),

                      // ── 3 prompts ────────────────────────────────────
                      Text(
                        '3 cosas por las que agradeces hoy',
                        style: GoogleFonts.urbanist(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...List.generate(3, (i) => _GratitudeInput(
                        number: i + 1,
                        hint: _prompts[i],
                        controller: _controllers[i],
                      )),
                      const SizedBox(height: 16),

                      // ── Save button ──────────────────────────────────
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            gradient: AppGradients.goldButton,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gold.withValues(alpha: 0.35),
                                blurRadius: 16,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Guardar entrada de hoy',
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A0A00),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // ── History label ────────────────────────────────
                      Text(
                        'HISTORIAL',
                        style: GoogleFonts.urbanist(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // ── Past entries ─────────────────────────────────
                      ..._pastEntries.map((e) => _HistoryCard(entry: e)),
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

class _PastEntry {
  final String date;
  final String preview;

  const _PastEntry(this.date, this.preview);
}

class _GratitudeInput extends StatelessWidget {
  final int number;
  final String hint;
  final TextEditingController controller;

  const _GratitudeInput({
    required this.number,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.surfaceBorderLight),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.2),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.gold.withValues(alpha: 0.4),
                ),
              ),
              child: Center(
                child: Text(
                  '$number',
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppColors.gold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: controller,
                style: GoogleFonts.urbanist(
                  fontSize: 14,
                  color: Colors.white,
                ),
                maxLines: null,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: GoogleFonts.urbanist(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  final _PastEntry entry;

  const _HistoryCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.surfaceBorderLight),
        ),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                LucideIcons.bookOpen,
                color: AppColors.gold,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.date,
                    style: GoogleFonts.urbanist(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    entry.preview,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      color: AppColors.textTertiary,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              color: AppColors.textMuted,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
