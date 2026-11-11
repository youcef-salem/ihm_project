import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/goal.dart';
import 'mock_seed.dart';

class GoalsNotifier extends Notifier<List<Goal>> {
  @override
  List<Goal> build() => seedGoals();

  void add(Goal g) => state = [...state, g];

  void contribute(String id, double amount) => state = [
        for (final g in state)
          g.id == id ? g.copyWith(saved: g.saved + amount) : g,
      ];
}

final goalsProvider =
    NotifierProvider<GoalsNotifier, List<Goal>>(GoalsNotifier.new);
