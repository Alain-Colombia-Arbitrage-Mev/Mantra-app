import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/screen_bg.dart';

class SilvaHubScreen extends StatelessWidget {
  const SilvaHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenBg(
      child: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              // ── Header ──────────────────────────────────────────────────
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: const Color(0x15FFFFFF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        LucideIcons.chevronLeft,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'Método Silva',
                    style: GoogleFonts.urbanist(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    LucideIcons.info,
                    color: Color(0xCCFFFFFF),
                    size: 22,
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ── Hero card ────────────────────────────────────────────────
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Color(0xCC008180), Color(0xCC6C5CE7)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      LucideIcons.brain,
                      color: Color(0xFF55EFC4),
                      size: 32,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '"Tu mente no tiene límites"',
                      style: GoogleFonts.urbanist(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'José Silva · Fundador',
                      style: GoogleFonts.urbanist(
                        fontSize: 13,
                        color: const Color(0xCCFFFFFF),
                      ),
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => context.push('/silva/alfa'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        decoration: BoxDecoration(
                          color: const Color(0x20FFFFFF),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                              color: const Color(0x40FFFFFF), width: 1),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Comenzar nivel',
                              style: GoogleFonts.urbanist(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(LucideIcons.arrowRight,
                                color: Colors.white, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // ── Techniques label ─────────────────────────────────────────
              Text(
                'TÉCNICAS DEL MÉTODO SILVA',
                style: GoogleFonts.urbanist(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.5,
                  color: const Color(0x99FFFFFF),
                ),
              ),

              const SizedBox(height: 14),

              // ── 2×3 Grid ─────────────────────────────────────────────────
              _TechniqueGrid(),

              const SizedBox(height: 20),

              // ── Progress card ────────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0x0AFFFFFF),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0x15FFFFFF), width: 1),
                ),
                child: Row(
                  children: [
                    const Icon(
                      LucideIcons.flame,
                      color: Color(0xFFF9A826),
                      size: 28,
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tu progreso Silva',
                            style: GoogleFonts.urbanist(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '7 días de práctica · Nivel: Iniciado',
                            style: GoogleFonts.urbanist(
                              fontSize: 12,
                              color: const Color(0x80FFFFFF),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: List.generate(7, (i) {
                              final active = i < 5;
                              return Padding(
                                padding: EdgeInsets.only(right: i < 6 ? 6 : 0),
                                child: Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: active
                                        ? const Color(0xFFF9A826)
                                        : const Color(0x15FFFFFF),
                                    border: Border.all(
                                      color: active
                                          ? const Color(0xFFF9A826)
                                          : const Color(0x30FFFFFF),
                                      width: 1,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      ['L', 'M', 'M', 'J', 'V', 'S', 'D'][i],
                                      style: GoogleFonts.urbanist(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: active
                                            ? Colors.black
                                            : const Color(0x60FFFFFF),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Technique data ─────────────────────────────────────────────────────────────

class _TechniqueItem {
  final String title;
  final Color fill;
  final IconData icon;
  final Color iconColor;
  final String tag;
  final String sub;
  final String route;

  const _TechniqueItem({
    required this.title,
    required this.fill,
    required this.icon,
    required this.iconColor,
    required this.tag,
    required this.sub,
    required this.route,
  });
}

const List<_TechniqueItem> _techniques = [
  _TechniqueItem(
    title: 'Nivel Alfa',
    fill: Color(0x33008180),
    icon: LucideIcons.brain,
    iconColor: Color(0xFF55EFC4),
    tag: '8-12 Hz · Relajación',
    sub: 'Cuenta 3-2-1',
    route: '/silva/alfa',
  ),
  _TechniqueItem(
    title: 'Espejo Mental',
    fill: Color(0x336C5CE7),
    icon: LucideIcons.eye,
    iconColor: Color(0xFFA29BFE),
    tag: 'Visualización',
    sub: 'Antes → Después',
    route: '/silva/mirror',
  ),
  _TechniqueItem(
    title: 'Los 3 Dedos',
    fill: Color(0x33F9A826),
    icon: LucideIcons.hand,
    iconColor: Color(0xFFF9A826),
    tag: 'Anclaje mental',
    sub: 'Control rápido',
    route: '/silva/fingers',
  ),
  _TechniqueItem(
    title: 'Vaso de Agua',
    fill: Color(0x3300CEC9),
    icon: LucideIcons.droplets,
    iconColor: Color(0xFF00CEC9),
    tag: 'Ritual nocturno',
    sub: 'Programa sueños',
    route: '/silva/water',
  ),
  _TechniqueItem(
    title: 'Lab Mental',
    fill: Color(0x1AFFFFFF),
    icon: LucideIcons.monitor,
    iconColor: Color(0xFF8B9DC3),
    tag: 'Espacio interior',
    sub: 'Consejeros',
    route: '/silva/lab',
  ),
  _TechniqueItem(
    title: 'Pantalla Mental',
    fill: Color(0x33fd7960),
    icon: LucideIcons.projector,
    iconColor: Color(0xFFfd7960),
    tag: 'Proyección',
    sub: 'Reprograma',
    route: '/silva/screen',
  ),
];

class _TechniqueGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _TechCard(item: _techniques[0]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TechCard(item: _techniques[1]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TechCard(item: _techniques[2]),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _TechCard(item: _techniques[3]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TechCard(item: _techniques[4]),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _TechCard(item: _techniques[5]),
            ),
          ],
        ),
      ],
    );
  }
}

class _TechCard extends StatelessWidget {
  final _TechniqueItem item;
  const _TechCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(item.route),
      child: Container(
        height: 155,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: item.fill,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(item.icon, color: item.iconColor, size: 26),
            const Spacer(),
            Text(
              item.title,
              style: GoogleFonts.urbanist(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              item.tag,
              style: GoogleFonts.urbanist(
                fontSize: 10,
                color: const Color(0xAAFFFFFF),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              item.sub,
              style: GoogleFonts.urbanist(
                fontSize: 10,
                color: item.iconColor.withValues(alpha: 0.80),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
