import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/nav_provider.dart';
import '../screens/add_transaction_screen.dart';
import '../screens/dashboard_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/transactions_screen.dart';
import '../screens/wallets_screen.dart';

class HomeShell extends ConsumerWidget {
  const HomeShell({super.key});

  static const _titles = ['Home', 'Transactions', 'Wallets'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(tabIndexProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[index]),
        actions: [
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => Navigator.of(
              context,
            ).push(MaterialPageRoute(builder: (_) => const SettingsScreen())),
          ),
        ],
      ),
      body: IndexedStack(
        index: index,
        children: const [
          DashboardScreen(),
          TransactionsScreen(),
          WalletsScreen(),
        ],
      ),
      // Same primary action reachable from every tab.
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.of(
          context,
        ).push(MaterialPageRoute(builder: (_) => const AddTransactionScreen())),
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) =>
            ref.read(tabIndexProvider.notifier).state = i,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon: Icon(Icons.receipt_long),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet),
            label: 'Wallets',
          ),
        ],
      ),
    );
  }
}
