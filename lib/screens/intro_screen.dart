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
