import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/pencil_surface.dart';

/// The Cuenta frame from Pencil remains visible beneath real editable fields.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _showPassword = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _complete() {
    HapticFeedback.lightImpact();
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return PencilSurface(
      nodeId: 'wecjl',
      showNavigation: false,
      respectSafeArea: false,
      onTap: (point) {
        if (point.dy > .84 && point.dy < .93) _complete();
        if (point.dy > .93) context.go('/login');
      },
      overlays: [
        Positioned(
          left: size.width * (24 / PencilSurface.canvasSize.width),
          right: size.width * (24 / PencilSurface.canvasSize.width),
          top: size.height * (330 / 956),
          height: size.height * (56 / 956),
          child: _Field(
            controller: _email,
            keyboardType: TextInputType.emailAddress,
            hint: 'tu@email.com',
          ),
        ),
        Positioned(
          left: size.width * (24 / PencilSurface.canvasSize.width),
          right: size.width * (24 / PencilSurface.canvasSize.width),
          top: size.height * (434 / 956),
          height: size.height * (56 / 956),
          child: _Field(
            controller: _password,
            hint: 'Contraseña',
            obscure: !_showPassword,
            suffix: IconButton(
              onPressed: () => setState(() => _showPassword = !_showPassword),
              icon: Icon(
                _showPassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                color: const Color(0xFFB3B1BA),
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _Field extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscure;
  final Widget? suffix;

  const _Field({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.obscure = false,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) => TextField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscure,
    style: GoogleFonts.manrope(color: const Color(0xFFF4F1EC), fontSize: 12),
    decoration: InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.manrope(
        color: const Color(0xFF6E6D7C),
        fontSize: 11,
      ),
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      border: InputBorder.none,
      suffixIcon: suffix,
    ),
  );
}
