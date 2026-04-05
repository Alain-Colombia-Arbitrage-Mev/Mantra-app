import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

class BookSessionScreen extends StatefulWidget {
  const BookSessionScreen({super.key});

  @override
  State<BookSessionScreen> createState() => _BookSessionScreenState();
}

class _BookSessionScreenState extends State<BookSessionScreen> {
  int _selectedGuide = 0;
  int _selectedType = 0;
  int _selectedDay = 2;
  int _selectedTime = 1;
  int _selectedPlatform = 0;

  static const List<String> guides = ['David', 'Sarah', 'Moisés'];
  static const List<_SessionType> sessionTypes = [
    _SessionType(
      'Meditación Guiada',
      '45 min · Theta · Manifestación',
    ),
    _SessionType(
      'Bio-Resonancia',
      '30 min · Healing · 528Hz',
    ),
    _SessionType(
      'Lectura de Tehilim',
      '20 min · Protección · Shajarit',
    ),
  ];
  static const List<_DaySlot> days = [
    _DaySlot('Lun', '17'),
    _DaySlot('Mar', '18'),
    _DaySlot('Mie', '19'),
    _DaySlot('Jue', '20'),
    _DaySlot('Vie', '21'),
  ];
  static const List<String> times = ['09:00', '10:00', '14:00', '16:00'];
  static const List<String> platforms = ['Zoom', 'Presencial'];

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(32)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
                const ScreenNav(
                  title: 'Reservar Sesión',
                  showBack: true,
                ),
                SizedBox(height: Responsive.h(28)),

