import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<(IconData, String)> _tabs = [
    (LucideIcons.home, 'Inicio'),
    (LucideIcons.brain, 'Meditar'),
    (LucideIcons.bellRing, 'Alarmas'),
    (LucideIcons.star, 'Astro'),
    (LucideIcons.user, 'Yo'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xE60A0A1A),
        border: Border(
          top: BorderSide(
            color: AppColors.white.withValues(alpha: 0.08),
          ),
        ),
      ),
      child: Row(
        children: List.generate(_tabs.length, (i) {
          final isActive = i == currentIndex;
          final tab = _tabs[i];
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
                  const SizedBox(height: 4),
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
