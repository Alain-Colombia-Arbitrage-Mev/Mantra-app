import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

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
            top: -60,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                width: 320,
                height: 320,
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
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Close
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 36,
                        height: 36,
                        margin: const EdgeInsets.only(top: 12),
                        decoration: BoxDecoration(
                          color: const Color(0x15FFFFFF),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          LucideIcons.x,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    'LABORATORIO MENTAL',
                    style: GoogleFonts.urbanist(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2,
                      color: const Color(0xCC8B9DC3),
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    'Tu espacio\nsagrado interior',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      height: 1.15,
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Construye en tu mente un laboratorio\npersonal donde puedes resolver cualquier problema.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.urbanist(
                      fontSize: 14,
                      color: const Color(0x80FFFFFF),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Lab visual card ───────────────────────────────────────
                  Container(
                    width: 320,
                    height: 180,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0x0AFFFFFF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0x208B9DC3),
                        width: 1,
                      ),
                    ),
                    child: Stack(
                      children: [
                        // Central monitor icon
                        Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: const Color(0x208B9DC3),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Icon(
                              LucideIcons.monitor,
                              color: Color(0xFF8B9DC3),
                              size: 30,
                            ),
                          ),
                        ),
                        // Chair icon — bottom left
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: const Icon(
                            LucideIcons.armchair,
                            color: Color(0x608B9DC3),
                            size: 22,
                          ),
                        ),
                        // Timer — top left
                        Positioned(
                          top: 0,
                          left: 0,
                          child: const Icon(
                            LucideIcons.timer,
                            color: Color(0x608B9DC3),
                            size: 18,
                          ),
                        ),
                        // Calendar — top right
                        Positioned(
                          top: 0,
                          right: 0,
                          child: const Icon(
                            LucideIcons.calendar,
                            color: Color(0x608B9DC3),
                            size: 18,
                          ),
                        ),
                        // Tool — bottom right
                        Positioned(
                          bottom: 8,
                          right: 8,
                          child: const Icon(
                            LucideIcons.wrench,
                            color: Color(0x608B9DC3),
                            size: 22,
                          ),
                        ),
                        // Label
                        const Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Center(),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mi Laboratorio',
                    style: GoogleFonts.urbanist(
                      fontSize: 13,
                      color: const Color(0x60FFFFFF),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // ── Tools label ───────────────────────────────────────────
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'HERRAMIENTAS DE TU LABORATORIO',
                      style: GoogleFonts.urbanist(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.5,
                        color: const Color(0x80FFFFFF),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // ── Tool cards ────────────────────────────────────────────
                  Row(
                    children: List.generate(_tools.length, (i) {
                      return Expanded(
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: i < _tools.length - 1 ? 8 : 0),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x158B9DC3),
                              borderRadius: BorderRadius.circular(12),
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
                                  size: 20,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _tools[i].$1,
                                  style: GoogleFonts.urbanist(
                                    fontSize: 11,
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

                  const SizedBox(height: 24),

                  Text(
                    'Visualización guiada · Construye tu espacio',
                    style: GoogleFonts.urbanist(
                      fontSize: 12,
                      color: const Color(0x80FFFFFF),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ── Steel blue CTA ────────────────────────────────────────
                  Container(
                    width: double.infinity,
                    height: 56,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [Color(0xFF8B9DC3), Color(0xFF5A6D8E)],
                      ),
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8B9DC3).withValues(alpha: 0.35),
                          blurRadius: 20,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'Entrar al laboratorio',
                        style: GoogleFonts.urbanist(
                          fontSize: 18,
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
