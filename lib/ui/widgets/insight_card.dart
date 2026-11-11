import 'package:flutter/material.dart';

import '../../state/insights_provider.dart';

class InsightCard extends StatelessWidget {
  final Insight insight;
  final VoidCallback onDismiss;
  const InsightCard({super.key, required this.insight, required this.onDismiss});

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    final (bg, fg, icon) = switch (insight.kind) {
      InsightKind.unusual => (s.errorContainer, s.onErrorContainer, Icons.warning_amber_rounded),
      InsightKind.budget => (s.tertiaryContainer, s.onTertiaryContainer, Icons.speed),
      InsightKind.tip => (s.secondaryContainer, s.onSecondaryContainer, Icons.lightbulb_outline),
    };
    return Card(
      color: bg,
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 12, 4, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: fg),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(insight.title,
                      style: TextStyle(fontWeight: FontWeight.w700, color: fg)),
                  const SizedBox(height: 2),
                  Text(insight.message, style: TextStyle(color: fg)),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Dismiss',
              icon: Icon(Icons.close, color: fg),
              onPressed: onDismiss,
            ),
          ],
        ),
      ),
    );
  }
}
