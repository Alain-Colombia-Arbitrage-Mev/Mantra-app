import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../theme.dart';
import '../utils/responsive.dart';
import '../widgets/brand_mark.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _passwordVisible = false;
  bool _rememberSession = true;

  void _completeLogin() {
    HapticFeedback.lightImpact();
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    Responsive.init(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundEnd,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Opacity(
            opacity: 0.30,
            child: Image.asset(
              'assets/images/intro2_bg.jpg',
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.backgroundEnd.withValues(alpha: 0.90),
                  const Color(0xFF0B1020).withValues(alpha: 0.68),
                  AppColors.backgroundEnd.withValues(alpha: 0.98),
                ],
                stops: const [0.0, 0.46, 1.0],
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.viewPaddingOf(context).top + Responsive.h(62),
            left: 0,
            right: 0,
            child: Container(
              height: 1.5,
              margin: EdgeInsets.symmetric(horizontal: Responsive.w(20)),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.primaryLight.withValues(alpha: 0.30),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 430),
                    child: SingleChildScrollView(
                      padding: EdgeInsets.fromLTRB(
                        Responsive.w(20),
                        Responsive.h(8),
                        Responsive.w(20),
                        Responsive.h(14),
                      ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight - Responsive.h(36),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _TopBar(onBack: () => context.go('/intro')),
                            SizedBox(height: Responsive.h(18)),
                            const _BrandHeader(),
                            const Spacer(),
                            SizedBox(height: Responsive.h(18)),
                            _LoginPanel(
                              passwordVisible: _passwordVisible,
                              rememberSession: _rememberSession,
                              onTogglePassword: () => setState(
                                () => _passwordVisible = !_passwordVisible,
                              ),
                              onToggleRemember: () => setState(
                                () => _rememberSession = !_rememberSession,
                              ),
                              onSubmit: _completeLogin,
                            ),
                            SizedBox(height: Responsive.h(8)),
                            Center(
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () => context.go('/register'),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: Responsive.w(12),
                                    vertical: Responsive.h(10),
                                  ),
                                  child: Text.rich(
                                    TextSpan(
                                      text: '¿Nuevo en mantralia? ',
                                      style: GoogleFonts.manrope(
                                        fontSize: Responsive.sp(13),
                                        color: AppColors.white.withValues(
                                          alpha: 0.62,
                                        ),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: 'Crear cuenta',
                                          style: GoogleFonts.manrope(
                                            fontSize: Responsive.sp(13),
                                            fontWeight: FontWeight.w700,
                                            color: AppColors.primaryLight,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TopBar extends StatelessWidget {
  final VoidCallback onBack;

  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _IconButton(
          icon: LucideIcons.arrowLeft,
          onTap: onBack,
          label: 'Volver',
        ),
        const Spacer(),
        Text(
          'mantralia',
          style: GoogleFonts.manrope(
            fontSize: Responsive.sp(15),
            fontWeight: FontWeight.w900,
            color: AppColors.white.withValues(alpha: 0.86),
          ),
        ),
      ],
    );
  }
}

class _BrandHeader extends StatelessWidget {
  const _BrandHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BrandLockup(
          markSize: Responsive.w(76),
          titleSize: Responsive.sp(28),
          centered: false,
        ),
        SizedBox(height: Responsive.h(26)),
        Text(
          'Continúa tu práctica',
          style: GoogleFonts.manrope(
            fontSize: Responsive.isCompact
                ? Responsive.sp(28)
                : Responsive.sp(34),
            fontWeight: FontWeight.w800,
            height: 1.02,
            color: AppColors.white,
          ),
        ),
        SizedBox(height: Responsive.h(7)),
        Text(
          'Accede a tus rituales, sonidos y hábitos sin perder el ritmo.',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.manrope(
            fontSize: Responsive.sp(14),
            height: 1.35,
            color: AppColors.white.withValues(alpha: 0.72),
          ),
        ),
      ],
    );
  }
}

class _LoginPanel extends StatelessWidget {
  final bool passwordVisible;
  final bool rememberSession;
  final VoidCallback onTogglePassword;
  final VoidCallback onToggleRemember;
  final VoidCallback onSubmit;

  const _LoginPanel({
    required this.passwordVisible,
    required this.rememberSession,
    required this.onTogglePassword,
    required this.onToggleRemember,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(Responsive.w(16)),
      decoration: BoxDecoration(
        color: const Color(0xF2091019),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.primaryLight.withValues(alpha: 0.14),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.34),
            blurRadius: 34,
            offset: const Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Acceso seguro',
            style: GoogleFonts.manrope(
              fontSize: Responsive.sp(20),
              fontWeight: FontWeight.w800,
              color: AppColors.white,
            ),
          ),
          SizedBox(height: Responsive.h(4)),
          Text(
            'Tu sesión se mantiene privada en este dispositivo.',
            style: GoogleFonts.manrope(
              fontSize: Responsive.sp(12),
              color: AppColors.white.withValues(alpha: 0.52),
            ),
          ),
          SizedBox(height: Responsive.h(14)),
          _AuthField(
            label: 'Email',
            hint: 'tu@email.com',
            icon: LucideIcons.mail,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: Responsive.h(9)),
          _AuthField(
            label: 'Contraseña',
            hint: 'Tu contraseña',
            icon: LucideIcons.lock,
            obscureText: !passwordVisible,
            trailing: _IconButton(
              icon: passwordVisible ? LucideIcons.eye : LucideIcons.eyeOff,
              onTap: onTogglePassword,
              label: passwordVisible
                  ? 'Ocultar contraseña'
                  : 'Mostrar contraseña',
            ),
          ),
          SizedBox(height: Responsive.h(8)),
          Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onToggleRemember,
                child: SizedBox(
                  height: Responsive.h(44),
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 160),
                        width: Responsive.w(22),
                        height: Responsive.w(22),
                        decoration: BoxDecoration(
                          color: rememberSession
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(7),
                          border: Border.all(
                            color: rememberSession
                                ? AppColors.primaryLight
                                : AppColors.white.withValues(alpha: 0.22),
                          ),
                        ),
                        child: rememberSession
                            ? Icon(
                                LucideIcons.check,
                                size: Responsive.w(14),
                                color: const Color(0xFF09101F),
                              )
                            : null,
                      ),
                      SizedBox(width: Responsive.w(9)),
                      Text(
                        'Recordarme',
                        style: GoogleFonts.manrope(
                          fontSize: Responsive.sp(13),
                          color: AppColors.white.withValues(alpha: 0.70),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: Responsive.h(12)),
                  child: Text(
                    'Recuperar',
                    style: GoogleFonts.manrope(
                      fontSize: Responsive.sp(13),
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryLight,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: Responsive.h(9)),
          _PrimaryButton(
            label: 'Continuar',
            icon: LucideIcons.arrowRight,
            onTap: onSubmit,
          ),
          SizedBox(height: Responsive.h(11)),
          Row(
            children: [
              const Expanded(child: _DividerLine()),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Responsive.w(12)),
                child: Text(
                  'o',
                  style: GoogleFonts.manrope(
                    fontSize: Responsive.sp(12),
                    color: AppColors.white.withValues(alpha: 0.44),
                  ),
                ),
              ),
              const Expanded(child: _DividerLine()),
            ],
          ),
          SizedBox(height: Responsive.h(10)),
          Row(
            children: [
              Expanded(
                child: _SocialButton(
                  icon: LucideIcons.chrome,
                  label: 'Google',
                  onTap: onSubmit,
                ),
              ),
              SizedBox(width: Responsive.w(10)),
              Expanded(
                child: _SocialButton(
                  icon: LucideIcons.apple,
                  label: 'Apple',
                  onTap: onSubmit,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  final String label;
  final String hint;
  final IconData icon;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? trailing;

  const _AuthField({
    required this.label,
    required this.hint,
    required this.icon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.manrope(
            fontSize: Responsive.sp(12),
            fontWeight: FontWeight.w700,
            color: AppColors.white.withValues(alpha: 0.78),
          ),
        ),
        SizedBox(height: Responsive.h(5)),
        Container(
          constraints: BoxConstraints(minHeight: Responsive.h(50)),
          decoration: BoxDecoration(
            color: AppColors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.white.withValues(alpha: 0.12)),
          ),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: Responsive.w(15),
                  right: Responsive.w(10),
                ),
                child: Icon(
                  icon,
                  color: AppColors.primaryLight,
                  size: Responsive.w(20),
                ),
              ),
              Expanded(
                child: TextField(
                  keyboardType: keyboardType,
                  obscureText: obscureText,
                  style: GoogleFonts.manrope(
                    fontSize: Responsive.sp(14),
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                  decoration: InputDecoration(
                    hintText: hint,
                    hintStyle: GoogleFonts.manrope(
                      fontSize: Responsive.sp(14),
                      color: AppColors.white.withValues(alpha: 0.34),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
              ?trailing,
            ],
          ),
        ),
      ],
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _PrimaryButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 120),
        scale: _pressed ? 0.97 : 1,
        child: Container(
          height: Responsive.h(52),
          decoration: BoxDecoration(
            gradient: AppGradients.primaryButton,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.22),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.manrope(
                  fontSize: Responsive.sp(17),
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF09101F),
                ),
              ),
              SizedBox(width: Responsive.w(10)),
              Icon(
                widget.icon,
                color: const Color(0xFF09101F),
                size: Responsive.w(20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: Responsive.h(46),
        decoration: BoxDecoration(
          color: const Color(0xFF111827).withValues(alpha: 0.72),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.white.withValues(alpha: 0.14)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: AppColors.white, size: Responsive.w(18)),
            SizedBox(width: Responsive.w(8)),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.manrope(
                fontSize: Responsive.sp(14),
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final String label;

  const _IconButton({
    required this.icon,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: Responsive.w(44),
          height: Responsive.w(44),
          child: Center(
            child: Icon(
              icon,
              size: Responsive.w(20),
              color: AppColors.white.withValues(alpha: 0.86),
            ),
          ),
        ),
      ),
    );
  }
}

class _DividerLine extends StatelessWidget {
  const _DividerLine();

  @override
  Widget build(BuildContext context) {
    return Container(height: 1, color: AppColors.white.withValues(alpha: 0.12));
  }
}
