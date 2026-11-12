import 'package:flutter/material.dart';

const double kPad = 16.0;

// Semantic colors, used the same way on every screen (consistency).
const incomeColor = Color(0xFF2E9E5B);
const expenseColor = Color(0xFFD64545);

ThemeData buildTheme(Brightness brightness) {
  final scheme = ColorScheme.fromSeed(
    seedColor: const Color(0xFF1B8A5A),
    brightness: brightness,
  );
  return ThemeData(useMaterial3: true, colorScheme: scheme);
}
