import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/format.dart';
import '../../core/theme.dart';
import '../../data/models/goal.dart';
import '../../state/goals_provider.dart';
import '../widgets/empty_state.dart';

class GoalsScreen extends ConsumerWidget {
  const GoalsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(goalsProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(kPad, kPad, kPad, 96),
      children: [
        OutlinedButton.icon(
          icon: const Icon(Icons.add),
          label: const Text('New savings goal'),
          onPressed: () async {
            final g = await showDialog<Goal>(
              context: context,
              builder: (_) => const _NewGoalDialog(),
            );
            if (g != null) ref.read(goalsProvider.notifier).add(g);
          },
        ),
        const SizedBox(height: 12),
        if (goals.isEmpty)
          const EmptyState(
            icon: Icons.flag_outlined,
            title: 'No goals yet',
            message: 'Create a goal to see how much to save each month.',
          )
        else
          for (final g in goals)
            _GoalCard(
              goal: g,
              onAdd: () async {
                final v = await showModalBottomSheet<double>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => _ContributeSheet(goalName: g.name),
                );
                if (v != null) ref.read(goalsProvider.notifier).contribute(g.id, v);
              },
            ),
      ],
    );
  }
}

class _GoalCard extends StatelessWidget {
  final Goal goal;
  final VoidCallback onAdd;
  const _GoalCard({required this.goal, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    final done = goal.saved >= goal.target;
    final remaining = math.max(0.0, goal.target - goal.saved);
    final months = math.max(1, (goal.deadline.difference(DateTime.now()).inDays / 30).ceil());
    final perMonth = remaining / months;
    final t = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(kPad),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(child: Text(goal.name, style: t.textTheme.titleMedium)),
                Text('${(goal.progress * 100).round()}%',
                    style: t.textTheme.titleMedium?.copyWith(color: t.colorScheme.primary)),
              ],
            ),
            const SizedBox(height: 4),
            Text('${money(goal.saved)} of ${money(goal.target)}'),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              value: goal.progress,
              minHeight: 10,
              borderRadius: BorderRadius.circular(8),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(done ? Icons.check_circle : Icons.schedule,
                    size: 18, color: done ? incomeColor : t.colorScheme.outline),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    done
                        ? 'Goal reached'
                        : 'Save about ${money(perMonth)} / month to reach it by ${monthYear(goal.deadline)}',
                    style: t.textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: FilledButton.tonalIcon(
                onPressed: onAdd,
                icon: const Icon(Icons.savings_outlined),
                label: const Text('Add money'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContributeSheet extends StatefulWidget {
  final String goalName;
  const _ContributeSheet({required this.goalName});

  @override
  State<_ContributeSheet> createState() => _ContributeSheetState();
}

class _ContributeSheetState extends State<_ContributeSheet> {
  final _ctrl = TextEditingController();
  String? _error;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() {
    final v = parseAmount(_ctrl.text);
    if (v == null || v <= 0) {
      setState(() => _error = 'Enter an amount greater than 0');
      return;
    }
    Navigator.pop(context, v);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(kPad, kPad, kPad, kPad + MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add to "${widget.goalName}"', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              for (final v in const [1000, 5000, 10000])
                ActionChip(
                  label: Text(money(v)),
                  onPressed: () => setState(() {
                    _ctrl.text = v.toString();
                    _error = null;
                  }),
                ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _ctrl,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount',
              suffixText: 'DA',
              border: const OutlineInputBorder(),
              errorText: _error,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: _submit, child: const Text('Add')),
          ),
        ],
      ),
    );
  }
}

class _NewGoalDialog extends StatefulWidget {
  const _NewGoalDialog();

  @override
  State<_NewGoalDialog> createState() => _NewGoalDialogState();
}

class _NewGoalDialogState extends State<_NewGoalDialog> {
  final _name = TextEditingController();
  final _target = TextEditingController();
  DateTime _deadline = DateTime(DateTime.now().year, DateTime.now().month + 6, 1);
  String? _nameError;
  String? _targetError;

  @override
  void dispose() {
    _name.dispose();
    _target.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: context,
      initialDate: _deadline,
      firstDate: now,
      lastDate: DateTime(now.year + 10),
    );
    if (d != null) setState(() => _deadline = d);
  }

  void _submit() {
    final name = _name.text.trim();
    final target = parseAmount(_target.text);
    setState(() {
      _nameError = name.isEmpty ? 'Give your goal a name' : null;
      _targetError = (target == null || target <= 0) ? 'Enter a target greater than 0' : null;
    });
    if (_nameError != null || _targetError != null) return;
    Navigator.pop(
      context,
      Goal(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: name,
        target: target!,
        saved: 0,
        deadline: _deadline,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('New savings goal'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _name,
              autofocus: true,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(labelText: 'Goal name', errorText: _nameError),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _target,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Target amount', suffixText: 'DA', errorText: _targetError),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.event_outlined),
              title: Text('Deadline: ${monthYear(_deadline)}'),
              onTap: _pickDate,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(onPressed: _submit, child: const Text('Create')),
      ],
    );
  }
}
