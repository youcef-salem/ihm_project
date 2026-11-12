import 'package:flutter/material.dart';

import '../../core/l10n.dart';
import '../../state/summary_provider.dart';
import 'money_text.dart';

class BalanceCard extends StatelessWidget {
  final double total;
  final MonthSummary summary;
  const BalanceCard({super.key, required this.total, required this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final s = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: s.primary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.totalBalance,
            style: TextStyle(color: s.onPrimary.withAlpha(200)),
          ),
          const SizedBox(height: 4),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: MoneyText(
              total,
              style: TextStyle(
                color: s.onPrimary,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _Pill(
                  icon: Icons.arrow_downward,
                  label: l10n.incomeThisMonth,
                  value: summary.income,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _Pill(
                  icon: Icons.arrow_upward,
                  label: l10n.spentThisMonth,
                  value: summary.expense,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  final IconData icon;
  final String label;
  final num value;
  const _Pill({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final s = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: s.onPrimary.withAlpha(30),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 18, color: s.onPrimary),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 11,
                    color: s.onPrimary.withAlpha(210),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: MoneyText(
                    value,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: s.onPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
