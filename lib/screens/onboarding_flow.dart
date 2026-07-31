import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../widgets/pencil_surface.dart';

/// Production frames exported from mandala2.pen. The controls are native
/// and the screen artwork remains the Pencil-approved composition.
class OnboardingFlow extends StatefulWidget {
  const OnboardingFlow({super.key});

  @override
  State<OnboardingFlow> createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  static const _nodes = [
    'TTLH4',
    'x36zX',
    '1DHid',
    'CqnJW',
    '3fTTR',
    'tkH7u',
    'l5Vlq',
    'yBsgB',
    'K5ULP',
    'wecjl',
    'IEgGc',
    'w4GjPh',
    'D4A7Y',
  ];
  final _controller = PageController();
  int _page = 0;
  final Set<String> _needs = {'Dormir mejor'};
  final Set<String> _times = {'5 minutos'};
  final Set<String> _guidance = {'Guíame paso a paso'};

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _next() {
    if (_page == _nodes.length - 1) {
      context.go('/home');
      return;
    }
    _controller.nextPage(
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  void _startPractice() {
    HapticFeedback.lightImpact();
    context.go('/home');
  }

  void _toggle(Set<String> values, String value) {
    setState(() {
      if (values.contains(value)) {
        values.remove(value);
      } else {
        values.add(value);
      }
    });
  }

  List<Widget> _choiceOverlays(int index, Size size) {
    final horizontalInset = size.width * (24 / PencilSurface.canvasSize.width);
    switch (index) {
      case 5:
        return [
          Positioned(
            left: horizontalInset,
            right: horizontalInset,
            top: size.height * (373 / 956),
            height: size.height * (222 / 956),
            child: _MultiChoiceList(
              values: const [
                ('Sentir calma', Icons.spa_outlined),
                ('Dormir mejor', Icons.bedtime_outlined),
                ('Enfoque y confianza', Icons.center_focus_strong_outlined),
                ('Soltar una etapa', Icons.auto_awesome_outlined),
              ],
              selected: _needs,
              onToggle: (value) => _toggle(_needs, value),
            ),
          ),
        ];
      case 6:
        return [
          Positioned(
            left: horizontalInset,
            right: horizontalInset,
            top: size.height * (411 / 956),
            height: size.height * (210 / 956),
            child: _MultiChoiceGrid(
              values: const [
                ('5 minutos', Icons.bubble_chart_outlined),
                ('5 minutos+', Icons.favorite_border),
                ('10 minutos', Icons.eco_outlined),
                ('15 minutos', Icons.card_giftcard_outlined),
              ],
              selected: _times,
              onToggle: (value) => _toggle(_times, value),
            ),
          ),
        ];
      case 7:
        return [
          Positioned(
            left: horizontalInset,
            right: horizontalInset,
            top: size.height * (368 / 956),
            height: size.height * (192 / 956),
            child: _MultiChoiceList(
              values: const [
                ('Guíame paso a paso', Icons.psychology_alt_outlined),
                ('Déjame avanzar a mi ritmo', Icons.directions_walk_outlined),
                ('Quiero profundizar', Icons.auto_awesome_outlined),
              ],
              selected: _guidance,
              onToggle: (value) => _toggle(_guidance, value),
            ),
          ),
        ];
      default:
        return const [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return PageView.builder(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _nodes.length,
      onPageChanged: (value) => setState(() => _page = value),
      itemBuilder: (context, index) => PencilSurface(
        nodeId: _nodes[index],
        showNavigation: false,
        respectSafeArea: false,
        overlays: _choiceOverlays(index, size),
        onTap: (point) {
          if (index == 9 && point.dy > .32 && point.dy < .69) {
            context.push('/register');
            return;
          }
          // POST · Prueba activada → práctica lista → Home.
          if (index == 11 && point.dy > .80 && point.dy < .90) {
            _next();
            return;
          }
          if (index == 12 && point.dy > .87 && point.dy < .96) {
            _startPractice();
            return;
          }
          if (index == 4 && point.dy > .78 && point.dy < .90) {
            _next();
            return;
          }
          if (point.dy >= .79) _next();
        },
      ),
    );
  }
}

typedef _Choice = (String, IconData);

class _MultiChoiceList extends StatelessWidget {
  final List<_Choice> values;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const _MultiChoiceList({
    required this.values,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) => Column(
    children: values
        .map(
          (value) => Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: _ChoiceCard(
                label: value.$1,
                active: selected.contains(value.$1),
                onTap: () => onToggle(value.$1),
              ),
            ),
          ),
        )
        .toList(),
  );
}

class _MultiChoiceGrid extends StatelessWidget {
  final List<_Choice> values;
  final Set<String> selected;
  final ValueChanged<String> onToggle;

  const _MultiChoiceGrid({
    required this.values,
    required this.selected,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 2,
    mainAxisSpacing: 8,
    crossAxisSpacing: 8,
    childAspectRatio: 1.85,
    physics: const NeverScrollableScrollPhysics(),
    children: values
        .map(
          (value) => _ChoiceCard(
            label: value.$1,
            active: selected.contains(value.$1),
            compact: true,
            onTap: () => onToggle(value.$1),
          ),
        )
        .toList(),
  );
}

class _ChoiceCard extends StatelessWidget {
  final String label;
  final bool active;
  final bool compact;
  final VoidCallback onTap;

  const _ChoiceCard({
    required this.label,
    required this.active,
    required this.onTap,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    selected: active,
    label: label,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Align(
        alignment: Alignment.centerRight,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 160),
          opacity: active ? 1 : 0,
          child: Container(
            width: compact ? 18 : 20,
            height: compact ? 18 : 20,
            margin: EdgeInsets.only(right: compact ? 8 : 10),
            decoration: const BoxDecoration(
              color: Color(0xFF9897F5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check_rounded,
              size: compact ? 12 : 14,
              color: const Color(0xFF09080D),
            ),
          ),
        ),
      ),
    ),
  );
}
