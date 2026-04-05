import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

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
                        'Tehilim 27',
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
                          LucideIcons.bookmark,
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
                    children: [
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(Responsive.w(20)),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              AppColors.gold.withValues(alpha: 0.15),
                              AppColors.primary.withValues(alpha: 0.08),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(Responsive.w(20)),
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
                                  size: Responsive.w(14),
                                ),
                                SizedBox(width: Responsive.w(8)),
                                Text(
                                  'VERSO DEL DÍA',
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(10),
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 2.0,
                                    color: AppColors.gold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: Responsive.h(14)),
                            Text(
                              _hebrewText,
                              style: TextStyle(
                                fontSize: Responsive.sp(18),
                                color: Colors.white,
                                height: 2.0,
                                fontFamily: 'serif',
                              ),
                              textAlign: TextAlign.center,
                              textDirection: TextDirection.rtl,
                            ),
                            SizedBox(height: Responsive.h(12)),
                            Container(
                              height: 1,
                              color: AppColors.white.withValues(alpha: 0.1),
                            ),
                            SizedBox(height: Responsive.h(12)),
                            Text(
                              _spanishText,
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(14),
                                color: AppColors.textTertiary,
                                height: 1.6,
                                fontStyle: FontStyle.italic,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Responsive.h(20)),
                      Container(
                        padding: EdgeInsets.all(Responsive.w(16)),
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.05),
                          borderRadius: BorderRadius.circular(Responsive.w(16)),
                          border: Border.all(color: AppColors.surfaceBorderLight),
                        ),
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  setState(() => _isPlaying = !_isPlaying),
                              child: Container(
                                width: Responsive.w(50),
                                height: Responsive.w(50),
                                decoration: BoxDecoration(
                                  gradient: AppGradients.goldButton,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.gold.withValues(
                                        alpha: 0.4,
                                      ),
                                      blurRadius: Responsive.w(16),
                                      offset: Offset(0, Responsive.h(4)),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  _isPlaying
                                      ? LucideIcons.pause
                                      : LucideIcons.play,
                                  color: const Color(0xFF1A0A00),
                                  size: Responsive.w(22),
                                ),
                              ),
                            ),
                            SizedBox(width: Responsive.w(14)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Recitación de Tehilim 27',
                                    style: GoogleFonts.urbanist(
                                      fontSize: Responsive.sp(13),
                                      fontWeight: FontWeight.w600,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: Responsive.h(4)),
                                  Text(
                                    'Maestro David · 4:32',
                                    style: GoogleFonts.urbanist(
                                      fontSize: Responsive.sp(12),
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                  SizedBox(height: Responsive.h(8)),
                                  LinearProgressIndicator(
                                    value: 0.3,
                                    backgroundColor: AppColors.white.withValues(
                                      alpha: 0.1,
                                    ),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.gold,
                                    ),
                                    borderRadius: BorderRadius.circular(Responsive.w(2)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Responsive.h(20)),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'VERSOS',
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(11),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.0,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ),
                      SizedBox(height: Responsive.h(12)),
                      ..._verses.map((v) => _VerseCard(verse: v)),
                      SizedBox(height: Responsive.h(20)),
                      GestureDetector(
                        onTap: () => setState(
                          () => _isMeaningExpanded = !_isMeaningExpanded,
                        ),
                        child: Container(
                          padding: EdgeInsets.all(Responsive.w(16)),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(Responsive.w(14)),
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
                                    size: Responsive.w(18),
                                  ),
                                  SizedBox(width: Responsive.w(10)),
                                  Expanded(
                                    child: Text(
                                      'Significado espiritual',
                                      style: GoogleFonts.urbanist(
                                        fontSize: Responsive.sp(14),
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
                                      size: Responsive.w(18),
                                    ),
                                  ),
                                ],
                              ),
                              AnimatedSize(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                                child: _isMeaningExpanded
                                    ? Padding(
                                        padding: EdgeInsets.only(top: Responsive.h(12)),
                                        child: Text(
                                          _meaning,
                                          style: GoogleFonts.urbanist(
                                            fontSize: Responsive.sp(13),
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
                      SizedBox(height: Responsive.h(20)),
                      GestureDetector(
                        onTap: () => context.push('/sessions'),
                        child: Container(
                          width: double.infinity,
                          height: Responsive.h(54),
                          decoration: BoxDecoration(
                            gradient: AppGradients.primaryButton,
                            borderRadius: BorderRadius.circular(Responsive.w(14)),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: Responsive.w(18),
                                offset: Offset(0, Responsive.h(6)),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              'Reservar sesión de Tehilim',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(15),
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
      padding: EdgeInsets.only(bottom: Responsive.h(8)),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(14)),
        decoration: BoxDecoration(
          color: AppColors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(Responsive.w(12)),
          border: Border.all(color: AppColors.surfaceBorderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              verse.ref,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(11),
                fontWeight: FontWeight.w700,
                color: AppColors.gold,
              ),
            ),
            SizedBox(height: Responsive.h(6)),
            Text(
              verse.hebrew,
              style: TextStyle(
                fontSize: Responsive.sp(15),
                color: Colors.white,
                height: 1.8,
              ),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: Responsive.h(4)),
            Text(
              verse.spanish,
              style: GoogleFonts.urbanist(
                fontSize: Responsive.sp(13),
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
