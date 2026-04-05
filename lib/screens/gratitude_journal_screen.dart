import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

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
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  Responsive.w(20), Responsive.h(20), Responsive.w(20), 0,
                ),
                child: Row(
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
                        'Diario de Gratitud',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(17),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: Responsive.w(36),
                        height: Responsive.w(36),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.surfaceBorderLight,
                          ),
                        ),
                        child: Icon(
                          LucideIcons.calendar,
                          color: Colors.white,
                          size: Responsive.w(17),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(
                    Responsive.w(20), Responsive.h(24), Responsive.w(20), Responsive.h(32),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(20),
                          vertical: Responsive.h(14),
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
                          borderRadius: BorderRadius.circular(Responsive.w(16)),
                          border: Border.all(
                            color: AppColors.gold.withValues(alpha: 0.25),
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              LucideIcons.flame,
                              color: AppColors.gold,
                              size: Responsive.w(20),
                            ),
                            SizedBox(width: Responsive.w(10)),
                            Expanded(
                              child: Text(
                                '21 días escribiendo · Racha activa',
                                style: GoogleFonts.urbanist(
                                  fontSize: Responsive.sp(14),
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.gold,
                                ),
                              ),
                            ),
                            Text(
                              '🔥',
                              style: TextStyle(fontSize: Responsive.sp(20)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Responsive.h(24)),
                      Row(
                        children: [
                          Icon(
                            LucideIcons.sun,
                            color: AppColors.gold,
                            size: Responsive.w(16),
                          ),
                          SizedBox(width: Responsive.w(8)),
                          Text(
                            'ENTRADA DE HOY',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(11),
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '15 Mar 2026',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(12),
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: Responsive.h(12)),
                      Text(
                        '3 cosas por las que agradeces hoy',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(16),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: Responsive.h(12)),
                      ...List.generate(3, (i) => _GratitudeInput(
                        number: i + 1,
                        hint: _prompts[i],
                        controller: _controllers[i],
                      )),
                      SizedBox(height: Responsive.h(16)),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: Responsive.h(52),
                          decoration: BoxDecoration(
                            gradient: AppGradients.goldButton,
                            borderRadius: BorderRadius.circular(Responsive.w(14)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gold.withValues(alpha: 0.35),
                                blurRadius: Responsive.w(16),
                                offset: Offset(0, Responsive.h(6)),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Guardar entrada de hoy',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(15),
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF1A0A00),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(28)),
                      Text(
                        'HISTORIAL',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(11),
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      SizedBox(height: Responsive.h(12)),
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
      padding: EdgeInsets.only(bottom: Responsive.h(10)),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(14)),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(Responsive.w(14)),
          border: Border.all(color: AppColors.surfaceBorderLight),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: Responsive.w(26),
              height: Responsive.w(26),
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
                    fontSize: Responsive.sp(12),
                    fontWeight: FontWeight.w700,
                    color: AppColors.gold,
                  ),
                ),
              ),
            ),
            SizedBox(width: Responsive.w(12)),
            Expanded(
              child: TextField(
                controller: controller,
                style: GoogleFonts.urbanist(
                  fontSize: Responsive.sp(14),
                  color: Colors.white,
                ),
                maxLines: null,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(13),
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
      padding: EdgeInsets.only(bottom: Responsive.h(8)),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(14)),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          border: Border.all(color: AppColors.surfaceBorderLight),
        ),
        child: Row(
          children: [
            Container(
              width: Responsive.w(38),
              height: Responsive.w(38),
              decoration: BoxDecoration(
                color: AppColors.gold.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(Responsive.w(10)),
              ),
              child: Icon(
                LucideIcons.bookOpen,
                color: AppColors.gold,
                size: Responsive.w(16),
              ),
            ),
            SizedBox(width: Responsive.w(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    entry.date,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(11),
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                    ),
                  ),
                  SizedBox(height: Responsive.h(3)),
                  Text(
                    entry.preview,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(13),
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
              size: Responsive.w(16),
            ),
          ],
        ),
      ),
    );
  }
}
