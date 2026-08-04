import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../widgets/pencil_surface.dart';

/// Five Pencil tabs: Home, Meditar, Alarmas, Astro and Yo.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _tabs = ['JOCTy', 'QFQIH', 'fSgoc', 'C700A', 'MQZec'];
  int _current = 0;

  void _handleTap(Offset point) {
    if (point.dy > .885) {
      setState(() => _current = (point.dx * _tabs.length).floor().clamp(0, 4));
      return;
    }
    if (_current == 0 && point.dy > .38 && point.dy < .70) {
      context.push('/player');
    }
    if (_current == 2 && point.dx > .82 && point.dy > .055 && point.dy < .135) {
      context.push('/new-alarm');
      return;
    }
    if (_current == 3 && point.dy > .42 && point.dy < .84) {
      context.push('/marketplace');
    }
  }

  @override
  Widget build(BuildContext context) => PencilSurface(
    nodeId: _tabs[_current],
    onTap: _handleTap,
    showNavigation: false,
  );
}
