import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../utils/responsive.dart';

class BottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNav({super.key, required this.currentIndex, required this.onTap});

  static const List<(IconData, String)> _tabs = [
    (LucideIcons.home, 'Inicio'),
    (LucideIcons.brain, 'Meditar'),
    (LucideIcons.bellRing, 'Alarmas'),
    (LucideIcons.star, 'Astro'),
    (LucideIcons.user, 'Yo'),
  ];

  @override
  Widget build(BuildContext context) {
    final navContentHeight = Responsive.h(56);

    return SafeArea(
      top: false,
      minimum: EdgeInsets.fromLTRB(
        Responsive.w(16),
        0,
        Responsive.w(16),
        Responsive.h(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Responsive.w(28)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            height: navContentHeight,
            decoration: BoxDecoration(
              color: const Color(0xE60C0D17),
              borderRadius: BorderRadius.circular(Responsive.w(28)),
              border: Border.all(
                color: AppColors.white.withValues(alpha: 0.08),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.34),
                  blurRadius: 24,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(Responsive.w(5)),
              child: Row(
                children: List.generate(_tabs.length, (i) {
                  final isActive = i == currentIndex;
                  final tab = _tabs[i];
                  return Expanded(
                    child: Semantics(
                      selected: isActive,
                      button: true,
                      label: tab.$2,
                      child: GestureDetector(
                        onTap: () => onTap(i),
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          curve: Curves.easeOutCubic,
                          decoration: BoxDecoration(
                            color: isActive
                                ? AppColors.primary.withValues(alpha: 0.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              Responsive.w(20),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                tab.$1,
                                color: isActive
                                    ? AppColors.primaryLight
                                    : AppColors.textMuted,
                                size: Responsive.w(19),
                              ),
                              SizedBox(height: Responsive.h(2)),
                              Text(
                                tab.$2,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.manrope(
                                  fontSize: Responsive.sp(9),
                                  fontWeight: isActive
                                      ? FontWeight.w800
                                      : FontWeight.w600,
                                  color: isActive
                                      ? AppColors.primaryLight
                                      : AppColors.textMuted,
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
            ),
          ),
        ),
      ),
    );
  }
}
