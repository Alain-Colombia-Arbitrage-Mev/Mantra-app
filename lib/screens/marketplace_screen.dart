import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

class MarketplaceScreen extends StatefulWidget {
  const MarketplaceScreen({super.key});

  @override
  State<MarketplaceScreen> createState() => _MarketplaceScreenState();
}

class _MarketplaceScreenState extends State<MarketplaceScreen> {
  int _selectedCategory = 0;

  static const List<String> _categories = [
    'Todo',
    'Meditar',
    'Códigos',
    'Rituales',
  ];

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
                  title: 'Mercado Social · Hecho para ti',
                  showBack: true,
                  trailing: GestureDetector(
                    onTap: () => context.push('/search'),
                    child: Container(
                      width: Responsive.w(36),
                      height: Responsive.w(36),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.surfaceBorderLight),
                      ),
                      child: Icon(
                        LucideIcons.search,
                        color: Colors.white,
                        size: Responsive.w(18),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(24)),
                GestureDetector(
                onTap: () => context.push('/alchemist'),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(Responsive.w(20)),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF2D1B69), Color(0xFF0D0730)],
                    ),
                    borderRadius: BorderRadius.circular(Responsive.w(20)),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.4),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.25),
                        blurRadius: Responsive.w(24),
                        offset: Offset(0, Responsive.h(10)),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: Responsive.w(10), vertical: Responsive.h(4),
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.gold.withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(Responsive.w(20)),
                              ),
                              child: Text(
                                'EXCLUSIVO MANTRAS',
                                style: GoogleFonts.urbanist(
                                  fontSize: Responsive.sp(9),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.5,
                                  color: AppColors.gold,
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.h(10)),
                            Text(
                              'El Alquimista',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(22),
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Crea tu Audio IA',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(16),
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryLight,
                              ),
                            ),
                            SizedBox(height: Responsive.h(6)),
                            Text(
                              '528Hz · Theta · Tu voz · Sin límites',
                              style: GoogleFonts.urbanist(
                                fontSize: Responsive.sp(12),
                                color: AppColors.textTertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: Responsive.w(64),
                        height: Responsive.w(64),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          LucideIcons.mic,
                          color: AppColors.primaryLight,
                          size: Responsive.w(30),
                        ),
                      ),
                    ],
                  ),
                ),
                ),
                SizedBox(height: Responsive.h(20)),
                SizedBox(
                  height: Responsive.h(38),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _categories.length,
                    separatorBuilder: (_, __) => SizedBox(width: Responsive.w(8)),
                    itemBuilder: (context, i) {
                      final active = i == _selectedCategory;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: EdgeInsets.symmetric(
                            horizontal: Responsive.w(18), vertical: Responsive.h(9),
                          ),
                          decoration: BoxDecoration(
                            color: active
                                ? AppColors.primary
                                : AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(Responsive.w(50)),
                            border: Border.all(
                              color: active
                                  ? AppColors.primary
                                  : AppColors.surfaceBorderLight,
                            ),
                          ),
                          child: Text(
                            _categories[i],
                            style: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(13),
                              fontWeight: FontWeight.w600,
                              color: active
                                  ? Colors.white
                                  : AppColors.textTertiary,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: Responsive.h(24)),
                const SectionLabel('LO MÁS TRANSFORMADOR DEL MERCADO'),
                SizedBox(height: Responsive.h(14)),
                _ProductCard(
                  title: 'Reprograma tu ADN · 528 Hz',
                  price: '\$4.99',
                  meta: '20 min · Solfeggio · ★4.9',
                  badge: 'Más popular',
                  badgeColor: AppColors.mint,
                  accentColor: AppColors.primary,
                ),
                SizedBox(height: Responsive.h(12)),
                _ProductCard(
                  title: 'Sana a tu niño interior',
                  price: '\$6.99',
                  meta: '45 min · Theta · ★4.7',
                  badge: 'Transforma traumas',
                  badgeColor: AppColors.chakra,
                  accentColor: AppColors.chakra,
                ),
                SizedBox(height: Responsive.h(12)),
                _ProductCard(
                  title: 'Activa tu Merkaba · 963 Hz',
                  price: '\$9.99',
                  meta: '20 min · Gamma · ★5.0',
                  badge: 'Nivel maestro',
                  badgeColor: AppColors.gold,
                  accentColor: AppColors.gold,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  final String title;
  final String price;
  final String meta;
  final String badge;
  final Color badgeColor;
  final Color accentColor;

  const _ProductCard({
    required this.title,
    required this.price,
    required this.meta,
    required this.badge,
    required this.badgeColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/player'),
      child: Container(
        padding: EdgeInsets.all(Responsive.w(16)),
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(Responsive.w(16)),
          border: Border.all(color: AppColors.surfaceBorderLight),
        ),
        child: Row(
          children: [
            Container(
              width: Responsive.w(52),
              height: Responsive.w(52),
              decoration: BoxDecoration(
                color: accentColor.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(Responsive.w(14)),
              ),
              child: Icon(LucideIcons.headphones, color: accentColor, size: Responsive.w(24)),
            ),
            SizedBox(width: Responsive.w(14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(14),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: Responsive.h(3)),
                  Text(
                    meta,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      color: AppColors.textTertiary,
                    ),
                  ),
                  SizedBox(height: Responsive.h(6)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Responsive.w(8), vertical: Responsive.h(3),
                    ),
                    decoration: BoxDecoration(
                      color: badgeColor.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(Responsive.w(6)),
                    ),
                    child: Text(
                      badge,
                      style: GoogleFonts.urbanist(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w600,
                        color: badgeColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: Responsive.w(10)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(18),
                    fontWeight: FontWeight.w800,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: Responsive.h(6)),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(12), vertical: Responsive.h(6),
                  ),
                  decoration: BoxDecoration(
                    gradient: AppGradients.primaryButton,
                    borderRadius: BorderRadius.circular(Responsive.w(20)),
                  ),
                  child: Text(
                    'Obtener',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
