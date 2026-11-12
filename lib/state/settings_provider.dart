import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettings {
  final ThemeMode themeMode;
  final Locale locale;
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.locale = const Locale('fr'),
  });

  AppSettings copyWith({ThemeMode? themeMode, Locale? locale}) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    locale: locale ?? this.locale,
  );
}

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() => const AppSettings();

  void setThemeMode(ThemeMode m) => state = state.copyWith(themeMode: m);
  void setLocale(Locale l) => state = state.copyWith(locale: l);
  void reset() => state = const AppSettings();
}

final settingsProvider = NotifierProvider<SettingsNotifier, AppSettings>(
  SettingsNotifier.new,
);
