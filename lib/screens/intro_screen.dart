import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/pencil_surface.dart';

/// The two introduction frames approved in mandala2.pen.
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  static const _nodes = ['oEGyR', '9nJKL'];
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page == _nodes.length - 1) {
      context.go('/onboarding');
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) => PageView.builder(
    controller: _controller,
    onPageChanged: (page) => setState(() => _page = page),
    itemCount: _nodes.length,
    itemBuilder: (context, index) => PencilSurface(
      nodeId: _nodes[index],
      showNavigation: false,
      respectSafeArea: false,
      overlays: index == 0 ? const [_ReadableIntroTagline()] : const [],
      onTap: (point) {
        if (index == 1 && point.dy > .90) {
          context.go('/login');
          return;
        }
        if (index == 0 || point.dy > .76) _next();
      },
    ),
  );
}

class _ReadableIntroTagline extends StatelessWidget {
  const _ReadableIntroTagline();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final scale = (size.width / 440).clamp(.9, 1.15).toDouble();

    return Positioned(
      top: size.height * .674,
      left: 24 * scale,
      right: 24 * scale,
      child: IgnorePointer(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 18 * scale,
              vertical: 9 * scale,
            ),
            decoration: BoxDecoration(
              color: const Color(0xB30A090B),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: const Color(0x52FFFFFF)),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x99000000),
                  blurRadius: 18,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              'RESPIRA · VUELVE · EMPIEZA',
              maxLines: 1,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.5 * scale,
                fontWeight: FontWeight.w700,
                letterSpacing: 2.25 * scale,
                height: 1.2,
                shadows: const [Shadow(color: Colors.black, blurRadius: 4)],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
