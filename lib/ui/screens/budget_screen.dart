import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/categories.dart';
import '../../core/format.dart';
import '../../core/theme.dart';
import '../../state/budget_provider.dart';
import '../../state/summary_provider.dart';

class BudgetScreen extends ConsumerWidget {
  const BudgetScreen({super.key});

  ({String label, IconData icon, Color color}) _status(double ratio) {
    if (ratio >= 1) return (label: 'Over budget', icon: Icons.error_outline, color: expenseColor);
    if (ratio >= 0.8) return (label: 'Almost at limit', icon: Icons.warning_amber_rounded, color: warnColor);
    return (label: 'On track', icon: Icons.check_circle_outline, color: incomeColor);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final budget = ref.watch(budgetProvider);
    final spent = ref.watch(monthExpensesByCategoryProvider);
    final now = DateTime.now();

    final totalLimit = budget.values.fold(0.0, (a, b) => a + b);
    final totalSpent = spent.values.fold(0.0, (a, b) => a + b);
    final totalRatio = totalLimit <= 0 ? 0.0 : totalSpent / totalLimit;
    final totalStatus = _status(totalRatio);

    return ListView(
      padding: const EdgeInsets.fromLTRB(kPad, kPad, kPad, 96),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(kPad),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(monthYear(now), style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                Text('${money(totalSpent)} of ${money(totalLimit)}',
                    style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                LinearProgressIndicator(
                  value: totalRatio.clamp(0.0, 1.0),
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(8),
                  color: totalStatus.color,
                ),
                const SizedBox(height: 8),
                Row(children: [
                  Icon(totalStatus.icon, size: 18, color: totalStatus.color),
                  const SizedBox(width: 6),
                  Text(totalStatus.label),
                ]),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text('Tap a category to change its monthly limit',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant)),
        const SizedBox(height: 8),
        for (final cat in expenseCategories)
          _CategoryBudgetCard(
            cat: cat,
            limit: budget[cat.id] ?? 0,
            used: spent[cat.id] ?? 0,
            status: _status((budget[cat.id] ?? 0) <= 0 ? 0 : (spent[cat.id] ?? 0) / budget[cat.id]!),
            onTap: () async {
              final v = await showDialog<double>(
                context: context,
                builder: (_) => _LimitDialog(name: cat.name, current: budget[cat.id] ?? 0),
              );
              if (v != null) ref.read(budgetProvider.notifier).setLimit(cat.id, v);
            },
          ),
      ],
    );
  }
}

class _CategoryBudgetCard extends StatelessWidget {
  final Category cat;
  final double limit;
  final double used;
  final ({String label, IconData icon, Color color}) status;
  final VoidCallback onTap;

  const _CategoryBudgetCard({
    required this.cat,
    required this.limit,
    required this.used,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ratio = limit <= 0 ? 0.0 : used / limit;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(kPad),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: cat.color.withAlpha(40),
                    child: Icon(cat.icon, color: cat.color),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cat.name, style: Theme.of(context).textTheme.titleSmall),
                        Text('${money(used)} / ${money(limit)}'),
                      ],
                    ),
                  ),
                  Icon(Icons.edit_outlined, size: 18, color: Theme.of(context).colorScheme.outline),
                ],
              ),
              const SizedBox(height: 10),
              LinearProgressIndicator(
                value: ratio.clamp(0.0, 1.0),
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
                color: status.color,
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Icon(status.icon, size: 16, color: status.color),
                  const SizedBox(width: 6),
                  Text(status.label, style: Theme.of(context).textTheme.bodySmall),
                  const Spacer(),
                  Text('${(ratio * 100).round()}%', style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LimitDialog extends StatefulWidget {
  final String name;
  final double current;
  const _LimitDialog({required this.name, required this.current});

  @override
  State<_LimitDialog> createState() => _LimitDialogState();
}

class _LimitDialogState extends State<_LimitDialog> {
  late final TextEditingController _ctrl =
      TextEditingController(text: widget.current.round().toString());
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('${widget.name} · monthly limit'),
      content: TextField(
        controller: _ctrl,
        autofocus: true,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(suffixText: 'DA', errorText: _error),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          onPressed: () {
            final v = parseAmount(_ctrl.text);
            if (v == null || v <= 0) {
              setState(() => _error = 'Enter an amount greater than 0');
              return;
            }
            Navigator.pop(context, v);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
