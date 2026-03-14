import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/gradient_bg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;

  static const List<(IconData, String)> _tabs = [
    (LucideIcons.home, 'Inicio'),
    (LucideIcons.moon, 'Meditar'),
    (LucideIcons.star, 'Astro'),
    (LucideIcons.shoppingBag, 'Tienda'),
    (LucideIcons.user, 'Yo'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      extendBody: true,
      body: GradientBg(
        child: SafeArea(
          bottom: false,
          child: _buildBody(),
        ),
      ),
      bottomNavigationBar: _BottomNav(
        currentIndex: _currentTab,
        onTap: (i) => setState(() => _currentTab = i),
        tabs: _tabs,
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentTab) {
      case 0:
        return const _HomeTab();
      case 1:
        return _PlaceholderTab(
          icon: LucideIcons.moon,
          label: 'Meditaciones',
          color: AppColors.lunar,
        );
      case 2:
        return _PlaceholderTab(
          icon: LucideIcons.star,
          label: 'Astrología',
          color: AppColors.chakra,
        );
      case 3:
        return _PlaceholderTab(
          icon: LucideIcons.shoppingBag,
          label: 'Marketplace',
          color: AppColors.mint,
        );
      case 4:
        return _PlaceholderTab(
          icon: LucideIcons.user,
          label: 'Mi Perfil',
          color: AppColors.primaryLight,
        );
      default:
        return const _HomeTab();
    }
  }
}

// ─── Home Tab ─────────────────────────────────────────────────────────────────

class _HomeTab extends StatelessWidget {
  const _HomeTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Greeting
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Buenos días ✨',
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    'Bienvenido',
                    style: GoogleFonts.urbanist(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.surfaceBorder),
                ),
                child: const Icon(
                  LucideIcons.bell,
                  color: AppColors.primaryLight,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Featured card
          _FeaturedCard(),
          const SizedBox(height: 24),

          // Section: Quick start
          Text(
            'Empezar ahora',
            style: GoogleFonts.urbanist(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 14),
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: const [
                _QuickCard(
                  icon: LucideIcons.wind,
                  label: 'Respiración',
                  color: AppColors.mint,
                ),
                _QuickCard(
                  icon: LucideIcons.moon,
                  label: 'Dormir',
                  color: AppColors.lunar,
                ),
                _QuickCard(
                  icon: LucideIcons.sun,
                  label: 'Mañana',
                  color: AppColors.amber,
                ),
                _QuickCard(
                  icon: LucideIcons.zap,
                  label: 'Energía',
                  color: AppColors.chakra,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // Section: Today's meditation
          Text(
            'Meditación del día',
            style: GoogleFonts.urbanist(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 14),
          _MeditationCard(
            title: 'Calma profunda',
            subtitle: '10 min · Principiante',
            color: AppColors.primary,
          ),
          const SizedBox(height: 10),
          _MeditationCard(
            title: 'Chakra del corazón',
            subtitle: '15 min · Intermedio',
            color: AppColors.chakra,
          ),
          const SizedBox(height: 10),
          _MeditationCard(
            title: 'Luna llena ritual',
            subtitle: '20 min · Todos los niveles',
            color: AppColors.lunar,
          ),
        ],
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, Color(0xFF2D1B69)],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'SESIÓN DIARIA',
                  style: GoogleFonts.urbanist(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryLight,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Meditación de\nconciencia plena',
                  style: GoogleFonts.urbanist(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.white,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 7,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Comenzar →',
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              LucideIcons.sparkles,
              color: AppColors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _QuickCard({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.urbanist(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textTertiary,
            ),
          ),
        ],
      ),
    );
  }
}

class _MeditationCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  const _MeditationCard({
    required this.title,
    required this.subtitle,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.surfaceBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(LucideIcons.moon, color: color, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.urbanist(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.urbanist(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            LucideIcons.playCircle,
            color: color,
            size: 32,
          ),
        ],
      ),
    );
  }
}

// ─── Placeholder Tab ──────────────────────────────────────────────────────────

class _PlaceholderTab extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _PlaceholderTab({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 36),
          ),
          const SizedBox(height: 16),
          Text(
            label,
            style: GoogleFonts.urbanist(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Próximamente',
            style: GoogleFonts.urbanist(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Nav ───────────────────────────────────────────────────────────────

class _BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<(IconData, String)> tabs;

  const _BottomNav({
    required this.currentIndex,
    required this.onTap,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xCC0A0A1A),
        border: Border(
          top: BorderSide(
            color: AppColors.white.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Row(
        children: List.generate(tabs.length, (i) {
          final isActive = i == currentIndex;
          final tab = tabs[i];
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(i),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    tab.$1,
                    color: isActive
                        ? AppColors.primary
                        : AppColors.white.withValues(alpha: 0.5),
                    size: 22,
                  ),
                  const SizedBox(height: 2),
                  if (isActive)
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  else
                    Text(
                      tab.$2,
                      style: GoogleFonts.urbanist(
                        fontSize: 10,
                        color: AppColors.white.withValues(alpha: 0.4),
                      ),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
