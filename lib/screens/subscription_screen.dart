import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../theme.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  // 0 = monthly, 1 = annual
  int _selectedPlan = 1;

  static const List<String> _benefits = [
    '7 Days free trial',
    'Experience our full library',
    '300+ soundscapes',
    '80+ meditations',
    '20+ sleep sounds',
    'Mix your own sleep sounds',
    'No ads, stress free',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0F0A2A), Color(0xFF0A0A1A)],
          ),
        ),
        child: Stack(
          children: [
            // Purple glow top-right
            Positioned(
              top: -80,
              right: -60,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 160,
                      spreadRadius: 80,
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Column(
                children: [
                  // ── Header ─────────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
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
                        Expanded(
                          child: Text(
                            'Suscripción',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/home'),
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
                              LucideIcons.x,
                              color: Colors.white,
                              size: 18,
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
                        children: [
                          // ── PRO badge ──────────────────────────────────
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              gradient: AppGradients.primaryButton,
                              borderRadius: BorderRadius.circular(50),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.45,
                                  ),
                                  blurRadius: 20,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Text(
                              'PLAN PRO',
                              style: GoogleFonts.urbanist(
                                fontSize: 13,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 2.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // ── Headline ───────────────────────────────────
                          Text(
                            'Desbloquea la\nexperiencia completa',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.urbanist(
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.15,
                            ),
                          ),
                          const SizedBox(height: 28),

                          // ── Benefits list ──────────────────────────────
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.surfaceBorderLight,
                              ),
                            ),
                            child: Column(
                              children: _benefits.map((b) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 12),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 22,
                                        height: 22,
                                        decoration: BoxDecoration(
                                          color: AppColors.mint.withValues(
                                            alpha: 0.2,
                                          ),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                            color: AppColors.mint.withValues(
                                              alpha: 0.4,
                                            ),
                                          ),
                                        ),
                                        child: Icon(
                                          LucideIcons.check,
                                          color: AppColors.mint,
                                          size: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        b,
                                        style: GoogleFonts.urbanist(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // ── Plan cards ─────────────────────────────────
                          Row(
                            children: [
                              // Monthly
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedPlan = 0),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: _selectedPlan == 0
                                          ? AppColors.primary.withValues(
                                              alpha: 0.15,
                                            )
                                          : AppColors.white.withValues(
                                              alpha: 0.05,
                                            ),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: _selectedPlan == 0
                                            ? AppColors.primary
                                            : AppColors.surfaceBorderLight,
                                        width: _selectedPlan == 0 ? 2 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '\$9.99',
                                          style: GoogleFonts.urbanist(
                                            fontSize: 22,
                                            fontWeight: FontWeight.w800,
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '/Monthly',
                                          style: GoogleFonts.urbanist(
                                            fontSize: 13,
                                            color: AppColors.textTertiary,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              // Annual
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _selectedPlan = 1),
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: const EdgeInsets.all(16),
                                    decoration: BoxDecoration(
                                      color: _selectedPlan == 1
                                          ? AppColors.primary.withValues(
                                              alpha: 0.15,
                                            )
                                          : AppColors.white.withValues(
                                              alpha: 0.05,
                                            ),
                                      borderRadius: BorderRadius.circular(16),
                                      border: Border.all(
                                        color: _selectedPlan == 1
                                            ? AppColors.primary
                                            : AppColors.surfaceBorderLight,
                                        width: _selectedPlan == 1 ? 2 : 1,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '\$79.00',
                                              style: GoogleFonts.urbanist(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w800,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          '/Annual',
                                          style: GoogleFonts.urbanist(
                                            fontSize: 13,
                                            color: AppColors.textTertiary,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 3,
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: AppGradients.primaryButton,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                          ),
                                          child: Text(
                                            'Recomendado',
                                            style: GoogleFonts.urbanist(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),

                          // ── CTA ────────────────────────────────────────
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              width: double.infinity,
                              height: 58,
                              decoration: BoxDecoration(
                                gradient: AppGradients.primaryButton,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(
                                      alpha: 0.45,
                                    ),
                                    blurRadius: 24,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Text(
                                  'Start with free trial',
                                  style: GoogleFonts.urbanist(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // ── Legal ──────────────────────────────────────
                          GestureDetector(
                            onTap: () => context.push('/terms'),
                            child: Text(
                              'Privacy Policy & Terms of use',
                              style: GoogleFonts.urbanist(
                                fontSize: 12,
                                color: AppColors.white.withValues(alpha: 0.5),
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.white.withValues(
                                  alpha: 0.3,
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
            ),
          ],
        ),
      ),
    );
  }
}
