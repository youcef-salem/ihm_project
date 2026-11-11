import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppSettings {
  final ThemeMode themeMode;
  final double textScale;
  const AppSettings({this.themeMode = ThemeMode.system, this.textScale = 1.0});

  AppSettings copyWith({ThemeMode? themeMode, double? textScale}) => AppSettings(
        themeMode: themeMode ?? this.themeMode,
        textScale: textScale ?? this.textScale,
      );
}

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() => const AppSettings();

  void setThemeMode(ThemeMode m) => state = state.copyWith(themeMode: m);
  void setTextScale(double s) => state = state.copyWith(textScale: s);
  void reset() => state = const AppSettings();
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);
