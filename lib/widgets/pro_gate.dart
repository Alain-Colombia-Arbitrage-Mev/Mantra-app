import 'package:flutter/material.dart';
import '../services/revenuecat_service.dart';

/// Wraps content that requires Pro. Shows the RevenueCat paywall on tap if the
/// user is not yet subscribed. Pass [lockedChild] for a custom locked-state UI;
/// otherwise a semi-transparent overlay with a PRO badge is used.
class ProGate extends StatelessWidget {
  final Widget child;
  final Widget? lockedChild;

  const ProGate({super.key, required this.child, this.lockedChild});

  @override
  Widget build(BuildContext context) {
    if (RevenueCatService.instance.isPro) {
      return child;
    }
    return GestureDetector(
      onTap: () => RevenueCatService.instance.presentPaywall(),
      child: lockedChild ?? _defaultLocked(),
    );
  }

  Widget _defaultLocked() {
    return Stack(
      children: [
        Opacity(opacity: 0.4, child: child),
        Positioned.fill(
          child: Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0xFF6C5CE7),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.lock, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'PRO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
