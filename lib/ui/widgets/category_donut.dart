import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../core/categories.dart';
import '../../core/format.dart';
import 'empty_state.dart';

/// Donut chart + legend (name and %, so meaning never relies on color alone).
class CategoryDonut extends StatelessWidget {
  final Map<String, double> data;
  const CategoryDonut({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final entries = data.entries.where((e) => e.value > 0).toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final total = entries.fold(0.0, (s, e) => s + e.value);

    if (total == 0) {
      return const EmptyState(
        icon: Icons.pie_chart_outline,
        title: 'No expenses yet this month',
        message: 'Add an expense to see where your money goes.',
      );
    }

    final track = Theme.of(context).colorScheme.surfaceContainerHighest;
    return Row(
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: Stack(
            alignment: Alignment.center,
            children: [
              CustomPaint(
                size: const Size(140, 140),
                painter: _DonutPainter(
                  [for (final e in entries) MapEntry(categoryById(e.key).color, e.value)],
                  track,
                ),
              ),
              SizedBox(
                width: 84,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Spent', style: Theme.of(context).textTheme.labelSmall),
                      Text(money(total),
                          style: const TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            children: [
              for (final e in entries.take(5))
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                  child: Row(
                    children: [
                      Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: categoryById(e.key).color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(categoryById(e.key).name,
                            maxLines: 1, overflow: TextOverflow.ellipsis),
                      ),
                      Text('${(e.value / total * 100).round()}%'),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DonutPainter extends CustomPainter {
  final List<MapEntry<Color, double>> slices;
  final Color track;
  _DonutPainter(this.slices, this.track);

  @override
  void paint(Canvas canvas, Size size) {
    const stroke = 22.0;
    final rect = (Offset.zero & size).deflate(stroke / 2);
    canvas.drawArc(
      rect,
      0,
      2 * math.pi,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = track,
    );
    final total = slices.fold(0.0, (s, e) => s + e.value);
    var start = -math.pi / 2;
    for (final s in slices) {
      final sweep = s.value / total * 2 * math.pi;
      canvas.drawArc(
        rect,
        start,
        math.max(sweep - 0.03, 0.01),
        false,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = stroke
          ..color = s.key,
      );
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter old) => true;
}
