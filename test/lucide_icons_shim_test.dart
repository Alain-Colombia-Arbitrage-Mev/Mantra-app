import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lucide_icons/lucide_icons.dart';

void main() {
  test('Lucide shim exposes usable icon constants', () {
    expect(LucideIcons.home, isA<IconData>());
    expect(LucideIcons.play, isA<IconData>());
  });
}
