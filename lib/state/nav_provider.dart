import 'package:flutter_riverpod/flutter_riverpod.dart';

/// 0 Home, 1 Transactions, 2 Budget, 3 Goals, 4 Wallets
final tabIndexProvider = StateProvider<int>((ref) => 0);
