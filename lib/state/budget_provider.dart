import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Monthly limit per expense category id.
class BudgetNotifier extends Notifier<Map<String, double>> {
  @override
  Map<String, double> build() => {
        'food': 25000,
        'transport': 6000,
        'bills': 12000,
        'shopping': 10000,
        'health': 5000,
        'leisure': 6000,
        'education': 4000,
        'other': 3000,
      };

  void setLimit(String categoryId, double limit) =>
      state = {...state, categoryId: limit};
}

final budgetProvider =
    NotifierProvider<BudgetNotifier, Map<String, double>>(BudgetNotifier.new);
