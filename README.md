# Mizaniya

**Mizaniya** (ميزانية, "budget") is a simple, offline budget tracker built with
Flutter. It helps you record expenses and income, keep an eye on multiple
wallets, and understand where your money goes each month.

The interface is designed around human-computer interaction principles
(Bastien & Scapin): clear guidance, low workload, explicit control, error
prevention, and consistency. See [`CRITERIA.md`](CRITERIA.md) for the full
criterion-to-feature mapping.

## Features

- **Dashboard** — total balance across wallets, this month's income and
  expenses, a spending-by-category donut chart, recent transactions, and a card
  highlighting unusually large expenses.
- **Transactions** — grouped by date, searchable by title or category, filterable
  by income/expense, swipe to delete with **Undo**.
- **Wallets** — track cash, bank, card, and savings accounts with per-wallet and
  combined balances.
- **Add transaction** — expense/income switch, inline validation, quick-amount
  chips (+500, +1000, +2000, +5000), category and wallet selection, optional
  description, and a date picker that refuses future dates.
- **Smart safeguards** — live warning when an expense exceeds the selected
  wallet's balance, a confirmation dialog before going into overdraft, and an
  automatic flag for expenses more than twice your average for that category.
- **Personalisation** — light, dark, or system theme.
- **Localization** — English, French, and Arabic with automatic right-to-left
  layout. The app starts in French by default.
- **Algerian context** — amounts are formatted in DA (dinar) with thousands
  grouping, and wallet types map to local usage (cash, CCP bank, card).

## Tech stack

- [Flutter](https://flutter.dev/) (Dart SDK `^3.10.0`)
- [Riverpod](https://riverpod.dev/) for state management
- [flutter_localizations](https://docs.flutter.dev/ui/accessibility-and-localization/internationalization)
  + [intl](https://pub.dev/packages/intl) for translations and date/money
  formatting

There is **no backend**. All data lives in in-memory app state and is seeded with
sample transactions and wallets on launch, so changes are reset when the app
restarts.

## Getting started

### Prerequisites

- Flutter SDK installed (`flutter --version`)
- A target platform: Android, iOS, web, Windows, macOS, or Linux

### Install and run

```bash
flutter pub get
flutter run
```

To pick a specific device:

```bash
flutter devices
flutter run -d <device-id>
```

### Run the tests

```bash
flutter test
```

### Static analysis

```bash
flutter analyze
```

## Localization

The app supports English, French, and Arabic. All user-facing strings live in:

- `lib/l10n/app_en.arb` (template)
- `lib/l10n/app_fr.arb`
- `lib/l10n/app_ar.arb`

Edit those files to change translations, then regenerate the bindings with:

```bash
flutter gen-l10n
```

Add new keys to the English template first, then copy them into the French and
Arabic files. Arabic automatically renders right-to-left through Flutter's
localization delegates. Users can switch language from **Settings**.

## Project structure

```text
lib/
├── main.dart                  # Entry point (Riverpod ProviderScope)
├── app.dart                   # MaterialApp: theme, locale, shell
├── core/                      # Shared helpers
│   ├── categories.dart        # Expense/income categories + icons/colors
│   ├── format.dart            # Money, date, and amount parsing
│   ├── l10n.dart              # Localization extensions
│   ├── theme.dart             # Light/dark themes
│   └── wallet_kinds.dart      # Wallet kind icons and labels
├── data/                      # Models + pure calculations (no backend)
│   ├── models/                # Transaction, Wallet
│   └── calculations/          # Summary, wallet balances, filtering, unusual
├── l10n/                      # .arb files + generated bindings
├── state/                     # Riverpod notifiers + in-memory seed data
└── ui/
    ├── shell/                 # Bottom navigation shell
    ├── screens/               # Dashboard, Transactions, Wallets, Add, Settings
    └── widgets/               # Reusable cards, tiles, charts, empty states
```

The `data/` layer contains only pure functions; the `state/` notifiers hold
mutable app state and delegate every calculation to it.

## Data model

- **Wallet** — `id`, `name`, `kind` (`cash`, `bank`, `card`, `savings`), and
  `initialBalance`.
- **Transaction** — `id`, `title`, positive `amount`, `type`
  (`expense`/`income`), `categoryId`, `walletId`, `date`, and an `isUnusual`
  flag computed once at entry time.
- **Balance** — computed as `initialBalance + income − expenses` per wallet.

## License

This project was built for academic purposes and has no license file yet.
