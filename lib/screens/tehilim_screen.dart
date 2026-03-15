import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class TehilimScreen extends StatefulWidget {
  const TehilimScreen({super.key});

  @override
  State<TehilimScreen> createState() => _TehilimScreenState();
}

class _TehilimScreenState extends State<TehilimScreen> {
  bool _isPlaying = false;
  bool _isMeaningExpanded = false;

  static const String _hebrewText =
      'יְהוָ֤ה ׀ אוֹרִ֣י וְ֭יִשְׁעִי מִמִּ֣י אִירָ֑א יְהוָ֥ה מָֽעוֹז־חַ֝יַּ֗י מִמִּ֥י אֶפְחָֽד׃';

  static const String _spanishText =
      'El Señor es mi luz y mi salvación; ¿a quién temeré? El Señor es la fortaleza de mi vida; ¿de quién me he de atemorizar?';

  static const String _meaning =
      'El Salmo 27 es una de las oraciones más poderosas de la Cábala. '
      'Su recitación diaria durante el mes de Elul y los diez días de penitencia '
      'activa protección divina, claridad mental y conexión espiritual profunda. '
      'La palabra "Or" (luz) aparece en el primer verso, simbolizando la iluminación '
      'del alma y la guía divina en momentos de oscuridad.';

  static const List<_Verse> _verses = [
    _Verse(
      '27:1',
      'יְהוָ֤ה ׀ אוֹרִ֣י וְ֭יִשְׁעִי',
      'El Señor es mi luz y salvación',
    ),
    _Verse(
      '27:2',
      'בִּקְרֹ֤ב עָלַ֨י ׀ מְרֵעִים',
      'Cuando se acercan contra mí los malignos',
    ),
    _Verse(
      '27:3',
      'אִם־תַּחֲנֶ֬ה עָלַ֨י ׀ מַחֲנֶ֗ה',
      'Aunque un ejército acampe contra mí',
    ),
    _Verse(
      '27:4',
      'אַחַ֤ת ׀ שָׁאַ֣לְתִּי מֵֽאֵת־יְהוָה',
      'Una cosa he pedido al Señor',
    ),
  ];

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
                        'Tehilim 27',
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
                          LucideIcons.bookmark,
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
                    children: [
                      // ── Daily verse highlight ─────────────────────────
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.gold.withValues(alpha: 0.15),
                              AppColors.primary.withValues(alpha: 0.08),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.gold.withValues(alpha: 0.3),
                          ),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LucideIcons.star,
                                  color: AppColors.gold,
                                  size: 14,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'VERSO DEL DÍA',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0,
                                    color: AppColors.gold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 14),
                            // Hebrew
                            Text(
                              _hebrewText,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                height: 2.0,
                                fontFamily: 'serif',
                              ),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                            const SizedBox(height: 12),
                            Container(
                              height: 1,
                              color: AppColors.white.withValues(alpha: 0.1),
                            ),
                            const SizedBox(height: 12),
                            // Spanish
                            Text(
                              _spanishText,
                              style: GoogleFonts.urbanist(
                                fontSize: 14,
                                color: AppColors.textTertiary,
                                height: 1.6,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Audio player ──────────────────────────────────
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.surfaceBorderLight),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  setState(() => _isPlaying = !_isPlaying),
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  gradient: AppGradients.goldButton,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.gold.withValues(
                                        alpha: 0.4,
                                      ),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  _isPlaying
                                      ? LucideIcons.pause
                                      : LucideIcons.play,
                                  color: const Color(0xFF1A0A00),
                                  size: 22,
                                ),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recitación de Tehilim 27',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Maestro David · 4:32',
                                    style: GoogleFonts.urbanist(
                                      fontSize: 12,
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  LinearProgressIndicator(
                                    value: 0.3,
                                    backgroundColor: AppColors.white.withValues(
                                      alpha: 0.1,
                                    ),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.gold,
                                    ),
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── Verse list ────────────────────────────────────
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'VERSOS',
                          style: GoogleFonts.urbanist(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.0,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ..._verses.map((v) => _VerseCard(verse: v)),
                      const SizedBox(height: 20),

                      // ── Expandable meaning ────────────────────────────
                      GestureDetector(
                        onTap: () => setState(
                          () => _isMeaningExpanded = !_isMeaningExpanded,
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(
                              color: AppColors.primary.withValues(alpha: 0.25),
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    LucideIcons.bookOpen,
                                    color: AppColors.primaryLight,
                                    size: 18,
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Significado espiritual',
                                      style: GoogleFonts.urbanist(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  AnimatedRotation(
                                    turns:
                                        _isMeaningExpanded ? 0.5 : 0.0,
                                    duration: const Duration(milliseconds: 200),
                                    child: Icon(
                                      LucideIcons.chevronDown,
                                      color: AppColors.textMuted,
                                      size: 18,
                                    ),
                                  ),
                                ],
                              ),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                                child: _isMeaningExpanded
                                    ? Padding(
                                        padding: const EdgeInsets.only(top: 12),
                                        child: Text(
                                          _meaning,
                                          style: GoogleFonts.urbanist(
                                            fontSize: 13,
                                            color: AppColors.textTertiary,
                                            height: 1.6,
                                          ),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ── CTA ──────────────────────────────────────────
                      GestureDetector(
                        onTap: () => context.push('/sessions'),
                        child: Container(
                          width: double.infinity,
                          height: 54,
                          decoration: BoxDecoration(
                            gradient: AppGradients.primaryButton,
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 18,
                                offset: const Offset(0, 6),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Reservar sesión de Tehilim',
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
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

class _Verse {
  final String ref;
  final String hebrew;
  final String spanish;

  const _Verse(this.ref, this.hebrew, this.spanish);
}

class _VerseCard extends StatelessWidget {
  final _Verse verse;

  const _VerseCard({required this.verse});

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              verse.ref,
              style: GoogleFonts.urbanist(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.gold,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              verse.hebrew,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                height: 1.8,
              ),
              textDirection: TextDirection.rtl,
            ),
            const SizedBox(height: 4),
            Text(
              verse.spanish,
              style: GoogleFonts.urbanist(
                fontSize: 13,
                color: AppColors.textTertiary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
