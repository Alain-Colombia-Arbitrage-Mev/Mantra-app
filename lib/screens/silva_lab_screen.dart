import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../utils/responsive.dart';

class SilvaLabScreen extends StatelessWidget {
  const SilvaLabScreen({super.key});

  static final List<(String, IconData)> _tools = [
    ('Pantalla', LucideIcons.monitor),
    ('Archivo', LucideIcons.folderOpen),
    ('Consejeros', LucideIcons.users),
    ('Sustancias', LucideIcons.beaker),
  ];

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Background ─────────────────────────────────────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF1a1a2e), Color(0xFF0a0a1a)],
              ),
            ),
          ),

          // ── Steel blue glow ─────────────────────────────────────────────
          Positioned(
            top: Responsive.h(-60),
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: Responsive.w(320),
                height: Responsive.w(320),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      const Color(0xFF8B9DC3).withValues(alpha: 0.20),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Content ──────────────────────────────────────────────────────
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  Responsive.w(20), 0, Responsive.w(20), Responsive.h(32)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Close
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: Responsive.w(36),
                        height: Responsive.w(36),
                        margin: EdgeInsets.only(top: Responsive.h(12)),
                        decoration: BoxDecoration(
                          color: const Color(0x15FFFFFF),
                          borderRadius:
                              BorderRadius.circular(Responsive.w(10)),
                        ),
                        child: Icon(
                          LucideIcons.x,
                          color: Colors.white,
                          size: Responsive.w(18),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: Responsive.h(8)),

                  Text(
                    'LABORATORIO MENTAL',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(11),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: const Color(0xCC8B9DC3),
                    ),
                  ),
                  SizedBox(height: Responsive.h(10)),

                  Text(
                    'Tu espacio\nsagrado interior',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(28),
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.15,
                    ),
                  ),
                  SizedBox(height: Responsive.h(8)),

                  Text(
                    'Construye en tu mente un laboratorio\npersonal donde puedes resolver cualquier problema.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(14),
                      color: const Color(0x80FFFFFF),
                      height: 1.5,
                    ),
                  ),

                  SizedBox(height: Responsive.h(24)),

                  // ── Lab visual card ───────────────────────────────────────
                  Container(
                    width: Responsive.w(320),
                    height: Responsive.h(180),
                    padding: EdgeInsets.all(Responsive.w(20)),
                    decoration: BoxDecoration(
                      color: const Color(0x0AFFFFFF),
                      borderRadius:
                          BorderRadius.circular(Responsive.w(20)),
                      border: Border.all(
                        color: const Color(0x208B9DC3),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Container(
                            width: Responsive.w(60),
                            height: Responsive.w(60),
                            decoration: BoxDecoration(
                              color: const Color(0x208B9DC3),
                              borderRadius:
                                  BorderRadius.circular(Responsive.w(14)),
                            ),
                            child: Icon(
                              LucideIcons.monitor,
                              color: const Color(0xFF8B9DC3),
                              size: Responsive.w(30),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: Responsive.h(8),
                          left: Responsive.w(8),
                          child: Icon(
                            LucideIcons.armchair,
                            color: const Color(0x608B9DC3),
                            size: Responsive.w(22),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          left: 0,
                          child: Icon(
                            LucideIcons.timer,
                            color: const Color(0x608B9DC3),
                            size: Responsive.w(18),
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(
                            LucideIcons.calendar,
                            color: const Color(0x608B9DC3),
                            size: Responsive.w(18),
                          ),
                        ),
                        Positioned(
                          bottom: Responsive.h(8),
                          right: Responsive.w(8),
                          child: Icon(
                            LucideIcons.wrench,
                            color: const Color(0x608B9DC3),
                            size: Responsive.w(22),
                          ),
                        ),
                        const Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.h(8)),
                  Text(
                    'Mi Laboratorio',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(13),
                      color: const Color(0x60FFFFFF),
                    ),
                  ),

                  SizedBox(height: Responsive.h(24)),

                  // ── Tools label ───────────────────────────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'HERRAMIENTAS DE TU LABORATORIO',
                      style: GoogleFonts.urbanist(
                        fontSize: Responsive.sp(11),
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: const Color(0x80FFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(12)),

                  // ── Tool cards ────────────────────────────────────────────
                  Row(
                    children: List.generate(_tools.length, (i) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: i < _tools.length - 1
                                  ? Responsive.w(8)
                                  : 0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: Responsive.h(12),
                                horizontal: Responsive.w(8)),
                            decoration: BoxDecoration(
                              color: const Color(0x158B9DC3),
                              borderRadius:
                                  BorderRadius.circular(Responsive.w(12)),
                              border: Border.all(
                                color: const Color(0x308B9DC3),
                                width: 1,
                              ),
                            ),
                            child: Column(
                              children: [
                                Icon(
                                  _tools[i].$2,
                                  color: const Color(0xFF8B9DC3),
                                  size: Responsive.w(20),
                                ),
                                SizedBox(height: Responsive.h(6)),
                                Text(
                                  _tools[i].$1,
                                  style: GoogleFonts.urbanist(
                                    fontSize: Responsive.sp(11),
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: Responsive.h(24)),

                  Text(
                    'Visualización guiada · Construye tu espacio',
                    style: GoogleFonts.urbanist(
                      fontSize: Responsive.sp(12),
                      color: const Color(0x80FFFFFF),
                    ),
                  ),

                  SizedBox(height: Responsive.h(20)),

                  // ── Steel blue CTA ────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    height: Responsive.h(56),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF8B9DC3), Color(0xFF5A6D8E)],
                      ),
                      borderRadius:
                          BorderRadius.circular(Responsive.w(16)),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8B9DC3)
                              .withValues(alpha: 0.35),
                          blurRadius: Responsive.w(20),
                          offset: Offset(0, Responsive.h(6)),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Entrar al laboratorio',
                        style: GoogleFonts.urbanist(
                          fontSize: Responsive.sp(18),
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
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
    );
  }
}
