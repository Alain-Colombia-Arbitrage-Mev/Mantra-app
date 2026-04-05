import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';
import '../widgets/screen_bg.dart';
import '../utils/responsive.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selected = 'ES';
  String _query = '';

  static const List<_LangItem> _languages = [
    _LangItem('English', 'English · EN', 'EN'),
    _LangItem('עברית', 'Hebrew · HE', 'HE'),
    _LangItem('Français', 'French · FR', 'FR'),
    _LangItem('Português', 'Portuguese · PT', 'PT'),
    _LangItem('Deutsch', 'German · DE', 'DE'),
  ];

  List<_LangItem> get _filtered {
    if (_query.isEmpty) return _languages;
    final q = _query.toLowerCase();
    return _languages
        .where((l) =>
            l.name.toLowerCase().contains(q) ||
            l.label.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: ScreenBg(
        child: SafeArea(
          bottom: false,
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(Responsive.w(20), Responsive.h(20), Responsive.w(20), Responsive.h(40)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──────────────────────────────────────────────
                ScreenNav(
                  title: 'Idioma',
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
                      LucideIcons.globe,
                      color: Colors.white,
                      size: Responsive.w(18),
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(8)),
                Text(
                  'Elige tu idioma preferido para MANTRAS',
                  style: GoogleFonts.urbanist(
                    fontSize: Responsive.sp(14),
                    color: AppColors.textTertiary,
                  ),
                ),
                SizedBox(height: Responsive.h(20)),

                // ── Search ───────────────────────────────────────────────
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(14),
                    vertical: Responsive.h(4),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceLight,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.surfaceBorderLight),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        LucideIcons.search,
                        color: AppColors.textTertiary,
                        size: Responsive.w(18),
                      ),
                      SizedBox(width: Responsive.w(10)),
                      Expanded(
                        child: TextField(
                          onChanged: (v) => setState(() => _query = v),
                          style: GoogleFonts.urbanist(
                            fontSize: Responsive.sp(14),
                            color: Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Buscar idioma...',
                            hintStyle: GoogleFonts.urbanist(
                              fontSize: Responsive.sp(14),
                              color: AppColors.textTertiary,
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding:
                                EdgeInsets.symmetric(vertical: Responsive.h(12)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Responsive.h(24)),

                // ── Active language ───────────────────────────────────────
                if (_selected == 'ES' || _query.isEmpty) ...[
                  const SectionLabel('IDIOMA ACTIVO'),
                  SizedBox(height: Responsive.h(12)),
                  if (_selected == 'ES')
                    _LangCard(
                      name: 'Español',
                      label: 'Spanish · ES',
                      code: 'ES',
                      selected: true,
                      onTap: () {},
                    ),
                  SizedBox(height: Responsive.h(24)),
                ],

                // ── Other languages ───────────────────────────────────────
                const SectionLabel('OTROS IDIOMAS'),
                SizedBox(height: Responsive.h(12)),
                ..._filtered
                    .where((l) => l.code != _selected || _selected != 'ES')
                    .map(
                      (l) => Padding(
                        padding: EdgeInsets.only(bottom: Responsive.h(10)),
                        child: _LangCard(
                          name: l.name,
                          label: l.label,
                          code: l.code,
                          selected: _selected == l.code,
                          onTap: () => setState(() => _selected = l.code),
                        ),
                      ),
                    ),
                SizedBox(height: Responsive.h(36)),

                // ── CTA ───────────────────────────────────────────────────
                GestureDetector(
                  onTap: () {
                    if (Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: Responsive.h(16)),
                    decoration: BoxDecoration(
                      gradient: AppGradients.primaryButton,
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.4),
                          blurRadius: Responsive.w(20),
                          offset: Offset(0, Responsive.h(8)),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          LucideIcons.globe,
                          color: Colors.white,
                          size: Responsive.w(18),
                        ),
                        SizedBox(width: Responsive.w(10)),
                        Text(
                          'Aplicar Idioma',
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

class _LangItem {
  final String name;
  final String label;
  final String code;

  const _LangItem(this.name, this.label, this.code);
}

class _LangCard extends StatelessWidget {
  final String name;
  final String label;
  final String code;
  final bool selected;
  final VoidCallback onTap;

  const _LangCard({
    required this.name,
    required this.label,
    required this.code,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Responsive.w(16), vertical: Responsive.h(14)),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.primary.withValues(alpha: 0.12)
              : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.surfaceBorderLight,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: Responsive.w(36),
              height: Responsive.w(36),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary.withValues(alpha: 0.2)
                    : AppColors.white.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                LucideIcons.globe,
                color: selected ? AppColors.primaryLight : AppColors.textTertiary,
                size: Responsive.w(16),
              ),
            ),
            SizedBox(width: Responsive.w(14)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(15),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    label,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            if (selected)
              Icon(
                LucideIcons.check,
                color: AppColors.primary,
                size: Responsive.w(20),
              ),
          ],
        ),
      ),
    );
  }
}
