import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/l10n.dart';
import '../../core/theme.dart';
import '../../state/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final s = ref.watch(settingsProvider);
    final notifier = ref.read(settingsProvider.notifier);
    final t = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(kPad),
        children: [
          Text(l10n.language, style: t.textTheme.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<Locale>(
            showSelectedIcon: false,
            segments: [
              ButtonSegment(
                value: const Locale('en'),
                label: Text(l10n.english),
              ),
              ButtonSegment(
                value: const Locale('fr'),
                label: Text(l10n.french),
              ),
              ButtonSegment(
                value: const Locale('ar'),
                label: Text(l10n.arabic),
              ),
            ],
            selected: {s.locale},
            onSelectionChanged: (v) => notifier.setLocale(v.first),
          ),
          const SizedBox(height: 24),
          Text(l10n.appearance, style: t.textTheme.titleMedium),
          const SizedBox(height: 8),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(
                value: ThemeMode.system,
                label: Text(l10n.themeAuto),
                icon: const Icon(Icons.brightness_auto),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                label: Text(l10n.themeLight),
                icon: const Icon(Icons.light_mode_outlined),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                label: Text(l10n.themeDark),
                icon: const Icon(Icons.dark_mode_outlined),
              ),
            ],
            selected: {s.themeMode},
            onSelectionChanged: (v) => notifier.setThemeMode(v.first),
          ),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: notifier.reset,
            icon: const Icon(Icons.restore),
            label: Text(l10n.resetToDefaults),
          ),
        ],
      ),
    );
  }
}
