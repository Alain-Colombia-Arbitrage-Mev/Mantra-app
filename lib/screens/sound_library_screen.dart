import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class SoundLibraryScreen extends StatefulWidget {
  const SoundLibraryScreen({super.key});

  @override
  State<SoundLibraryScreen> createState() => _SoundLibraryScreenState();
}

class _SoundLibraryScreenState extends State<SoundLibraryScreen> {
  int _selectedCategory = 0;

  static const List<String> categories = [
    'Todos',
    'Solfeggio',
    'Binaurales',
    'Naturaleza',
    'Mantras',
  ];

  static const List<_FreqCard> frequencies = [
    _FreqCard('174', 'Fundación', 'Reduce dolor · Seguridad', false),
    _FreqCard('285', 'Sanación', 'Regenera tejidos · Vitalidad', false),
    _FreqCard('396', 'Liberación', 'Libera culpa · Enraizamiento', false),
    _FreqCard('417', 'Cambio', 'Facilita cambios · Renovación', false),
    _FreqCard('528', 'Amor', 'ADN · Milagros · Transformación', true),
    _FreqCard('639', 'Conexión', 'Relaciones · Armonía social', false),
  ];

  static const List<_NatureCard> natures = [
    _NatureCard(LucideIcons.cloudRain, 'Lluvia', '8:00 min'),
    _NatureCard(LucideIcons.waves, 'Océano', '10:00 min'),
    _NatureCard(LucideIcons.trees, 'Bosque', '12:00 min'),
    _NatureCard(LucideIcons.flame, 'Fuego', '6:00 min'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
                ScreenNav(
                  title: 'Biblioteca de Sonidos',
                  showBack: true,
                  trailing: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.white.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.surfaceBorderLight),
                    ),
                    child: const Icon(
                      LucideIcons.search,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // ── Category chips ───────────────────────────────────────
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(categories.length, (i) {
                      final selected = i == _selectedCategory;
                      return Padding(
                        padding: EdgeInsets.only(
                          right: i < categories.length - 1 ? 8 : 0,
                        ),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedCategory = i),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: selected
                                  ? AppGradients.primaryButton
                                  : null,
                              color:
                                  selected ? null : AppColors.surfaceLight,
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                color: selected
                                    ? Colors.transparent
                                    : AppColors.surfaceBorderLight,
                              ),
                            ),
                            child: Text(
                              categories[i],
                              style: GoogleFonts.urbanist(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(height: 24),

                // ── Solfeggio label ──────────────────────────────────────
                const SectionLabel('FRECUENCIAS SOLFEGGIO'),
                const SizedBox(height: 12),

                ...frequencies.map((f) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _FrequencyCard(data: f),
                    )),
                const SizedBox(height: 16),

                // ── Nature label ─────────────────────────────────────────
                const SectionLabel('SONIDOS DE NATURALEZA'),
                const SizedBox(height: 12),

                ...natures.map((n) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: _NatureCardWidget(data: n),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _FreqCard {
  final String hz;
  final String name;
  final String desc;
  final bool highlighted;
  const _FreqCard(this.hz, this.name, this.desc, this.highlighted);
}

class _NatureCard {
  final IconData icon;
  final String name;
  final String duration;
  const _NatureCard(this.icon, this.name, this.duration);
}

class _FrequencyCard extends StatelessWidget {
  final _FreqCard data;
  const _FrequencyCard({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: data.highlighted
            ? AppColors.primary.withValues(alpha: 0.15)
            : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: data.highlighted
              ? AppColors.primary.withValues(alpha: 0.4)
              : AppColors.surfaceBorderLight,
          width: data.highlighted ? 1.5 : 1,
        ),
      ),
      child: Row(
        children: [
          // Hz number badge
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: data.highlighted
                  ? AppColors.primary.withValues(alpha: 0.3)
                  : AppColors.white.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  data.hz,
                  style: GoogleFonts.urbanist(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: data.highlighted
                        ? AppColors.primaryLight
                        : Colors.white,
                  ),
                ),
                Text(
                  'Hz',
                  style: GoogleFonts.urbanist(
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Name + desc
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data.name,
                  style: GoogleFonts.urbanist(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  data.desc,
                  style: GoogleFonts.urbanist(
                    fontSize: 12,
                    color: AppColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          // Play button
          GestureDetector(
            onTap: () => context.push('/player'),
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: data.highlighted
                    ? AppGradients.primaryButton
                    : null,
                color: data.highlighted
                    ? null
                    : AppColors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.play,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NatureCardWidget extends StatelessWidget {
  final _NatureCard data;
  const _NatureCardWidget({required this.data});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.mint.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.mint.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(data.icon, color: AppColors.mint, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              data.name,
              style: GoogleFonts.urbanist(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            data.duration,
            style: GoogleFonts.urbanist(
              fontSize: 12,
              color: AppColors.textTertiary,
            ),
          ),
          const SizedBox(width: 12),
          GestureDetector(
            onTap: () => context.push('/player'),
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.play,
                color: Colors.white,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
