import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

void _showProximamente(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Próximamente', style: GoogleFonts.urbanist()),
      backgroundColor: AppColors.primary,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  );
}

class MirrorHoursScreen extends StatefulWidget {
  const MirrorHoursScreen({super.key});

  @override
  State<MirrorHoursScreen> createState() => _MirrorHoursScreenState();
}

class _MirrorHoursScreenState extends State<MirrorHoursScreen> {
  final List<bool> _active = [true, true, true, true, false];

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
                ScreenNav(
                  title: 'Horas Espejo',
                  showBack: true,
                  trailing: Container(
                    width: Responsive.w(36),
                    height: Responsive.w(36),
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surfaceBorderLight),
                    ),
                    child: Icon(
                      LucideIcons.info,
                      color: Colors.white,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(8)),
                Text(
                  'El universo te habla a través del tiempo',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(13),
                    color: AppColors.textTertiary,
                  ),
                ),
                SizedBox(height: Responsive.h(24)),
                const SectionLabel('PRÓXIMA HORA ESPEJO'),
                SizedBox(height: Responsive.h(12)),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(24), vertical: Responsive.h(28),
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryButton,
                    borderRadius: BorderRadius.circular(Responsive.w(20)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.4),
                        blurRadius: Responsive.w(24),
                        offset: Offset(0, Responsive.h(10)),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        '11:11',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(56),
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          height: 1.0,
                        ),
                      ),
                      SizedBox(height: Responsive.h(10)),
                      Text(
                        'Puerta de manifestación abierta',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(15),
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: Responsive.h(4)),
                      Text(
                        'en 2h 34min',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(13),
                          color: AppColors.white.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(28)),
                const SectionLabel('TODAS LAS HORAS ESPEJO'),
                SizedBox(height: Responsive.h(12)),
                _MirrorCard(
                  time: '11:11',
                  meaning: 'Puerta de manifestación · Pide un deseo',
                  voiceInfo: 'Voz Serena · Afirmación de poder',
                  active: _active[0],
                  highlighted: false,
                  onChanged: (v) => setState(() => _active[0] = v),
                ),
                SizedBox(height: Responsive.h(10)),
                _MirrorCard(
                  time: '12:12',
                  meaning: 'Renovación y nuevos comienzos',
                  voiceInfo: 'Voz Mi Voz · Código 520',
                  active: _active[1],
                  highlighted: false,
                  onChanged: (v) => setState(() => _active[1] = v),
                ),
                SizedBox(height: Responsive.h(10)),
                _MirrorCard(
                  time: '13:13',
                  meaning: 'Transformación alquímica en progreso',
                  voiceInfo: 'Voz Sabio · Mantra de Júpiter',
                  active: _active[2],
                  highlighted: false,
                  onChanged: (v) => setState(() => _active[2] = v),
                ),
                SizedBox(height: Responsive.h(10)),
                _MirrorCard(
                  time: '22:22',
                  meaning: 'La hora más poderosa del día',
                  voiceInfo: 'Voz Mi Voz · Código maestro 741852',
                  active: _active[3],
                  highlighted: true,
                  onChanged: (v) => setState(() => _active[3] = v),
                ),
                SizedBox(height: Responsive.h(10)),
                _MirrorCard(
                  time: '00:00',
                  meaning: 'Portal del infinito · Reset cósmico',
                  voiceInfo: 'Voz Osiain · Meditación de silencio',
                  active: _active[4],
                  highlighted: false,
                  onChanged: (v) => setState(() => _active[4] = v),
                ),
                SizedBox(height: Responsive.h(28)),
                GestureDetector(
                  onTap: () => _showProximamente(context),
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Responsive.h(16)),
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryButton,
                      borderRadius: BorderRadius.circular(Responsive.w(50)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.35),
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
                          'Crear hora espejo personalizada',
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
      ),
    );
  }
}

class _MirrorCard extends StatelessWidget {
  final String time;
  final String meaning;
  final String voiceInfo;
  final bool active;
  final bool highlighted;
  final ValueChanged<bool> onChanged;

  const _MirrorCard({
    required this.time,
    required this.meaning,
    required this.voiceInfo,
    required this.active,
    required this.highlighted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: highlighted
            ? AppColors.primary.withValues(alpha: 0.15)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(Responsive.w(16)),
        border: Border.all(
          color: highlighted
              ? AppColors.primary.withValues(alpha: 0.4)
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
                  fontSize: Responsive.sp(24),
                  fontWeight: FontWeight.w800,
                  color: highlighted ? AppColors.primaryLight : Colors.white,
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
                  meaning,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(13),
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Responsive.h(3)),
                Text(
                  voiceInfo,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(11),
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: Responsive.w(8)),
          Switch(
            value: active,
            onChanged: onChanged,
            activeThumbColor: AppColors.primary,
            activeTrackColor: AppColors.primary.withValues(alpha: 0.35),
            inactiveThumbColor: AppColors.textTertiary,
            inactiveTrackColor: AppColors.white.withValues(alpha: 0.08),
          ),
        ],
      ),
    );
  }
}
