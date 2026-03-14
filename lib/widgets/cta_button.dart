import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme.dart';

class CtaButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final LinearGradient gradient;
  final Color textColor;
  final Color? shadowColor;
  final double height;
  final double borderRadius;
  final IconData? icon;

  const CtaButton({
    super.key,
    required this.label,
    required this.onTap,
    this.gradient = AppGradients.primaryButton,
    this.textColor = AppColors.white,
    this.shadowColor,
    this.height = 60,
    this.borderRadius = 30,
    this.icon,
  });

  @override
  State<CtaButton> createState() => _CtaButtonState();
}

class _CtaButtonState extends State<CtaButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final shadow = widget.shadowColor ??
        widget.gradient.colors.first.withValues(alpha: 0.38);

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        HapticFeedback.lightImpact();
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: double.infinity,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: widget.gradient,
            borderRadius: BorderRadius.circular(widget.borderRadius),
            boxShadow: [
              BoxShadow(
                color: shadow,
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, color: widget.textColor, size: 20),
                const SizedBox(width: 10),
              ],
              Text(
                widget.label,
                style: GoogleFonts.urbanist(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: widget.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
