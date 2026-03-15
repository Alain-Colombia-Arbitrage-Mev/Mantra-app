import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';

class LunarRitualsScreen extends StatefulWidget {
  const LunarRitualsScreen({super.key});

  @override
  State<LunarRitualsScreen> createState() => _LunarRitualsScreenState();
}

class _LunarRitualsScreenState extends State<LunarRitualsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedPhase = 3; // Llena
  late final AnimationController _pulseCtrl;
  late final Animation<double> _pulseAnim;

  static const List<String> _phases = [
    'Nueva',
    'Creciente',
    'Cuarto C.',
    'Llena',
    'Menguante',
    'Balsámica',
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F0A2A), Color(0xFF0A0A1A)],
          ),
        ),
        child: Stack(
          children: [
            // Lunar blue glow
            Positioned(
              top: 80,
              left: -60,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.lunar.withValues(alpha: 0.14),
                      blurRadius: 130,
                      spreadRadius: 65,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // ── Header ──────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
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
                            'Rituales Lunares',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Container(
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
                            LucideIcons.bell,
                            color: Colors.white,
                            size: 17,
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
                          // ── Hero image ──────────────────────────────────
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Outer ring
                              Container(
                                width: 210,
                                height: 210,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.lunar.withValues(
                                      alpha: 0.15,
                                    ),
                                    width: 1,
                                  ),
                                ),
                              ),
                              // Inner ring
                              Container(
                                width: 192,
                                height: 192,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.lunar.withValues(
                                      alpha: 0.25,
                                    ),
                                    width: 1,
                                  ),
                                ),
                              ),
                              // Hero
                              Container(
                                width: 180,
                                height: 180,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppColors.lunar.withValues(
                                        alpha: 0.25,
                                      ),
                                      blurRadius: 30,
                                      spreadRadius: 8,
                                    ),
                                  ],
                                ),
                                child: ClipOval(
                                  child: Image.asset(
                                    'assets/images/lunar_hero.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // ── FASE ACTUAL label ───────────────────────────
                          Text(
                            'FASE ACTUAL',
                            style: GoogleFonts.urbanist(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              color: AppColors.lunar.withValues(alpha: 0.67),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Luna Llena 🌕',
                            style: GoogleFonts.urbanist(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'La luna llena amplifica la energía, intuición\ny emociones. Momento ideal para rituales\nde gratitud y liberación.',
                            style: GoogleFonts.urbanist(
                              fontSize: 13,
                              color: AppColors.textTertiary,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),

                          // ── Phase chips ─────────────────────────────────
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(_phases.length, (i) {
                                final isSelected = i == _selectedPhase;
                                return GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedPhase = i),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 180),
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? AppColors.lunar.withValues(
                                              alpha: 0.2,
                                            )
                                          : AppColors.surfaceLight,
                                      borderRadius: BorderRadius.circular(50),
                                      border: Border.all(
                                        color: isSelected
                                            ? AppColors.lunar
                                            : AppColors.surfaceBorderLight,
                                      ),
                                    ),
                                    child: Text(
                                      _phases[i],
                                      style: GoogleFonts.urbanist(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: isSelected
                                            ? AppColors.lunar
                                            : AppColors.textTertiary,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // ── Rituales label ──────────────────────────────
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Rituales recomendados',
                              style: GoogleFonts.urbanist(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),

                          // ── Ritual cards ────────────────────────────────
                          _RitualCard(
                            icon: LucideIcons.heart,
                            iconColor: AppColors.mint,
                            title: 'Ritual de gratitud',
                            subtitle: '15 min · Meditación guiada',
                            isPro: false,
                          ),
                          const SizedBox(height: 8),
                          _RitualCard(
                            icon: LucideIcons.flame,
                            iconColor: AppColors.amber,
                            title: 'Ceremonia de liberación',
                            subtitle: '25 min · Meditación + sonido',
                            isPro: true,
                          ),
                          const SizedBox(height: 8),
                          _RitualCard(
                            icon: LucideIcons.moon,
                            iconColor: AppColors.lunar,
                            title: 'Baño de luna',
                            subtitle: '30 min · Práctica física',
                            isPro: false,
                          ),
                          const SizedBox(height: 20),

                          // ── Live indicator ──────────────────────────────
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.lunar.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.lunar.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                AnimatedBuilder(
                                  animation: _pulseAnim,
                                  builder: (_, __) => Container(
                                    width: 8,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: AppColors.lunar.withValues(
                                        alpha: _pulseAnim.value,
                                      ),
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  '1,203 personas meditando bajo la luna',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.lunar,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ── CTA ──────────────────────────────────────────
                          GestureDetector(
                            onTap: () => context.push('/notifications-settings'),
                            child: Container(
                              width: double.infinity,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: AppGradients.primaryButton,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.4,
                                    ),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Activar recordatorios lunares',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 16,
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
          ],
        ),
      ),
    );
  }
}

class _RitualCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final bool isPro;

  const _RitualCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.isPro,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceBorderLight),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: iconColor.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (isPro)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                gradient: AppGradients.primaryButton,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                'PRO',
                style: GoogleFonts.urbanist(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          const SizedBox(width: 8),
          Icon(LucideIcons.chevronRight, color: AppColors.textMuted, size: 18),
        ],
      ),
    );
  }
}
