# Mizaniya

A new Flutter project.

## Localization

The app supports English, French, and Arabic, and starts in French by default.
All user-facing strings live in `lib/l10n/app_en.arb`,
`lib/l10n/app_fr.arb`, and `lib/l10n/app_ar.arb`.
Edit those files to change translations, then regenerate the bindings with:

```bash
flutter gen-l10n
```

Add new keys to the English template first, then copy them into the French and
Arabic files. Arabic automatically renders right-to-left through Flutter's
localization delegates. Users can switch language from Settings.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
