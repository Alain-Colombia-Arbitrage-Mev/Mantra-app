import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

/// Renders a validated Pencil frame at the exact mobile canvas proportions.
/// Actions are deliberately layered above the reference rather than baking
/// navigation into the exported image.
class PencilSurface extends StatelessWidget {
  static const canvasSize = Size(440, 956);
  final String nodeId;
  final ValueChanged<Offset>? onTap;
  final List<Widget> overlays;
  final bool showNavigation;
  final bool respectSafeArea;

  const PencilSurface({
    super.key,
    required this.nodeId,
    this.onTap,
    this.overlays = const [],
    this.showNavigation = true,
    this.respectSafeArea = true,
  });

  @override
  Widget build(BuildContext context) {
    final safePadding = MediaQuery.viewPaddingOf(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: const Color(0xFF060608),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFF060608),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final top = respectSafeArea ? safePadding.top : 0.0;
            final bottom = respectSafeArea ? safePadding.bottom : 0.0;
            final safeRect = Rect.fromLTWH(
              0,
              top,
              constraints.maxWidth,
              constraints.maxHeight - top - bottom,
            );
            final canvasRect = respectSafeArea
                ? Alignment.center.inscribe(
                    applyBoxFit(
                      BoxFit.contain,
                      canvasSize,
                      safeRect.size,
                    ).destination,
                    safeRect,
                  )
                : Offset.zero & constraints.biggest;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTapUp: onTap == null
                  ? null
                  : (details) => onTap!(
                      Offset(
                        ((details.localPosition.dx - canvasRect.left) /
                                canvasRect.width)
                            .clamp(0.0, 1.0),
                        ((details.localPosition.dy - canvasRect.top) /
                                canvasRect.height)
                            .clamp(0.0, 1.0),
                      ),
                    ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fromRect(
                    rect: canvasRect,
                    child: Image.asset(
                      'assets/pencil/$nodeId.png',
                      fit: respectSafeArea ? BoxFit.fill : BoxFit.cover,
                      alignment: Alignment.topCenter,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  if (showNavigation) const _PencilNavigation(),
                  ...overlays,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PencilNavigation extends StatelessWidget {
  const _PencilNavigation();

  void _back(BuildContext context) {
    if (context.canPop()) {
      context.pop();
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    final scale =
        (MediaQuery.sizeOf(context).width / PencilSurface.canvasSize.width)
            .clamp(1.0, 1.16)
            .toDouble();
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(12 * scale, 8 * scale, 12 * scale, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavigationButton(
              icon: Icons.arrow_back_rounded,
              label: 'Volver',
              onTap: () => _back(context),
              scale: scale,
            ),
            _NavigationButton(
              icon: Icons.home_outlined,
              label: 'Inicio',
              onTap: () => context.go('/home'),
              scale: scale,
            ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final double scale;

  const _NavigationButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.scale,
  });

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: label,
    child: Material(
      color: Colors.transparent,
      child: InkResponse(
        onTap: onTap,
        radius: 28 * scale,
        child: Container(
          width: 42 * scale,
          height: 42 * scale,
          decoration: BoxDecoration(
            color: const Color(0xC20B0B10),
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0x33F4F1EC)),
          ),
          child: Icon(icon, color: const Color(0xFFF4F1EC), size: 20 * scale),
        ),
      ),
    ),
  );
}
