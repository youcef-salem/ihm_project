import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/theme.dart';
import 'state/settings_provider.dart';
import 'ui/shell/home_shell.dart';

class EcoBudgetApp extends ConsumerWidget {
  const EcoBudgetApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    return MaterialApp(
      title: 'EcoBudget',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: settings.themeMode,
      // Adaptability: user-controlled text size applied app-wide.
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: TextScaler.linear(settings.textScale)),
        child: child!,
      ),
      home: const HomeShell(),
    );
  }
}
