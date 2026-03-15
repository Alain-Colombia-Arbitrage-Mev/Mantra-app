import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String _query = '';

  static const List<String> _recent = [
    'Meditación Theta',
    '528 Hz Abundancia',
    'Chakras alineación',
    'Rituales Luna Llena',
  ];

  static const List<_Category> _categories = [
    _Category('Meditación', LucideIcons.brain, Color(0xFF6C5CE7)),
    _Category('Frecuencias', LucideIcons.waves, Color(0xFF55EFC4)),
    _Category('Rituales', LucideIcons.moon, Color(0xFFC0C0FF)),
    _Category('Mantras', LucideIcons.music, Color(0xFFDDA0DD)),
    _Category('Chakras', LucideIcons.zap, Color(0xFFFFD700)),
    _Category('Sueño', LucideIcons.star, Color(0xFFA29BFE)),
  ];

  static const List<_TrendItem> _trending = [
    _TrendItem('1', 'Meditación para la ansiedad', '12.4k escuchas'),
    _TrendItem('2', '528 Hz · Reparación ADN', '9.8k escuchas'),
    _TrendItem('3', 'Luna Llena · Ritual de gratitud', '7.2k escuchas'),
  ];

  @override
  void dispose() {
    _controller.dispose();
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
              // ── Header ────────────────────────────────────────────────
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
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.white.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.surfaceBorderLight,
                          ),
                        ),
                        child: TextField(
                          controller: _controller,
                          autofocus: true,
                          onChanged: (v) => setState(() => _query = v),
                          style: GoogleFonts.urbanist(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Buscar meditaciones, frecuencias...',
                            hintStyle: GoogleFonts.urbanist(
                              fontSize: 14,
                              color: AppColors.textMuted,
                            ),
                            prefixIcon: Icon(
                              LucideIcons.search,
                              color: AppColors.textMuted,
                              size: 18,
                            ),
                            suffixIcon: _query.isNotEmpty
                                ? GestureDetector(
                                    onTap: () {
                                      _controller.clear();
                                      setState(() => _query = '');
                                    },
                                    child: Icon(
                                      LucideIcons.x,
                                      color: AppColors.textMuted,
                                      size: 16,
                                    ),
                                  )
                                : null,
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 12,
                            ),
                          ),
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
                      // ── Búsquedas recientes ─────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'BÚSQUEDAS RECIENTES',
                            style: GoogleFonts.urbanist(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 2.0,
                              color: AppColors.textTertiary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'Borrar',
                              style: GoogleFonts.urbanist(
                                fontSize: 12,
                                color: AppColors.primaryLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      ..._recent.map((r) => _RecentItem(text: r)),
                      const SizedBox(height: 24),

                      // ── Categories ──────────────────────────────────────
                      Text(
                        'CATEGORÍAS',
                        style: GoogleFonts.urbanist(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.3,
                        ),
                        itemCount: _categories.length,
                        itemBuilder: (_, i) => _CategoryCell(
                          category: _categories[i],
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(height: 24),

                      // ── Trending ────────────────────────────────────────
                      Text(
                        'TENDENCIAS',
                        style: GoogleFonts.urbanist(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 2.0,
                          color: AppColors.textTertiary,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ..._trending.map(
                        (t) => _TrendCard(
                          item: t,
                          onTap: () => context.push('/player'),
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

class _Category {
  final String label;
  final IconData icon;
  final Color color;

  const _Category(this.label, this.icon, this.color);
}

class _TrendItem {
  final String rank;
  final String title;
  final String meta;

  const _TrendItem(this.rank, this.title, this.meta);
}

class _RecentItem extends StatelessWidget {
  final String text;

  const _RecentItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(LucideIcons.clock, color: AppColors.textMuted, size: 16),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.urbanist(
                fontSize: 14,
                color: AppColors.textTertiary,
              ),
            ),
          ),
          Icon(LucideIcons.arrowUpLeft, color: AppColors.textMuted, size: 16),
        ],
      ),
    );
  }
}

class _CategoryCell extends StatelessWidget {
  final _Category category;
  final VoidCallback onTap;

  const _CategoryCell({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: category.color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: category.color.withValues(alpha: 0.25)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(category.icon, color: category.color, size: 22),
            const SizedBox(height: 6),
            Text(
              category.label,
              style: GoogleFonts.urbanist(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TrendCard extends StatelessWidget {
  final _TrendItem item;
  final VoidCallback onTap;

  const _TrendCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.surfaceBorderLight),
          ),
          child: Row(
            children: [
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    item.rank,
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: GoogleFonts.urbanist(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      item.meta,
                      style: GoogleFonts.urbanist(
                        fontSize: 11,
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                LucideIcons.trendingUp,
                color: AppColors.mint,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