                // ── Elige tu guía ────────────────────────────────────────
                const SectionLabel('ELIGE TU GUÍA'),
                SizedBox(height: Responsive.h(12)),
                Row(
                  children: List.generate(guides.length, (i) {
                    final selected = i == _selectedGuide;
                    return Padding(
                      padding: EdgeInsets.only(right: i < guides.length - 1 ? Responsive.w(8) : 0),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedGuide = i),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.w(16),
                            vertical: Responsive.h(10),
                          ),
                          decoration: BoxDecoration(
                            gradient: selected ? AppGradients.primaryButton : null,
                            color: selected ? null : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: selected
                                  ? Colors.transparent
                                  : AppColors.surfaceBorderLight,
                            ),
                          ),
                          child: Text(
                            guides[i],
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(14),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Tipo de sesión ───────────────────────────────────────
                const SectionLabel('TIPO DE SESIÓN'),
                SizedBox(height: Responsive.h(12)),
                ...List.generate(sessionTypes.length, (i) {
                  final selected = i == _selectedType;
                  return Padding(
                    padding: EdgeInsets.only(bottom: i < sessionTypes.length - 1 ? Responsive.h(8) : 0),
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedType = i),
                      child: Container(
                        padding: EdgeInsets.all(Responsive.w(16)),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: selected
                                ? AppColors.primary
                                : AppColors.surfaceBorderLight,
                            width: selected ? 1.5 : 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    sessionTypes[i].name,
                                    style: GoogleFonts.urbanist(
                                      fontSize: Responsive.sp(15),
                                      fontWeight: FontWeight.w700,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: Responsive.h(2)),
                                  Text(
                                    sessionTypes[i].detail,
                                    style: GoogleFonts.urbanist(
                                      fontSize: Responsive.sp(12),
                                      color: AppColors.textTertiary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (selected)
                              Container(
                                width: Responsive.w(20),
                                height: Responsive.w(20),
                                decoration: const BoxDecoration(
                                  gradient: AppGradients.primaryButton,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: Responsive.w(13),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                SizedBox(height: Responsive.h(24)),

                // ── Fecha y hora ─────────────────────────────────────────
                const SectionLabel('FECHA Y HORA'),
                SizedBox(height: Responsive.h(12)),
                Row(
                  children: List.generate(days.length, (i) {
                    final selected = i == _selectedDay;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: i < days.length - 1 ? Responsive.w(6) : 0),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedDay = i),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: Responsive.h(10)),
                            decoration: BoxDecoration(
                              gradient:
                                  selected ? AppGradients.primaryButton : null,
                              color: selected ? null : AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: selected
                                    ? Colors.transparent
                                    : AppColors.surfaceBorderLight,
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  days[i].day,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(11),
                                    fontWeight: FontWeight.w600,
                                    color: selected
                                        ? Colors.white
                                        : AppColors.textTertiary,
                                  ),
                                ),
                                SizedBox(height: Responsive.h(2)),
                                Text(
                                  days[i].num,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(16),
                                    fontWeight: FontWeight.w800,
                                    color: Colors.white,
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
                SizedBox(height: Responsive.h(10)),
                Row(
                  children: List.generate(times.length, (i) {
                    final selected = i == _selectedTime;
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: i < times.length - 1 ? Responsive.w(6) : 0),
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedTime = i),
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: Responsive.h(10)),
                            decoration: BoxDecoration(
                              gradient:
                                  selected ? AppGradients.primaryButton : null,
                              color: selected ? null : AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: selected
                                    ? Colors.transparent
                                    : AppColors.surfaceBorderLight,
                              ),
                            ),
                            child: Text(
                              times[i],
                              textAlign: TextAlign.center,
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(14),
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Plataforma ───────────────────────────────────────────
                const SectionLabel('PLATAFORMA'),
                SizedBox(height: Responsive.h(12)),
                Row(
                  children: List.generate(platforms.length, (i) {
                    final selected = i == _selectedPlatform;
                    return Padding(
                      padding: EdgeInsets.only(right: i < platforms.length - 1 ? Responsive.w(8) : 0),
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedPlatform = i),
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.w(20),
                            vertical: Responsive.h(10),
                          ),
                          decoration: BoxDecoration(
                            gradient: selected ? AppGradients.primaryButton : null,
                            color: selected ? null : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(
                              color: selected
                                  ? Colors.transparent
                                  : AppColors.surfaceBorderLight,
                            ),
                          ),
                          child: Text(
                            platforms[i],
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(14),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Summary card ─────────────────────────────────────────
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Resumen',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(15),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: Responsive.h(12)),
                      _SummaryRow(
                        icon: LucideIcons.user,
                        label: 'Guía',
                        value: guides[_selectedGuide],
                      ),
                      SizedBox(height: Responsive.h(8)),
                      _SummaryRow(
                        icon: LucideIcons.music,
                        label: 'Sesión',
                        value: sessionTypes[_selectedType].name,
                      ),
                      SizedBox(height: Responsive.h(8)),
                      _SummaryRow(
                        icon: LucideIcons.calendar,
                        label: 'Fecha',
                        value: '${days[_selectedDay].day} ${days[_selectedDay].num}',
                      ),
                      SizedBox(height: Responsive.h(8)),
                      _SummaryRow(
                        icon: LucideIcons.clock,
                        label: 'Hora',
                        value: times[_selectedTime],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(20)),

                // ── CTA ──────────────────────────────────────────────────
                Container(
                  width: double.infinity,
                  height: Responsive.h(56),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryButton,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: Responsive.w(20),
                        offset: Offset(0, Responsive.h(8)),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: () => context.push('/agenda'),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Confirmar Reserva',
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(16),
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: Responsive.w(10)),
                          Icon(
                            LucideIcons.check,
                            color: Colors.white,
                            size: Responsive.w(18),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(16)),

                Center(
                  child: Text(
                    'Cancelación gratuita hasta 24h antes',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      color: AppColors.textSecondary,
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

class _SessionType {
  final String name;
  final String detail;
  const _SessionType(this.name, this.detail);
}

class _DaySlot {
  final String day;
  final String num;
  const _DaySlot(this.day, this.num);
}

class _SummaryRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _SummaryRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: Responsive.w(14), color: AppColors.primaryLight),
        SizedBox(width: Responsive.w(8)),
        Text(
          '$label: ',
          style: GoogleFonts.urbanist(
            fontSize: Responsive.sp(13),
            color: AppColors.textTertiary,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.urbanist(
            fontSize: Responsive.sp(13),
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
